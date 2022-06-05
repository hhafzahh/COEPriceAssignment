*------------------------------------------------------------*;
* Neural8: Create decision matrix;
*------------------------------------------------------------*;
data WORK.premium(label="premium");
  length   premium                              8
           ;

 premium=18502;
output;
 premium=99010;
output;
 premium=52267.0146699266;
output;
;
run;
proc datasets lib=work nolist;
modify premium(type=PROFIT label=premium);
run;
quit;
data EM_Neural8;
set EMWS1.Part4_TRAIN(keep=
bidding_no bids_received bids_success premium quota vehicle_class);
run;
*------------------------------------------------------------* ;
* Neural8: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    bidding_no(ASC) vehicle_class(ASC)
%mend DMDBClass;
*------------------------------------------------------------* ;
* Neural8: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    bids_received bids_success premium quota
%mend DMDBVar;
*------------------------------------------------------------*;
* Neural8: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=WORK.EM_Neural8
dmdbcat=WORK.Neural8_DMDB
maxlevel = 513
;
class %DMDBClass;
var %DMDBVar;
target
premium
;
run;
quit;
*------------------------------------------------------------* ;
* Neural8: Interval Input Variables Macro ;
*------------------------------------------------------------* ;
%macro INTINPUTS;
    bids_received bids_success quota
%mend INTINPUTS;
*------------------------------------------------------------* ;
* Neural8: Binary Inputs Macro ;
*------------------------------------------------------------* ;
%macro BININPUTS;

%mend BININPUTS;
*------------------------------------------------------------* ;
* Neural8: Nominal Inputs Macro ;
*------------------------------------------------------------* ;
%macro NOMINPUTS;
    bidding_no vehicle_class
%mend NOMINPUTS;
*------------------------------------------------------------* ;
* Neural8: Ordinal Inputs Macro ;
*------------------------------------------------------------* ;
%macro ORDINPUTS;

%mend ORDINPUTS;
*------------------------------------------------------------*;
* Neural Network Training;
;
*------------------------------------------------------------*;
proc neural data=EM_Neural8 dmdbcat=WORK.Neural8_DMDB
random=12345
;
nloptions
;
performance alldetails noutilfile;
netopts
decay=0;
input %INTINPUTS / level=interval id=intvl
;
input %NOMINPUTS / level=nominal id=nom
;
target
premium
/ level=interval id=intervalTargets
bias
;
arch MLP
Hidden=20
;
Prelim 5 preiter=10
pretime=3600
Outest=EMWS1.Neural8_PRELIM_OUTEST
;
save network=EMWS1.Neural8_NETWORK.dm_neural;
train Maxiter=150
maxtime=14400
Outest=EMWS1.Neural8_outest estiter=1
Outfit=EMWS1.Neural8_OUTFIT
;
run;
quit;
proc sort data=EMWS1.Neural8_OUTFIT(where=(_iter_ ne . and _NAME_="OVERALL")) out=fit_Neural8;
by _MISC_;
run;
%GLOBAL ITER;
data _null_;
set fit_Neural8(obs=1);
call symput('ITER',put(_ITER_, 6.));
run;
data EMWS1.Neural8_INITIAL;
set EMWS1.Neural8_outest(where=(_ITER_ eq &ITER and _OBJ_ ne .));
run;
*------------------------------------------------------------*;
* Neural Network Model Selection;
;
*------------------------------------------------------------*;
proc neural data=EM_Neural8 dmdbcat=WORK.Neural8_DMDB
network = EMWS1.Neural8_NETWORK.dm_neural
random=12345
;
nloptions noprint;
performance alldetails noutilfile;
initial inest=EMWS1.Neural8_INITIAL;
train tech=NONE;
code file="C:\Users\2001231F\Desktop\Predictive\Workspaces\EMWS1\Neural8\SCORECODE.sas"
group=Neural8
;
;
code file="C:\Users\2001231F\Desktop\Predictive\Workspaces\EMWS1\Neural8\RESIDUALSCORECODE.sas"
group=Neural8
residual
;
;
score data=EMWS1.Part4_TRAIN out=_NULL_
outfit=WORK.FIT1
role=TRAIN
outkey=EMWS1.Neural8_OUTKEY;
score data=EMWS1.Part4_TEST out=_NULL_
outfit=WORK.FIT2
role=TEST
outkey=EMWS1.Neural8_OUTKEY;
run;
quit;
data EMWS1.Neural8_OUTFIT;
merge WORK.FIT1 WORK.FIT2;
run;
data EMWS1.Neural8_EMESTIMATE;
set EMWS1.Neural8_outest;
if _type_ ^in('HESSIAN' 'GRAD');
run;
proc datasets lib=work nolist;
delete EM_Neural8;
run;
quit;
