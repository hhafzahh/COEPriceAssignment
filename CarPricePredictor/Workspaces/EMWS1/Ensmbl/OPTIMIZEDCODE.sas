*------------------------------------------------------------*;
* TOOL: Extension Class;
* TYPE: SAMPLE;
* NODE: FIMPORT4;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* TOOL: Partition Class;
* TYPE: SAMPLE;
* NODE: Part4;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* TOOL: Regression;
* TYPE: MODEL;
* NODE: Reg4;
*------------------------------------------------------------*;
*************************************;
*** begin scoring code for regression;
*************************************;

length _WARN_ $4;
label _WARN_ = 'Warnings' ;


drop _DM_BAD;
_DM_BAD=0;

*** Check bids_received for missing values ;
if missing( bids_received ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check bids_success for missing values ;
if missing( bids_success ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Check quota for missing values ;
if missing( quota ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Generate dummy variables for bidding_no ;
drop _0_0 ;
if missing( bidding_no ) then do;
   _0_0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( bidding_no , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '2'  then do;
      _0_0 = -1;
   end;
   else if _dm12 = '1'  then do;
      _0_0 = 1;
   end;
   else do;
      _0_0 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for vehicle_class ;
drop _1_0 _1_1 _1_2 ;
if missing( vehicle_class ) then do;
   _1_0 = .;
   _1_1 = .;
   _1_2 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm10 $ 10; drop _dm10 ;
   _dm10 = put( vehicle_class , $10. );
   %DMNORMIP( _dm10 )
   if _dm10 = 'CATEGORY C'  then do;
      _1_0 = 0;
      _1_1 = 0;
      _1_2 = 1;
   end;
   else if _dm10 = 'CATEGORY E'  then do;
      _1_0 = -1;
      _1_1 = -1;
      _1_2 = -1;
   end;
   else if _dm10 = 'CATEGORY A'  then do;
      _1_0 = 1;
      _1_1 = 0;
      _1_2 = 0;
   end;
   else if _dm10 = 'CATEGORY B'  then do;
      _1_0 = 0;
      _1_1 = 1;
      _1_2 = 0;
   end;
   else do;
      _1_0 = .;
      _1_1 = .;
      _1_2 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** If missing inputs, use averages;
if _DM_BAD > 0 then do;
   _LP0 =     52267.0146699266;
   goto REG4DR1;
end;

*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;

***  Effect: bidding_no ;
_TEMP = 1;
_LP0 = _LP0 + (     154.78171779873) * _TEMP * _0_0;

***  Effect: bids_received ;
_TEMP = bids_received ;
_LP0 = _LP0 + (   -1.65183626346696 * _TEMP);

***  Effect: bids_success ;
_TEMP = bids_success ;
_LP0 = _LP0 + (    46.4559314446893 * _TEMP);

***  Effect: quota ;
_TEMP = quota ;
_LP0 = _LP0 + (   -65.5124630114934 * _TEMP);

***  Effect: vehicle_class ;
_TEMP = 1;
_LP0 = _LP0 + (    6873.40293268137) * _TEMP * _1_0;
_LP0 = _LP0 + (    10391.0287458284) * _TEMP * _1_1;
_LP0 = _LP0 + (   -18339.1093245778) * _TEMP * _1_2;
*--- Intercept ---*;
_LP0 = _LP0 + (    66214.5992606009);

REG4DR1:

*** Predicted Value;
label P_premium = 'Predicted: premium' ;
P_premium = _LP0;


*************************************;
***** end scoring code for regression;
*************************************;
* Renaming variables for Reg4;
*------------------------------------------------------------*;
* Renaming Predicted variable for Reg4;
*------------------------------------------------------------*;
drop Reg4_P_premium;
Reg4_P_premium = P_premium;
*------------------------------------------------------------*;
* Renaming _WARN_ variable for Reg4;
*------------------------------------------------------------*;
length Reg4_WARN_ $4;
drop Reg4_WARN_;
Reg4_WARN_ = _WARN_;
*------------------------------------------------------------*;
* TOOL: Extension Class;
* TYPE: SAMPLE;
* NODE: FIMPORT4;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* TOOL: Partition Class;
* TYPE: SAMPLE;
* NODE: Part4;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* TOOL: Neural;
* TYPE: MODEL;
* NODE: Neural7;
*------------------------------------------------------------*;
***********************************;
*** Begin Scoring Code for Neural;
***********************************;
DROP _DM_BAD _EPS _NOCL_ _MAX_ _MAXP_ _SUM_ _NTRIALS;
 _DM_BAD = 0;
 _NOCL_ = .;
 _MAX_ = .;
 _MAXP_ = .;
 _SUM_ = .;
 _NTRIALS = .;
 _EPS =                1E-10;
LENGTH _WARN_ $4
;
      label S_bids_received = 'Standard: bids_received' ;

      label S_bids_success = 'Standard: bids_success' ;

      label S_quota = 'Standard: quota' ;

      label bidding_no1 = 'Dummy: bidding_no=1' ;

      label vehicle_classCategory_A = 'Dummy: vehicle_class=Category A' ;

      label vehicle_classCategory_B = 'Dummy: vehicle_class=Category B' ;

      label vehicle_classCategory_C = 'Dummy: vehicle_class=Category C' ;

      label H11 = 'Hidden: H1=1' ;

      label H12 = 'Hidden: H1=2' ;

      label H13 = 'Hidden: H1=3' ;

      label P_premium = 'Predicted: premium' ;

      label  _WARN_ = "Warnings";

*** Generate dummy variables for bidding_no ;
drop bidding_no1 ;
if missing( bidding_no ) then do;
   bidding_no1 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( bidding_no , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '2'  then do;
      bidding_no1 = -1;
   end;
   else if _dm12 = '1'  then do;
      bidding_no1 = 1;
   end;
   else do;
      bidding_no1 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for vehicle_class ;
drop vehicle_classCategory_A vehicle_classCategory_B vehicle_classCategory_C ;
if missing( vehicle_class ) then do;
   vehicle_classCategory_A = .;
   vehicle_classCategory_B = .;
   vehicle_classCategory_C = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm10 $ 10; drop _dm10 ;
   _dm10 = put( vehicle_class , $10. );
   %DMNORMIP( _dm10 )
   if _dm10 = 'CATEGORY C'  then do;
      vehicle_classCategory_A = 0;
      vehicle_classCategory_B = 0;
      vehicle_classCategory_C = 1;
   end;
   else if _dm10 = 'CATEGORY E'  then do;
      vehicle_classCategory_A = -1;
      vehicle_classCategory_B = -1;
      vehicle_classCategory_C = -1;
   end;
   else if _dm10 = 'CATEGORY A'  then do;
      vehicle_classCategory_A = 1;
      vehicle_classCategory_B = 0;
      vehicle_classCategory_C = 0;
   end;
   else if _dm10 = 'CATEGORY B'  then do;
      vehicle_classCategory_A = 0;
      vehicle_classCategory_B = 1;
      vehicle_classCategory_C = 0;
   end;
   else do;
      vehicle_classCategory_A = .;
      vehicle_classCategory_B = .;
      vehicle_classCategory_C = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** *************************;
*** Checking missing input Interval
*** *************************;

IF NMISS(
   bids_received ,
   bids_success ,
   quota   ) THEN DO;
   SUBSTR(_WARN_, 1, 1) = 'M';

   _DM_BAD = 1;
END;
*** *************************;
*** Writing the Node intvl ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   S_bids_received  =    -1.31093674204929 +     0.00140604410956 *
        bids_received ;
   S_bids_success  =    -1.26184127516965 +     0.00207016049492 *
        bids_success ;
   S_quota  =    -1.27286406186031 +     0.00206044130093 * quota ;
END;
ELSE DO;
   IF MISSING( bids_received ) THEN S_bids_received  = . ;
   ELSE S_bids_received  =    -1.31093674204929 +     0.00140604410956 *
        bids_received ;
   IF MISSING( bids_success ) THEN S_bids_success  = . ;
   ELSE S_bids_success  =    -1.26184127516965 +     0.00207016049492 *
        bids_success ;
   IF MISSING( quota ) THEN S_quota  = . ;
   ELSE S_quota  =    -1.27286406186031 +     0.00206044130093 * quota ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =    -6.80202871322695 * S_bids_received  +     252.021439455637 *
        S_bids_success  +    -199.497627496187 * S_quota ;
   H12  =    -2.92456226354774 * S_bids_received  +     1.85319942366951 *
        S_bids_success  +    -4.36518735231833 * S_quota ;
   H13  =    -695.377515200256 * S_bids_received  +    -726.093044446001 *
        S_bids_success  +    -5414.36009221666 * S_quota ;
   H11  = H11  +    -1.36088897298738 * bidding_no1  +    -29.6927707891416 *
        vehicle_classCategory_A  +    -111.691795736891 *
        vehicle_classCategory_B  +     115.759789002164 *
        vehicle_classCategory_C ;
   H12  = H12  +     0.02209912170379 * bidding_no1  +     1.05234303626493 *
        vehicle_classCategory_A  +     2.66637466779374 *
        vehicle_classCategory_B  +    -3.36459942814006 *
        vehicle_classCategory_C ;
   H13  = H13  +     782.617163526438 * bidding_no1  +     662.932793444813 *
        vehicle_classCategory_A  +    -3588.94964974795 *
        vehicle_classCategory_B  +    -5670.58572286627 *
        vehicle_classCategory_C ;
   H11  =     3.31317720861783 + H11 ;
   H12  =    -2.93375431982446 + H12 ;
   H13  =    -92.6711026620571 + H13 ;
   H11  = TANH(H11 );
   H12  = TANH(H12 );
   H13  = TANH(H13 );
END;
ELSE DO;
   H11  = .;
   H12  = .;
   H13  = .;
END;
*** *************************;
*** Writing the Node intervalTargets ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_premium  =     -4108.4027866983 * H11  +     13955.4111012406 * H12
          +     2528.43540843969 * H13 ;
   P_premium  =     59764.3992547546 + P_premium ;
END;
ELSE DO;
   P_premium  = .;
END;
IF _DM_BAD EQ 1 THEN DO;
   P_premium  =     52267.0146699266;
END;
********************************;
*** End Scoring Code for Neural;
********************************;
drop
H11
H12
H13
;
drop S_:;
* Renaming variables for Neural7;
*------------------------------------------------------------*;
* Renaming Predicted variable for Neural7;
*------------------------------------------------------------*;
drop Neural7_P_premium;
Neural7_P_premium = P_premium;
*------------------------------------------------------------*;
* Renaming _WARN_ variable for Neural7;
*------------------------------------------------------------*;
length Neural7_WARN_ $4;
drop Neural7_WARN_;
Neural7_WARN_ = _WARN_;
*------------------------------------------------------------*;
* TOOL: Extension Class;
* TYPE: SAMPLE;
* NODE: FIMPORT4;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* TOOL: Partition Class;
* TYPE: SAMPLE;
* NODE: Part4;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* TOOL: Neural;
* TYPE: MODEL;
* NODE: Neural8;
*------------------------------------------------------------*;
***********************************;
*** Begin Scoring Code for Neural;
***********************************;
DROP _DM_BAD _EPS _NOCL_ _MAX_ _MAXP_ _SUM_ _NTRIALS;
 _DM_BAD = 0;
 _NOCL_ = .;
 _MAX_ = .;
 _MAXP_ = .;
 _SUM_ = .;
 _NTRIALS = .;
 _EPS =                1E-10;
LENGTH _WARN_ $4
;
      label S_bids_received = 'Standard: bids_received' ;

      label S_bids_success = 'Standard: bids_success' ;

      label S_quota = 'Standard: quota' ;

      label bidding_no1 = 'Dummy: bidding_no=1' ;

      label vehicle_classCategory_A = 'Dummy: vehicle_class=Category A' ;

      label vehicle_classCategory_B = 'Dummy: vehicle_class=Category B' ;

      label vehicle_classCategory_C = 'Dummy: vehicle_class=Category C' ;

      label H101 = 'Hidden: H1=1' ;

      label H102 = 'Hidden: H1=2' ;

      label H103 = 'Hidden: H1=3' ;

      label H104 = 'Hidden: H1=4' ;

      label H105 = 'Hidden: H1=5' ;

      label H106 = 'Hidden: H1=6' ;

      label H107 = 'Hidden: H1=7' ;

      label H108 = 'Hidden: H1=8' ;

      label H109 = 'Hidden: H1=9' ;

      label H110 = 'Hidden: H1=10' ;

      label H111 = 'Hidden: H1=11' ;

      label H112 = 'Hidden: H1=12' ;

      label H113 = 'Hidden: H1=13' ;

      label H114 = 'Hidden: H1=14' ;

      label H115 = 'Hidden: H1=15' ;

      label H116 = 'Hidden: H1=16' ;

      label H117 = 'Hidden: H1=17' ;

      label H118 = 'Hidden: H1=18' ;

      label H119 = 'Hidden: H1=19' ;

      label H120 = 'Hidden: H1=20' ;

      label P_premium = 'Predicted: premium' ;

      label  _WARN_ = "Warnings";

*** Generate dummy variables for bidding_no ;
drop bidding_no1 ;
if missing( bidding_no ) then do;
   bidding_no1 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm12 $ 12; drop _dm12 ;
   _dm12 = put( bidding_no , BEST12. );
   %DMNORMIP( _dm12 )
   if _dm12 = '2'  then do;
      bidding_no1 = -1;
   end;
   else if _dm12 = '1'  then do;
      bidding_no1 = 1;
   end;
   else do;
      bidding_no1 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** Generate dummy variables for vehicle_class ;
drop vehicle_classCategory_A vehicle_classCategory_B vehicle_classCategory_C ;
if missing( vehicle_class ) then do;
   vehicle_classCategory_A = .;
   vehicle_classCategory_B = .;
   vehicle_classCategory_C = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm10 $ 10; drop _dm10 ;
   _dm10 = put( vehicle_class , $10. );
   %DMNORMIP( _dm10 )
   if _dm10 = 'CATEGORY C'  then do;
      vehicle_classCategory_A = 0;
      vehicle_classCategory_B = 0;
      vehicle_classCategory_C = 1;
   end;
   else if _dm10 = 'CATEGORY E'  then do;
      vehicle_classCategory_A = -1;
      vehicle_classCategory_B = -1;
      vehicle_classCategory_C = -1;
   end;
   else if _dm10 = 'CATEGORY A'  then do;
      vehicle_classCategory_A = 1;
      vehicle_classCategory_B = 0;
      vehicle_classCategory_C = 0;
   end;
   else if _dm10 = 'CATEGORY B'  then do;
      vehicle_classCategory_A = 0;
      vehicle_classCategory_B = 1;
      vehicle_classCategory_C = 0;
   end;
   else do;
      vehicle_classCategory_A = .;
      vehicle_classCategory_B = .;
      vehicle_classCategory_C = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** *************************;
*** Checking missing input Interval
*** *************************;

IF NMISS(
   bids_received ,
   bids_success ,
   quota   ) THEN DO;
   SUBSTR(_WARN_, 1, 1) = 'M';

   _DM_BAD = 1;
END;
*** *************************;
*** Writing the Node intvl ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   S_bids_received  =    -1.31093674204929 +     0.00140604410956 *
        bids_received ;
   S_bids_success  =    -1.26184127516965 +     0.00207016049492 *
        bids_success ;
   S_quota  =    -1.27286406186031 +     0.00206044130093 * quota ;
END;
ELSE DO;
   IF MISSING( bids_received ) THEN S_bids_received  = . ;
   ELSE S_bids_received  =    -1.31093674204929 +     0.00140604410956 *
        bids_received ;
   IF MISSING( bids_success ) THEN S_bids_success  = . ;
   ELSE S_bids_success  =    -1.26184127516965 +     0.00207016049492 *
        bids_success ;
   IF MISSING( quota ) THEN S_quota  = . ;
   ELSE S_quota  =    -1.27286406186031 +     0.00206044130093 * quota ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H101  =     0.37933021195299 * S_bids_received  +     0.62394389516284 *
        S_bids_success  +     0.47183688261844 * S_quota ;
   H102  =      1.3500627175552 * S_bids_received  +     1.63457093535278 *
        S_bids_success  +     1.85737406619121 * S_quota ;
   H103  =     0.63256243583083 * S_bids_received  +    -0.13985935624793 *
        S_bids_success  +     0.08498613904786 * S_quota ;
   H104  =    -0.28932169522022 * S_bids_received  +     0.69515794808358 *
        S_bids_success  +     0.10747912373386 * S_quota ;
   H105  =     -0.3630445773521 * S_bids_received  +    -0.49448890430579 *
        S_bids_success  +    -0.22129582914432 * S_quota ;
   H106  =     0.07832495714595 * S_bids_received  +    -0.46968049746528 *
        S_bids_success  +    -0.33914906491368 * S_quota ;
   H107  =     0.11189040443604 * S_bids_received  +    -0.45788885037317 *
        S_bids_success  +     0.08265800447029 * S_quota ;
   H108  =     0.45398195104238 * S_bids_received  +    -0.02909367370944 *
        S_bids_success  +    -0.28348399070883 * S_quota ;
   H109  =     0.55246175110679 * S_bids_received  +    -0.40679761887491 *
        S_bids_success  +     0.52191505692575 * S_quota ;
   H110  =    -0.12984025093872 * S_bids_received  +     0.59612895461016 *
        S_bids_success  +    -0.46557340345213 * S_quota ;
   H111  =    -1.35764531860319 * S_bids_received  +    -1.79559159915412 *
        S_bids_success  +     -1.8677322190803 * S_quota ;
   H112  =    -1.24642329319238 * S_bids_received  +    -0.95199221500869 *
        S_bids_success  +    -0.39845807514259 * S_quota ;
   H113  =     0.13850236354833 * S_bids_received  +    -0.52481071525935 *
        S_bids_success  +     0.27730229056954 * S_quota ;
   H114  =    -1.16260506214106 * S_bids_received  +    -0.68066726565635 *
        S_bids_success  +    -0.62264559136896 * S_quota ;
   H115  =     0.44923417990796 * S_bids_received  +     0.18071145864978 *
        S_bids_success  +    -0.16875717403576 * S_quota ;
   H116  =     0.65445521787232 * S_bids_received  +     0.88034202534687 *
        S_bids_success  +     0.77264974707395 * S_quota ;
   H117  =    -0.07365519813375 * S_bids_received  +     -0.4128562521255 *
        S_bids_success  +     0.21341492906735 * S_quota ;
   H118  =     0.23053912778504 * S_bids_received  +     -0.3245740774608 *
        S_bids_success  +      0.7075651851048 * S_quota ;
   H119  =      0.7719580783733 * S_bids_received  +    -0.60521689214484 *
        S_bids_success  +    -0.51361233744532 * S_quota ;
   H120  =     1.46871140307826 * S_bids_received  +     0.98150496050804 *
        S_bids_success  +      1.3810447872213 * S_quota ;
   H101  = H101  +     0.67130448940401 * bidding_no1
          +     0.03201399183097 * vehicle_classCategory_A
          +    -0.25009730916735 * vehicle_classCategory_B
          +     0.93924680885856 * vehicle_classCategory_C ;
   H102  = H102  +     0.14587571427992 * bidding_no1
          +    -1.73414978013371 * vehicle_classCategory_A
          +    -2.25713325933554 * vehicle_classCategory_B
          +     0.56926992741294 * vehicle_classCategory_C ;
   H103  = H103  +      -0.029827264545 * bidding_no1
          +     0.09171782352912 * vehicle_classCategory_A
          +     0.95205454548363 * vehicle_classCategory_B
          +    -0.37353551020113 * vehicle_classCategory_C ;
   H104  = H104  +    -0.28846222376607 * bidding_no1
          +     0.16569673880469 * vehicle_classCategory_A
          +     1.12775986629076 * vehicle_classCategory_B
          +    -1.01796826692693 * vehicle_classCategory_C ;
   H105  = H105  +    -0.49232819595383 * bidding_no1
          +     0.01529102780997 * vehicle_classCategory_A
          +    -0.07711639731165 * vehicle_classCategory_B
          +     0.04229081998197 * vehicle_classCategory_C ;
   H106  = H106  +     0.83132708437159 * bidding_no1
          +     0.17840732809519 * vehicle_classCategory_A
          +    -0.27772009913147 * vehicle_classCategory_B
          +     0.44132138429791 * vehicle_classCategory_C ;
   H107  = H107  +     0.50130506869141 * bidding_no1
          +     0.09236647627304 * vehicle_classCategory_A
          +     1.20900496900715 * vehicle_classCategory_B
          +     1.71994478894564 * vehicle_classCategory_C ;
   H108  = H108  +      0.0051215869557 * bidding_no1
          +     -0.4759395734462 * vehicle_classCategory_A
          +    -0.11602637225918 * vehicle_classCategory_B
          +      0.3910519765474 * vehicle_classCategory_C ;
   H109  = H109  +     0.30333593923807 * bidding_no1
          +     0.49994698094882 * vehicle_classCategory_A
          +    -0.22877141693402 * vehicle_classCategory_B
          +     0.07969183677048 * vehicle_classCategory_C ;
   H110  = H110  +     -0.1629178617164 * bidding_no1
          +     0.28658920347113 * vehicle_classCategory_A
          +     0.41254551356025 * vehicle_classCategory_B
          +    -1.42160263330866 * vehicle_classCategory_C ;
   H111  = H111  +     0.30057806721907 * bidding_no1
          +     1.47849350825809 * vehicle_classCategory_A
          +     2.22438587774776 * vehicle_classCategory_B
          +    -3.22946682553585 * vehicle_classCategory_C ;
   H112  = H112  +     0.23389101406167 * bidding_no1
          +     0.35186958401438 * vehicle_classCategory_A
          +     0.08389348411819 * vehicle_classCategory_B
          +    -1.06064996934742 * vehicle_classCategory_C ;
   H113  = H113  +     0.49848313085255 * bidding_no1
          +    -0.45854378086075 * vehicle_classCategory_A
          +    -0.12847068030922 * vehicle_classCategory_B
          +     0.24379269236966 * vehicle_classCategory_C ;
   H114  = H114  +     0.19827622354554 * bidding_no1
          +     0.36679145721681 * vehicle_classCategory_A
          +     0.07565911099414 * vehicle_classCategory_B
          +    -0.45174695339932 * vehicle_classCategory_C ;
   H115  = H115  +     0.13651417946788 * bidding_no1
          +     0.23293978656063 * vehicle_classCategory_A
          +    -0.42608213625865 * vehicle_classCategory_B
          +    -0.23431605971217 * vehicle_classCategory_C ;
   H116  = H116  +     0.46488061438095 * bidding_no1
          +     1.40614804852264 * vehicle_classCategory_A
          +     2.36509739394931 * vehicle_classCategory_B
          +    -4.45105428949723 * vehicle_classCategory_C ;
   H117  = H117  +    -0.07059569303642 * bidding_no1
          +     0.03523688121141 * vehicle_classCategory_A
          +     0.26647803984276 * vehicle_classCategory_B
          +    -0.65349942511967 * vehicle_classCategory_C ;
   H118  = H118  +     0.62773995923463 * bidding_no1
          +     0.28646311536057 * vehicle_classCategory_A
          +    -0.54948260611178 * vehicle_classCategory_B
          +    -0.94359694476259 * vehicle_classCategory_C ;
   H119  = H119  +      0.6090121186831 * bidding_no1
          +    -0.13497089678173 * vehicle_classCategory_A
          +     2.13978982445647 * vehicle_classCategory_B
          +    -1.47198498652556 * vehicle_classCategory_C ;
   H120  = H120  +     0.53050385277331 * bidding_no1
          +    -0.56779370982696 * vehicle_classCategory_A
          +    -2.59550641891192 * vehicle_classCategory_B
          +     1.73741246942539 * vehicle_classCategory_C ;
   H101  =     0.67071666653879 + H101 ;
   H102  =    -0.08227992681306 + H102 ;
   H103  =     1.80836729888307 + H103 ;
   H104  =     2.10272127710408 + H104 ;
   H105  =    -1.39528432818858 + H105 ;
   H106  =     1.14300699459459 + H106 ;
   H107  =     0.89612906266629 + H107 ;
   H108  =    -2.17325563466962 + H108 ;
   H109  =     1.22381931803947 + H109 ;
   H110  =      0.6241273848069 + H110 ;
   H111  =    -2.93267724533601 + H111 ;
   H112  =    -1.18585555410239 + H112 ;
   H113  =    -0.47060627733643 + H113 ;
   H114  =    -1.27287457918555 + H114 ;
   H115  =     -0.7566085920829 + H115 ;
   H116  =     -3.3373514673712 + H116 ;
   H117  =    -1.20428900047946 + H117 ;
   H118  =    -0.24639762479358 + H118 ;
   H119  =     1.65440651106261 + H119 ;
   H120  =      0.6935577587628 + H120 ;
   H101  = TANH(H101 );
   H102  = TANH(H102 );
   H103  = TANH(H103 );
   H104  = TANH(H104 );
   H105  = TANH(H105 );
   H106  = TANH(H106 );
   H107  = TANH(H107 );
   H108  = TANH(H108 );
   H109  = TANH(H109 );
   H110  = TANH(H110 );
   H111  = TANH(H111 );
   H112  = TANH(H112 );
   H113  = TANH(H113 );
   H114  = TANH(H114 );
   H115  = TANH(H115 );
   H116  = TANH(H116 );
   H117  = TANH(H117 );
   H118  = TANH(H118 );
   H119  = TANH(H119 );
   H120  = TANH(H120 );
END;
ELSE DO;
   H101  = .;
   H102  = .;
   H103  = .;
   H104  = .;
   H105  = .;
   H106  = .;
   H107  = .;
   H108  = .;
   H109  = .;
   H110  = .;
   H111  = .;
   H112  = .;
   H113  = .;
   H114  = .;
   H115  = .;
   H116  = .;
   H117  = .;
   H118  = .;
   H119  = .;
   H120  = .;
END;
*** *************************;
*** Writing the Node intervalTargets ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   P_premium  =    -2196.61880837641 * H101  +    -5554.62207494018 * H102
          +     3351.73984204721 * H103  +     3720.60431970775 * H104
          +     333.012906627969 * H105  +    -1092.22636474744 * H106
          +     -3640.9699326692 * H107  +    -402.648876658614 * H108
          +    -675.765913570296 * H109  +     2001.49651341542 * H110
          +     8605.05814174551 * H111  +     2152.99177040213 * H112
          +     119.222007716756 * H113  +     2118.04304310888 * H114
          +     360.536307563278 * H115  +     8734.91533730328 * H116
          +    -631.285382774536 * H117  +      2307.0697133772 * H118
          +     7568.24711664516 * H119  +    -5946.16941350536 * H120 ;
   P_premium  =     52267.0154436427 + P_premium ;
END;
ELSE DO;
   P_premium  = .;
END;
IF _DM_BAD EQ 1 THEN DO;
   P_premium  =     52267.0146699266;
END;
********************************;
*** End Scoring Code for Neural;
********************************;
drop
H101
H102
H103
H104
H105
H106
H107
H108
H109
H110
H111
H112
H113
H114
H115
H116
H117
H118
H119
H120
;
drop S_:;
* Renaming variables for Neural8;
*------------------------------------------------------------*;
* Renaming Predicted variable for Neural8;
*------------------------------------------------------------*;
drop Neural8_P_premium;
Neural8_P_premium = P_premium;
*------------------------------------------------------------*;
* Renaming _WARN_ variable for Neural8;
*------------------------------------------------------------*;
length Neural8_WARN_ $4;
drop Neural8_WARN_;
Neural8_WARN_ = _WARN_;
*------------------------------------------------------------*;
* TOOL: Ensemble;
* TYPE: MODEL;
* NODE: Ensmbl;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* Ensmbl: Average Predicted of 3 models;
*------------------------------------------------------------*;
P_premium = (
Reg4_P_premium +
Neural7_P_premium +
Neural8_P_premium
)/3;
*------------------------------------------------------------*;
* Ensmbl: Computing _WARN_ Variable;
*------------------------------------------------------------*;
length _WARN_ $4;
label _WARN_ = 'Warnings';
_WARN_ = '';
if index(REG4_WARN_, 'M') and ^index(_WARN_, 'M') then substr(_WARN_, 1, 1) ='M';
if index(REG4_WARN_, 'U') and ^index(_WARN_, 'U') then substr(_WARN_, 2, 1) ='U';
if index(REG4_WARN_, 'P') and ^index(_WARN_, 'P') then substr(_WARN_, 3, 1) ='P';
if index(REG4_WARN_, 'C') and ^index(_WARN_, 'C') then substr(_WARN_, 4, 1) ='C';
if index(NEURAL7_WARN_, 'M') and ^index(_WARN_, 'M') then substr(_WARN_, 1, 1) ='M';
if index(NEURAL7_WARN_, 'U') and ^index(_WARN_, 'U') then substr(_WARN_, 2, 1) ='U';
if index(NEURAL7_WARN_, 'P') and ^index(_WARN_, 'P') then substr(_WARN_, 3, 1) ='P';
if index(NEURAL7_WARN_, 'C') and ^index(_WARN_, 'C') then substr(_WARN_, 4, 1) ='C';
if index(NEURAL8_WARN_, 'M') and ^index(_WARN_, 'M') then substr(_WARN_, 1, 1) ='M';
if index(NEURAL8_WARN_, 'U') and ^index(_WARN_, 'U') then substr(_WARN_, 2, 1) ='U';
if index(NEURAL8_WARN_, 'P') and ^index(_WARN_, 'P') then substr(_WARN_, 3, 1) ='P';
if index(NEURAL8_WARN_, 'C') and ^index(_WARN_, 'C') then substr(_WARN_, 4, 1) ='C';
