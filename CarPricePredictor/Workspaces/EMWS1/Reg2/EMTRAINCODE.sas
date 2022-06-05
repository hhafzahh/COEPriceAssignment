*------------------------------------------------------------*;
* Reg2: Create decision matrix;
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
data EM_DMREG / view=EM_DMREG;
set EMWS1.Part2_TRAIN(keep=
Adj_Prem Adjusted_Quota vehicle_class);
run;
*------------------------------------------------------------* ;
* Reg2: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    vehicle_class(ASC)
%mend DMDBClass;
*------------------------------------------------------------* ;
* Reg2: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    Adj_Prem Adjusted_Quota
%mend DMDBVar;
*------------------------------------------------------------*;
* Reg2: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=WORK.EM_DMREG
dmdbcat=WORK.Reg2_DMDB
maxlevel = 513
;
class %DMDBClass;
var %DMDBVar;
target
Adj_Prem
;
run;
quit;
*------------------------------------------------------------*;
* Reg2: Run DMREG procedure;
*------------------------------------------------------------*;
proc dmreg data=EM_DMREG dmdbcat=WORK.Reg2_DMDB
outest = EMWS1.Reg2_EMESTIMATE
outterms = EMWS1.Reg2_OUTTERMS
outmap= EMWS1.Reg2_MAPDS namelen=200
;
class
vehicle_class
;
model Adj_Prem =
Adjusted_Quota
vehicle_class
/error=normal
coding=DEVIATION
nodesignprint
;
;
score data=EMWS1.Part2_TEST
out=_null_
outfit=EMWS1.Reg2_FITTEST
role = TEST
;
code file="C:\Users\2001231F\Desktop\Predictive\Workspaces\EMWS1\Reg2\EMPUBLISHSCORE.sas"
group=Reg2
;
code file="C:\Users\2001231F\Desktop\Predictive\Workspaces\EMWS1\Reg2\EMFLOWSCORE.sas"
group=Reg2
residual
;
run;
quit;
