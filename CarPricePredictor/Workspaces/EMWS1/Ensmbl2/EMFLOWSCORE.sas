*------------------------------------------------------------*;
* Ensmbl2: Combine model for Adj_Prem;
*------------------------------------------------------------*;
* Ensmbl2: Scoring Code of model 1 of 3;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* TOOL: Extension Class;
* TYPE: SAMPLE;
* NODE: FIMPORT;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* TOOL: Partition Class;
* TYPE: SAMPLE;
* NODE: Part;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* TOOL: Neural;
* TYPE: MODEL;
* NODE: Neural2;
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
      label S_Adjusted_Quota = 'Standard: Adjusted_Quota' ;

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

      label P_Adj_Prem = 'Predicted: Adj_Prem' ;

      label R_Adj_Prem = 'Residual: Adj_Prem' ;

      label  _WARN_ = "Warnings";

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
   Adjusted_Quota   ) THEN DO;
   SUBSTR(_WARN_, 1, 1) = 'M';

   _DM_BAD = 1;
END;
*** *************************;
*** Writing the Node intvl ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   S_Adjusted_Quota  =    -1.25264578202827 +     0.00197510408777 *
        Adjusted_Quota ;
END;
ELSE DO;
   IF MISSING( Adjusted_Quota ) THEN S_Adjusted_Quota  = . ;
   ELSE S_Adjusted_Quota  =    -1.25264578202827 +     0.00197510408777 *
        Adjusted_Quota ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H101  =      2.8771338236718 * S_Adjusted_Quota ;
   H102  =        -0.7480306467 * S_Adjusted_Quota ;
   H103  =    -0.32168047729752 * S_Adjusted_Quota ;
   H104  =     0.87352999132128 * S_Adjusted_Quota ;
   H105  =     0.57712527350684 * S_Adjusted_Quota ;
   H106  =     8.73655740161335 * S_Adjusted_Quota ;
   H107  =     2.50469338290562 * S_Adjusted_Quota ;
   H108  =    -0.02688143756836 * S_Adjusted_Quota ;
   H109  =     0.60654376724225 * S_Adjusted_Quota ;
   H110  =     0.78503178787198 * S_Adjusted_Quota ;
   H111  =    -0.30758498952239 * S_Adjusted_Quota ;
   H112  =     0.24470826175787 * S_Adjusted_Quota ;
   H113  =    -2.00745587913452 * S_Adjusted_Quota ;
   H114  =     0.94069941793641 * S_Adjusted_Quota ;
   H115  =    -0.30610694649552 * S_Adjusted_Quota ;
   H116  =     0.31817320787735 * S_Adjusted_Quota ;
   H117  =     1.49622227194148 * S_Adjusted_Quota ;
   H118  =     4.69504723485158 * S_Adjusted_Quota ;
   H119  =     0.66753888425368 * S_Adjusted_Quota ;
   H120  =    -0.27766910891745 * S_Adjusted_Quota ;
   H101  = H101  +    -0.15546225108042 * vehicle_classCategory_A
          +     0.19354399063247 * vehicle_classCategory_B
          +     0.74715504845505 * vehicle_classCategory_C ;
   H102  = H102  +    -0.53023925288013 * vehicle_classCategory_A
          +     0.03744026566676 * vehicle_classCategory_B
          +    -0.00824340410597 * vehicle_classCategory_C ;
   H103  = H103  +    -0.04832831056325 * vehicle_classCategory_A
          +     0.60758737236822 * vehicle_classCategory_B
          +      0.1335875237008 * vehicle_classCategory_C ;
   H104  = H104  +     0.39656388794782 * vehicle_classCategory_A
          +     2.42011776430927 * vehicle_classCategory_B
          +    -2.33361951918157 * vehicle_classCategory_C ;
   H105  = H105  +     0.06052761493876 * vehicle_classCategory_A
          +     0.15472463561945 * vehicle_classCategory_B
          +     1.12301273263048 * vehicle_classCategory_C ;
   H106  = H106  +     0.02026705019919 * vehicle_classCategory_A
          +    -5.88083500842796 * vehicle_classCategory_B
          +     2.56835959521819 * vehicle_classCategory_C ;
   H107  = H107  +     0.17036876665384 * vehicle_classCategory_A
          +     -4.6007099558484 * vehicle_classCategory_B
          +     3.72451481035844 * vehicle_classCategory_C ;
   H108  = H108  +     0.37579555698824 * vehicle_classCategory_A
          +     -0.0624915402186 * vehicle_classCategory_B
          +     0.68787209169617 * vehicle_classCategory_C ;
   H109  = H109  +     1.27435454316125 * vehicle_classCategory_A
          +     1.07362336912978 * vehicle_classCategory_B
          +     0.88576705395489 * vehicle_classCategory_C ;
   H110  = H110  +    -0.38694417176082 * vehicle_classCategory_A
          +    -1.05619038257077 * vehicle_classCategory_B
          +    -0.85494745029944 * vehicle_classCategory_C ;
   H111  = H111  +    -0.45524163628369 * vehicle_classCategory_A
          +    -0.61297970746296 * vehicle_classCategory_B
          +    -3.61716553342801 * vehicle_classCategory_C ;
   H112  = H112  +     1.17720622678872 * vehicle_classCategory_A
          +    -1.41483973744474 * vehicle_classCategory_B
          +     0.44975922679298 * vehicle_classCategory_C ;
   H113  = H113  +    -0.65782163780185 * vehicle_classCategory_A
          +      0.3610048617784 * vehicle_classCategory_B
          +    -1.39733582355693 * vehicle_classCategory_C ;
   H114  = H114  +    -0.17856830726135 * vehicle_classCategory_A
          +     2.56879255160525 * vehicle_classCategory_B
          +    -2.53198064495795 * vehicle_classCategory_C ;
   H115  = H115  +    -1.64992219202243 * vehicle_classCategory_A
          +    -0.50808210795988 * vehicle_classCategory_B
          +     0.76559911287531 * vehicle_classCategory_C ;
   H116  = H116  +    -0.30276647234265 * vehicle_classCategory_A
          +     0.50193972161388 * vehicle_classCategory_B
          +    -0.43006254540603 * vehicle_classCategory_C ;
   H117  = H117  +     0.88024418369337 * vehicle_classCategory_A
          +    -0.45485822669774 * vehicle_classCategory_B
          +    -0.00691895868591 * vehicle_classCategory_C ;
   H118  = H118  +     0.75004620361558 * vehicle_classCategory_A
          +    -2.78998694666145 * vehicle_classCategory_B
          +     0.03277285415975 * vehicle_classCategory_C ;
   H119  = H119  +     2.14492700216227 * vehicle_classCategory_A
          +     5.99363791721806 * vehicle_classCategory_B
          +    -0.40950805033015 * vehicle_classCategory_C ;
   H120  = H120  +     1.83179421992789 * vehicle_classCategory_A
          +       2.456073586439 * vehicle_classCategory_B
          +    -0.46677369534685 * vehicle_classCategory_C ;
   H101  =     3.17007779307854 + H101 ;
   H102  =     1.51444568519549 + H102 ;
   H103  =    -0.25625399350656 + H103 ;
   H104  =     3.43374668653011 + H104 ;
   H105  =     2.83928111741339 + H105 ;
   H106  =     2.15057941466658 + H106 ;
   H107  =    -1.33104322433864 + H107 ;
   H108  =     0.72406422508808 + H108 ;
   H109  =    -0.05197093810969 + H109 ;
   H110  =    -0.77821961432893 + H110 ;
   H111  =    -2.02310248266302 + H111 ;
   H112  =     0.62630239864663 + H112 ;
   H113  =     -2.1113414582297 + H113 ;
   H114  =     2.65886116251445 + H114 ;
   H115  =    -0.43638020990706 + H115 ;
   H116  =     0.27513043031419 + H116 ;
   H117  =    -1.99418848366857 + H117 ;
   H118  =      0.7536416249824 + H118 ;
   H119  =     2.35218633682787 + H119 ;
   H120  =     0.77053268178083 + H120 ;
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
   P_Adj_Prem  =    -6009.74819964367 * H101  +    -1271.89203062772 * H102
          +     613.084996528735 * H103  +     6038.12633754366 * H104
          +    -2558.95360443173 * H105  +    -10455.3134640987 * H106
          +    -7991.91253390137 * H107  +     898.807927356253 * H108
          +     2858.68477492313 * H109  +     2154.25718235546 * H110
          +     9639.33499838427 * H111  +     3475.44813997322 * H112
          +     3008.66207329027 * H113  +      7379.0017707909 * H114
          +    -485.611017929482 * H115  +     730.875967847589 * H116
          +     4614.47816594831 * H117  +    -5401.13347378324 * H118
          +     6395.86203180187 * H119  +     2842.81632056867 * H120 ;
   P_Adj_Prem  =     52409.3765811841 + P_Adj_Prem ;
