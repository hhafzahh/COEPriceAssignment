*------------------------------------------------------------*;
* Reg4: Create decision matrix;
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
data EM_DMREG / view=EM_DMREG;
set EMWS1.Part4_TRAIN(keep=
bidding_no bids_received bids_success premium quota vehicle_class);
run;
*------------------------------------------------------------* ;
* Reg4: DMDBClass Macro ;
*------------------------------------------------------------* ;
%macro DMDBClass;
    bidding_no(ASC) vehicle_class(ASC)
%mend DMDBClass;
*------------------------------------------------------------* ;
* Reg4: DMDBVar Macro ;
*------------------------------------------------------------* ;
%macro DMDBVar;
    bids_received bids_success premium quota
%mend DMDBVar;
*------------------------------------------------------------*;
* Reg4: Create DMDB;
*------------------------------------------------------------*;
proc dmdb batch data=WORK.EM_DMREG
dmdbcat=WORK.Reg4_DMDB
maxlevel = 513
;
class %DMDBClass;
var %DMDBVar;
target
premium
;
run;
quit;
*------------------------------------------------------------*;
* Reg4: Run DMREG procedure;
*------------------------------------------------------------*;
proc dmreg data=EM_DMREG dmdbcat=WORK.Reg4_DMDB
outest = EMWS1.Reg4_EMESTIMATE
outterms = EMWS1.Reg4_OUTTERMS
outmap= EMWS1.Reg4_MAPDS namelen=200
;
class
bidding_no
vehicle_class
;
model premium =
bidding_no
bids_received
bids_success
quota
vehicle_class
/error=normal
coding=DEVIATION
nodesignprint
;
;
score data=EMWS1.Part4_TEST
out=_null_
outfit=EMWS1.Reg4_FITTEST
role = TEST
;
code file="C:\Users\2001231F\Desktop\Predictive\Workspaces\EMWS1\Reg4\EMPUBLISHSCORE.sas"
group=Reg4
;
code file="C:\Users\2001231F\Desktop\Predictive\Workspaces\EMWS1\Reg4\EMFLOWSCORE.sas"
group=Reg4
residual
;
run;
quit;
