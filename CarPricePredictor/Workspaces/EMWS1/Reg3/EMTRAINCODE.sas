*------------------------------------------------------------*;
* Reg3: Create decision matrix;
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
data EM_DMREG / view=EM_DMREG;
set EMWS1.Part3_TRAIN(keep=
Adj_Prem Adjusted_Quota vehicle_class);
run;
*------------------------------------------------------------* ;
* Reg3: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    vehicle_class(ASC)
%mend DMDBClass;
*------------------------------------------------------------* ;
* Reg3: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    Adj_Prem Adjusted_Quota
%mend DMDBVar;
*------------------------------------------------------------*;
* Reg3: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=WORK.EM_DMREG
dmdbcat=WORK.Reg3_DMDB
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
* Reg3: Run DMREG procedure;
*------------------------------------------------------------*;
proc dmreg data=EM_DMREG dmdbcat=WORK.Reg3_DMDB
outest = EMWS1.Reg3_EMESTIMATE
outterms = EMWS1.Reg3_OUTTERMS
outmap= EMWS1.Reg3_MAPDS namelen=200
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
score data=EMWS1.Part3_TEST
out=_null_
outfit=EMWS1.Reg3_FITTEST
role = TEST
;
code file="C:\Users\2001231F\Desktop\Predictive\Workspaces\EMWS1\Reg3\EMPUBLISHSCORE.sas"
group=Reg3
;
code file="C:\Users\2001231F\Desktop\Predictive\Workspaces\EMWS1\Reg3\EMFLOWSCORE.sas"
group=Reg3
residual
;
run;
quit;