END;
ELSE DO;
   P_Adj_Prem  = .;
END;
IF _DM_BAD EQ 1 THEN DO;
   P_Adj_Prem  =     52409.3765281173;
END;
*** *****************************;
*** Writing the Residuals  of the Node intervalTargets ;
*** ******************************;
IF MISSING( Adj_Prem ) THEN R_Adj_Prem  = . ;
ELSE R_Adj_Prem  = Adj_Prem  - P_Adj_Prem ;
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
* Renaming variables for Neural2;
*------------------------------------------------------------*;
* Renaming Predicted variable for Neural2;
*------------------------------------------------------------*;
drop Neural2_P_Adj_Prem;
Neural2_P_Adj_Prem = P_Adj_Prem;
*------------------------------------------------------------*;
* Renaming _WARN_ variable for Neural2;
*------------------------------------------------------------*;
length Neural2_WARN_ $4;
drop Neural2_WARN_;
Neural2_WARN_ = _WARN_;
*------------------------------------------------------------*;
* Ensmbl2: Scoring Code of model 2 of 3;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* TOOL: Neural;
* TYPE: MODEL;
* NODE: Neural;
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
      label S_Adjusted_Quota = 'Standard: Adjusted_Quota' ;

      label vehicle_classCategory_A = 'Dummy: vehicle_class=Category A' ;

      label vehicle_classCategory_B = 'Dummy: vehicle_class=Category B' ;

      label vehicle_classCategory_C = 'Dummy: vehicle_class=Category C' ;

      label H11 = 'Hidden: H1=1' ;

      label H12 = 'Hidden: H1=2' ;

      label H13 = 'Hidden: H1=3' ;

      label P_Adj_Prem = 'Predicted: Adj_Prem' ;

      label R_Adj_Prem = 'Residual: Adj_Prem' ;

      label  _WARN_ = "Warnings";

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
   Adjusted_Quota   ) THEN DO;
   SUBSTR(_WARN_, 1, 1) = 'M';

   _DM_BAD = 1;
