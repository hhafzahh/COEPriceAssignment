*------------------------------------------------------------*;
* Neural6: Create decision matrix;
*------------------------------------------------------------*;
data WORK.Adj_Prem(label="Adj_Prem");
  length   Adj_Prem                             8
           ;

 Adj_Prem=20795;
output;
 Adj_Prem=98950;
output;
 Adj_Prem=59622.9019607843;
output;
;
run;
proc datasets lib=work nolist;
modify Adj_Prem(type=PROFIT label=Adj_Prem);
run;
quit;
data EM_Neural6;
set EMWS1.Part3_TRAIN(keep=
Adj_Prem Adjusted_Quota vehicle_class);
run;
*------------------------------------------------------------* ;
* Neural6: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    vehicle_class(ASC)
%mend DMDBClass;
*------------------------------------------------------------* ;
* Neural6: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    Adj_Prem Adjusted_Quota
%mend DMDBVar;
*------------------------------------------------------------*;
* Neural6: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=WORK.EM_Neural6
dmdbcat=WORK.Neural6_DMDB
maxlevel = 513
;
class %DMDBClass;
var %DMDBVar;
target
Adj_Prem
;
run;
quit;
*------------------------------------------------------------* ;
* Neural6: Interval Input Variables Macro ;
*------------------------------------------------------------* ;
%macro INTINPUTS;
    Adjusted_Quota
%mend INTINPUTS;
*------------------------------------------------------------* ;
* Neural6: Binary Inputs Macro ;
*------------------------------------------------------------* ;
%macro BININPUTS;

%mend BININPUTS;
*------------------------------------------------------------* ;
* Neural6: Nominal Inputs Macro ;
*------------------------------------------------------------* ;
%macro NOMINPUTS;
    vehicle_class
%mend NOMINPUTS;
*------------------------------------------------------------* ;
* Neural6: Ordinal Inputs Macro ;
*------------------------------------------------------------* ;
%macro ORDINPUTS;

%mend ORDINPUTS;
*------------------------------------------------------------*;
* Neural Network Training;
;
*------------------------------------------------------------*;
proc neural data=EM_Neural6 dmdbcat=WORK.Neural6_DMDB
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
Adj_Prem
/ level=interval id=intervalTargets
bias
;
arch MLP
Hidden=20
;
Prelim 5 preiter=10
pretime=3600
Outest=EMWS1.Neural6_PRELIM_OUTEST
;
save network=EMWS1.Neural6_NETWORK.dm_neural;
train Maxiter=150
maxtime=14400
Outest=EMWS1.Neural6_outest estiter=1
Outfit=EMWS1.Neural6_OUTFIT
;
run;
quit;
proc sort data=EMWS1.Neural6_OUTFIT(where=(_iter_ ne . and _NAME_="OVERALL")) out=fit_Neural6;
by _MISC_;
run;
%GLOBAL ITER;
data _null_;
set fit_Neural6(obs=1);
call symput('ITER',put(_ITER_, 6.));
run;
data EMWS1.Neural6_INITIAL;
set EMWS1.Neural6_outest(where=(_ITER_ eq &ITER and _OBJ_ ne .));
run;
*------------------------------------------------------------*;
* Neural Network Model Selection;
;
*------------------------------------------------------------*;
proc neural data=EM_Neural6 dmdbcat=WORK.Neural6_DMDB
network = EMWS1.Neural6_NETWORK.dm_neural
random=12345
;
nloptions noprint;
performance alldetails noutilfile;
initial inest=EMWS1.Neural6_INITIAL;
train tech=NONE;
code file="C:\Users\2001231F\Desktop\Predictive\Workspaces\EMWS1\Neural6\SCORECODE.sas"
group=Neural6
;
;
code file="C:\Users\2001231F\Desktop\Predictive\Workspaces\EMWS1\Neural6\RESIDUALSCORECODE.sas"
group=Neural6
residual
;
;
score data=EMWS1.Part3_TRAIN out=_NULL_
outfit=WORK.FIT1
role=TRAIN
outkey=EMWS1.Neural6_OUTKEY;
score data=EMWS1.Part3_TEST out=_NULL_
outfit=WORK.FIT2
role=TEST
outkey=EMWS1.Neural6_OUTKEY;
run;
quit;
data EMWS1.Neural6_OUTFIT;
merge WORK.FIT1 WORK.FIT2;
run;
data EMWS1.Neural6_EMESTIMATE;
set EMWS1.Neural6_outest;
if _type_ ^in('HESSIAN' 'GRAD');
run;
proc datasets lib=work nolist;
delete EM_Neural6;
run;
quit;
