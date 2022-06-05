*------------------------------------------------------------*;
* Neural2: Create decision matrix;
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
data EM_Neural2;
set EMWS2.Part_TRAIN(keep=
Adj_Prem Adjusted_Quota vehicle_class);
run;
*------------------------------------------------------------* ;
* Neural2: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    vehicle_class(ASC)
%mend DMDBClass;
*------------------------------------------------------------* ;
* Neural2: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    Adj_Prem Adjusted_Quota
%mend DMDBVar;
*------------------------------------------------------------*;
* Neural2: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=WORK.EM_Neural2
dmdbcat=WORK.Neural2_DMDB
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
* Neural2: Interval Input Variables Macro ;
*------------------------------------------------------------* ;
%macro INTINPUTS;
    Adjusted_Quota
%mend INTINPUTS;
*------------------------------------------------------------* ;
* Neural2: Binary Inputs Macro ;
*------------------------------------------------------------* ;
%macro BININPUTS;

%mend BININPUTS;
*------------------------------------------------------------* ;
* Neural2: Nominal Inputs Macro ;
*------------------------------------------------------------* ;
%macro NOMINPUTS;
    vehicle_class
%mend NOMINPUTS;
*------------------------------------------------------------* ;
* Neural2: Ordinal Inputs Macro ;
*------------------------------------------------------------* ;
%macro ORDINPUTS;

%mend ORDINPUTS;
*------------------------------------------------------------*;
* Neural Network Training;
;
*------------------------------------------------------------*;
proc neural data=EM_Neural2 dmdbcat=WORK.Neural2_DMDB
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
Outest=EMWS2.Neural2_PRELIM_OUTEST
;
save network=EMWS2.Neural2_NETWORK.dm_neural;
train Maxiter=150
maxtime=14400
Outest=EMWS2.Neural2_outest estiter=1
Outfit=EMWS2.Neural2_OUTFIT
;
run;
quit;
proc sort data=EMWS2.Neural2_OUTFIT(where=(_iter_ ne . and _NAME_="OVERALL")) out=fit_Neural2;
by _MISC_;
run;
%GLOBAL ITER;
data _null_;
set fit_Neural2(obs=1);
call symput('ITER',put(_ITER_, 6.));
run;
data EMWS2.Neural2_INITIAL;
set EMWS2.Neural2_outest(where=(_ITER_ eq &ITER and _OBJ_ ne .));
run;
*------------------------------------------------------------*;
* Neural Network Model Selection;
;
*------------------------------------------------------------*;
proc neural data=EM_Neural2 dmdbcat=WORK.Neural2_DMDB
network = EMWS2.Neural2_NETWORK.dm_neural
random=12345
;
nloptions noprint;
performance alldetails noutilfile;
initial inest=EMWS2.Neural2_INITIAL;
train tech=NONE;
code file="C:\Users\2001231F\Desktop\Predictive\Workspaces\EMWS2\Neural2\SCORECODE.sas"
group=Neural2
;
;
code file="C:\Users\2001231F\Desktop\Predictive\Workspaces\EMWS2\Neural2\RESIDUALSCORECODE.sas"
group=Neural2
residual
;
;
score data=EMWS2.Part_TRAIN out=_NULL_
outfit=WORK.FIT1
role=TRAIN
outkey=EMWS2.Neural2_OUTKEY;
score data=EMWS2.Part_TEST out=_NULL_
outfit=WORK.FIT2
role=TEST
outkey=EMWS2.Neural2_OUTKEY;
run;
quit;
data EMWS2.Neural2_OUTFIT;
merge WORK.FIT1 WORK.FIT2;
run;
data EMWS2.Neural2_EMESTIMATE;
set EMWS2.Neural2_outest;
if _type_ ^in('HESSIAN' 'GRAD');
run;
proc datasets lib=work nolist;
delete EM_Neural2;
run;
quit;