END;
*** *************************;
*** Writing the Node intvl ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   S_Adjusted_Quota  =    -1.25264578202827 +     0.00197510408777 *
        Adjusted_Quota ;
END;
ELSE DO;
   IF MISSING( Adjusted_Quota ) THEN S_Adjusted_Quota  = . ;
   ELSE S_Adjusted_Quota  =    -1.25264578202827 +     0.00197510408777 *
        Adjusted_Quota ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =    -2008726.72900862 * S_Adjusted_Quota ;
   H12  =     91.6688265016953 * S_Adjusted_Quota ;
   H13  =    -6.03646696676622 * S_Adjusted_Quota ;
   H11  = H11  +     2400069.23434644 * vehicle_classCategory_A
          +     32.5955966810546 * vehicle_classCategory_B
          +     -90.312279090089 * vehicle_classCategory_C ;
   H12  = H12  +    -37.3612078839338 * vehicle_classCategory_A
          +    -82.7831817036557 * vehicle_classCategory_B
          +     68.2082873341396 * vehicle_classCategory_C ;
   H13  = H13  +    -50.6410840251752 * vehicle_classCategory_A
          +    -36.1021264525077 * vehicle_classCategory_B
          +    -165.342662258124 * vehicle_classCategory_C ;
   H11  =     2400322.04697281 + H11 ;
   H12  =    -2.87531595671554 + H12 ;
   H13  =     49.4492867312619 + H13 ;
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
   P_Adj_Prem  =    -2447.50658870183 * H11  +    -9886.30444894741 * H12
          +      7915.2355809248 * H13 ;
   P_Adj_Prem  =     49245.5534135909 + P_Adj_Prem ;
