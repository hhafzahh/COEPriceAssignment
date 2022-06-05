*------------------------------------------------------------*;
* Neural4: Create decision matrix;
*------------------------------------------------------------*;
data WORK.Adj_Prem(label="Adj_Prem");
  length   Adj_Prem                             8
           ;

 Adj_Prem=20894;
output;
 Adj_Prem=98950;
output;
 Adj_Prem=60939.5490196078;
output;
;
run;
proc datasets lib=work nolist;
modify Adj_Prem(type=PROFIT label=Adj_Prem);
run;
quit;
data EM_Neural4;
set EMWS1.Part2_TRAIN(keep=
Adj_Prem Adjusted_Quota vehicle_class);
run;
*------------------------------------------------------------* ;
* Neural4: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    vehicle_class(ASC)
%mend DMDBClass;
*------------------------------------------------------------* ;
* Neural4: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    Adj_Prem Adjusted_Quota
%mend DMDBVar;
*------------------------------------------------------------*;
* Neural4: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=WORK.EM_Neural4
dmdbcat=WORK.Neural4_DMDB
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
* Neural4: Interval Input Variables Macro ;
*------------------------------------------------------------* ;
%macro INTINPUTS;
    Adjusted_Quota
%mend INTINPUTS;
*------------------------------------------------------------* ;
* Neural4: Binary Inputs Macro ;
*------------------------------------------------------------* ;
%macro BININPUTS;

%mend BININPUTS;
*------------------------------------------------------------* ;
* Neural4: Nominal Inputs Macro ;
*------------------------------------------------------------* ;
%macro NOMINPUTS;
    vehicle_class
%mend NOMINPUTS;
*------------------------------------------------------------* ;
* Neural4: Ordinal Inputs Macro ;
*------------------------------------------------------------* ;
%macro ORDINPUTS;

%mend ORDINPUTS;
*------------------------------------------------------------*;
* Neural Network Training;
;
*------------------------------------------------------------*;
proc neural data=EM_Neural4 dmdbcat=WORK.Neural4_DMDB
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
Outest=EMWS1.Neural4_PRELIM_OUTEST
;
save network=EMWS1.Neural4_NETWORK.dm_neural;
train Maxiter=150
maxtime=14400
Outest=EMWS1.Neural4_outest estiter=1
Outfit=EMWS1.Neural4_OUTFIT
;
run;
quit;
proc sort data=EMWS1.Neural4_OUTFIT(where=(_iter_ ne . and _NAME_="OVERALL")) out=fit_Neural4;
by _MISC_;
run;
%GLOBAL ITER;
data _null_;
set fit_Neural4(obs=1);
call symput('ITER',put(_ITER_, 6.));
run;
data EMWS1.Neural4_INITIAL;
set EMWS1.Neural4_outest(where=(_ITER_ eq &ITER and _OBJ_ ne .));
run;
*------------------------------------------------------------*;
* Neural Network Model Selection;
;
*------------------------------------------------------------*;
proc neural data=EM_Neural4 dmdbcat=WORK.Neural4_DMDB
network = EMWS1.Neural4_NETWORK.dm_neural
random=12345
;
nloptions noprint;
performance alldetails noutilfile;
initial inest=EMWS1.Neural4_INITIAL;
train tech=NONE;
code file="C:\Users\2001231F\Desktop\Predictive\Workspaces\EMWS1\Neural4\SCORECODE.sas"
group=Neural4
;
;
code file="C:\Users\2001231F\Desktop\Predictive\Workspaces\EMWS1\Neural4\RESIDUALSCORECODE.sas"
group=Neural4
residual
;
;
score data=EMWS1.Part2_TRAIN out=_NULL_
outfit=WORK.FIT1
role=TRAIN
outkey=EMWS1.Neural4_OUTKEY;
score data=EMWS1.Part2_TEST out=_NULL_
outfit=WORK.FIT2
role=TEST
outkey=EMWS1.Neural4_OUTKEY;
run;
quit;
data EMWS1.Neural4_OUTFIT;
merge WORK.FIT1 WORK.FIT2;
run;
data EMWS1.Neural4_EMESTIMATE;
set EMWS1.Neural4_outest;
if _type_ ^in('HESSIAN' 'GRAD');
run;
proc datasets lib=work nolist;
delete EM_Neural4;
run;
quit;