END;
ELSE DO;
   P_Adj_Prem  = .;
END;
IF _DM_BAD EQ 1 THEN DO;
   P_Adj_Prem  =     52409.3765281173;
END;
*** *****************************;
*** Writing the Residuals  of the Node intervalTargets ;
*** ******************************;
IF MISSING( Adj_Prem ) THEN R_Adj_Prem  = . ;
ELSE R_Adj_Prem  = Adj_Prem  - P_Adj_Prem ;
********************************;
*** End Scoring Code for Neural;
********************************;
drop
H11
H12
H13
;
drop S_:;
* Renaming variables for Neural;
*------------------------------------------------------------*;
* Renaming Predicted variable for Neural;
*------------------------------------------------------------*;
drop Neural_P_Adj_Prem;
Neural_P_Adj_Prem = P_Adj_Prem;
*------------------------------------------------------------*;
* Renaming _WARN_ variable for Neural;
*------------------------------------------------------------*;
length Neural_WARN_ $4;
drop Neural_WARN_;
Neural_WARN_ = _WARN_;
*------------------------------------------------------------*;
* Ensmbl2: Scoring Code of model 3 of 3;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* TOOL: Regression;
* TYPE: MODEL;
* NODE: Reg;
*------------------------------------------------------------*;
*************************************;
*** begin scoring code for regression;
*************************************;

length _WARN_ $4;
label _WARN_ = 'Warnings' ;

drop _Y;
_Y = Adj_Prem ;

drop _DM_BAD;
_DM_BAD=0;

*** Check Adjusted_Quota for missing values ;
if missing( Adjusted_Quota ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;

*** Generate dummy variables for vehicle_class ;
drop _0_0 _0_1 _0_2 ;
if missing( vehicle_class ) then do;
   _0_0 = .;
   _0_1 = .;
   _0_2 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm10 $ 10; drop _dm10 ;
   _dm10 = put( vehicle_class , $10. );
   %DMNORMIP( _dm10 )
   if _dm10 = 'CATEGORY C'  then do;
      _0_0 = 0;
      _0_1 = 0;
      _0_2 = 1;
   end;
   else if _dm10 = 'CATEGORY E'  then do;
      _0_0 = -1;
      _0_1 = -1;
      _0_2 = -1;
   end;
   else if _dm10 = 'CATEGORY A'  then do;
      _0_0 = 1;
      _0_1 = 0;
      _0_2 = 0;
   end;
   else if _dm10 = 'CATEGORY B'  then do;
      _0_0 = 0;
      _0_1 = 1;
      _0_2 = 0;
   end;
   else do;
      _0_0 = .;
      _0_1 = .;
      _0_2 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** If missing inputs, use averages;
if _DM_BAD > 0 then do;
   _LP0 =     52409.3765281173;
   goto REGDR1;
end;

*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;

***  Effect: Adjusted_Quota ;
_TEMP = Adjusted_Quota ;
_LP0 = _LP0 + (   -19.3792777610907 * _TEMP);

***  Effect: vehicle_class ;
_TEMP = 1;
_LP0 = _LP0 + (    6206.67029088508) * _TEMP * _0_0;
_LP0 = _LP0 + (    10197.3572890244) * _TEMP * _0_1;
_LP0 = _LP0 + (   -17559.5309746345) * _TEMP * _0_2;
*--- Intercept ---*;
_LP0 = _LP0 + (    64913.1762423729);

REGDR1:

*** Predicted Value, Error, and Residual;
label P_Adj_Prem = 'Predicted: Adj_Prem' ;
P_Adj_Prem = _LP0;

drop _R;
if _Y = . then do;
   R_Adj_Prem = .;
end;
else do;
   _R = _Y - _LP0;
    label R_Adj_Prem = 'Residual: Adj_Prem' ;
   R_Adj_Prem = _R;
end;

*************************************;
***** end scoring code for regression;
*************************************;
* Renaming variables for Reg;
*------------------------------------------------------------*;
* Renaming Predicted variable for Reg;
*------------------------------------------------------------*;
drop Reg_P_Adj_Prem;
Reg_P_Adj_Prem = P_Adj_Prem;
*------------------------------------------------------------*;
* Renaming _WARN_ variable for Reg;
*------------------------------------------------------------*;
length Reg_WARN_ $4;
drop Reg_WARN_;
Reg_WARN_ = _WARN_;
*------------------------------------------------------------*;
* Ensmbl2: Average Predicted of 3 models;
*------------------------------------------------------------*;
P_Adj_Prem = (
Neural2_P_Adj_Prem +
Neural_P_Adj_Prem +
Reg_P_Adj_Prem
)/3;
*------------------------------------------------------------*;
* Ensmbl2: Computing _WARN_ Variable;
*------------------------------------------------------------*;
length _WARN_ $4;
label _WARN_ = 'Warnings';
_WARN_ = '';
if index(NEURAL2_WARN_, 'M') and ^index(_WARN_, 'M') then substr(_WARN_, 1, 1) ='M';
if index(NEURAL2_WARN_, 'U') and ^index(_WARN_, 'U') then substr(_WARN_, 2, 1) ='U';
if index(NEURAL2_WARN_, 'P') and ^index(_WARN_, 'P') then substr(_WARN_, 3, 1) ='P';
if index(NEURAL2_WARN_, 'C') and ^index(_WARN_, 'C') then substr(_WARN_, 4, 1) ='C';
if index(NEURAL_WARN_, 'M') and ^index(_WARN_, 'M') then substr(_WARN_, 1, 1) ='M';
if index(NEURAL_WARN_, 'U') and ^index(_WARN_, 'U') then substr(_WARN_, 2, 1) ='U';
if index(NEURAL_WARN_, 'P') and ^index(_WARN_, 'P') then substr(_WARN_, 3, 1) ='P';
if index(NEURAL_WARN_, 'C') and ^index(_WARN_, 'C') then substr(_WARN_, 4, 1) ='C';
if index(REG_WARN_, 'M') and ^index(_WARN_, 'M') then substr(_WARN_, 1, 1) ='M';
if index(REG_WARN_, 'U') and ^index(_WARN_, 'U') then substr(_WARN_, 2, 1) ='U';
if index(REG_WARN_, 'P') and ^index(_WARN_, 'P') then substr(_WARN_, 3, 1) ='P';
if index(REG_WARN_, 'C') and ^index(_WARN_, 'C') then substr(_WARN_, 4, 1) ='C';
*------------------------------------------------------------*;
* Ensmbl2: Computing Residual Var;
*------------------------------------------------------------*;
label R_Adj_Prem = "Residual: Adj_Prem";
R_Adj_Prem = Adj_Prem - P_Adj_Prem;
