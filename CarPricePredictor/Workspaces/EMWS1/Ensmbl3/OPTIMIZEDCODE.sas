*------------------------------------------------------------*;
* TOOL: Extension Class;
* TYPE: SAMPLE;
* NODE: FIMPORT2;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* TOOL: Partition Class;
* TYPE: SAMPLE;
* NODE: Part2;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* TOOL: Regression;
* TYPE: MODEL;
* NODE: Reg2;
*------------------------------------------------------------*;
*************************************;
*** begin scoring code for regression;
*************************************;

length _WARN_ $4;
label _WARN_ = 'Warnings' ;


drop _DM_BAD;
_DM_BAD=0;

*** Check Adjusted_Quota for missing values ;
if missing( Adjusted_Quota ) then do;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
*** If missing inputs, use averages;
if _DM_BAD > 0 then do;
   _LP0 =     60939.5490196078;
   goto REG2DR1;
end;

*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;

***  Effect: Adjusted_Quota ;
_TEMP = Adjusted_Quota ;
_LP0 = _LP0 + (   -126.473377603714 * _TEMP);
*--- Intercept ---*;
_LP0 = _LP0 + (    106590.238659176);

REG2DR1:

*** Predicted Value;
label P_Adj_Prem = 'Predicted: Adj_Prem' ;
P_Adj_Prem = _LP0;


*************************************;
***** end scoring code for regression;
*************************************;
* Renaming variables for Reg2;
*------------------------------------------------------------*;
* Renaming Predicted variable for Reg2;
*------------------------------------------------------------*;
drop Reg2_P_Adj_Prem;
Reg2_P_Adj_Prem = P_Adj_Prem;
*------------------------------------------------------------*;
* Renaming _WARN_ variable for Reg2;
*------------------------------------------------------------*;
length Reg2_WARN_ $4;
drop Reg2_WARN_;
Reg2_WARN_ = _WARN_;
*------------------------------------------------------------*;
* TOOL: Extension Class;
* TYPE: SAMPLE;
* NODE: FIMPORT2;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* TOOL: Partition Class;
* TYPE: SAMPLE;
* NODE: Part2;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* TOOL: Neural;
* TYPE: MODEL;
* NODE: Neural3;
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

      label H11 = 'Hidden: H1=1' ;

      label H12 = 'Hidden: H1=2' ;

      label H13 = 'Hidden: H1=3' ;

      label P_Adj_Prem = 'Predicted: Adj_Prem' ;

      label  _WARN_ = "Warnings";

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
   S_Adjusted_Quota  =    -3.05144699064714 +      0.0084539096897 *
        Adjusted_Quota ;
END;
ELSE DO;
   IF MISSING( Adjusted_Quota ) THEN S_Adjusted_Quota  = . ;
   ELSE S_Adjusted_Quota  =    -3.05144699064714 +      0.0084539096897 *
        Adjusted_Quota ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =     13.4176960200289 * S_Adjusted_Quota ;
   H12  =     5.14998955160457 * S_Adjusted_Quota ;
   H13  =     174.732130110341 * S_Adjusted_Quota ;
   H11  = H11  + 0;
   H12  = H12  + 0;
   H13  = H13  + 0;
   H11  =     0.06643486307832 + H11 ;
   H12  =    -8.99839897908251 + H12 ;
   H13  =     147.312825537929 + H13 ;
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
   P_Adj_Prem  =    -12095.0198388716 * H11  +    -8395.89526217693 * H12
          +    -6782.52592337009 * H13 ;
   P_Adj_Prem  =     56218.2188591571 + P_Adj_Prem ;
END;
ELSE DO;
   P_Adj_Prem  = .;
END;
IF _DM_BAD EQ 1 THEN DO;
   P_Adj_Prem  =     60939.5490196078;
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
* Renaming variables for Neural3;
*------------------------------------------------------------*;
* Renaming Predicted variable for Neural3;
*------------------------------------------------------------*;
drop Neural3_P_Adj_Prem;
Neural3_P_Adj_Prem = P_Adj_Prem;
*------------------------------------------------------------*;
* Renaming _WARN_ variable for Neural3;
*------------------------------------------------------------*;
length Neural3_WARN_ $4;
drop Neural3_WARN_;
Neural3_WARN_ = _WARN_;
*------------------------------------------------------------*;
* TOOL: Extension Class;
* TYPE: SAMPLE;
* NODE: FIMPORT2;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* TOOL: Partition Class;
* TYPE: SAMPLE;
* NODE: Part2;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* TOOL: Neural;
* TYPE: MODEL;
* NODE: Neural4;
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

      label  _WARN_ = "Warnings";

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
   S_Adjusted_Quota  =    -3.05144699064714 +      0.0084539096897 *
        Adjusted_Quota ;
END;
ELSE DO;
   IF MISSING( Adjusted_Quota ) THEN S_Adjusted_Quota  = . ;
   ELSE S_Adjusted_Quota  =    -3.05144699064714 +      0.0084539096897 *
        Adjusted_Quota ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H101  =    -1.17304898364619 * S_Adjusted_Quota ;
   H102  =    -2.63288110994629 * S_Adjusted_Quota ;
   H103  =    -7.62154376043366 * S_Adjusted_Quota ;
   H104  =    -0.89442559598334 * S_Adjusted_Quota ;
   H105  =     2.48714263625231 * S_Adjusted_Quota ;
   H106  =    -0.50870569456117 * S_Adjusted_Quota ;
   H107  =     0.51980433997191 * S_Adjusted_Quota ;
   H108  =    -0.77740950838861 * S_Adjusted_Quota ;
   H109  =    -0.21442748346169 * S_Adjusted_Quota ;
   H110  =    -1.98339287878448 * S_Adjusted_Quota ;
   H111  =     -1.1276051557115 * S_Adjusted_Quota ;
   H112  =     -0.1831489646127 * S_Adjusted_Quota ;
   H113  =    -0.18891577747873 * S_Adjusted_Quota ;
   H114  =     1.21746656620854 * S_Adjusted_Quota ;
   H115  =    -0.98648765837821 * S_Adjusted_Quota ;
   H116  =    -0.09998834226485 * S_Adjusted_Quota ;
   H117  =    -1.00294911057456 * S_Adjusted_Quota ;
   H118  =     0.57034974531053 * S_Adjusted_Quota ;
   H119  =     -0.2679937035728 * S_Adjusted_Quota ;
   H120  =    -1.18208613331171 * S_Adjusted_Quota ;
   H101  = H101  + 0;
   H102  = H102  + 0;
   H103  = H103  + 0;
   H104  = H104  + 0;
   H105  = H105  + 0;
   H106  = H106  + 0;
   H107  = H107  + 0;
   H108  = H108  + 0;
   H109  = H109  + 0;
   H110  = H110  + 0;
   H111  = H111  + 0;
   H112  = H112  + 0;
   H113  = H113  + 0;
   H114  = H114  + 0;
   H115  = H115  + 0;
   H116  = H116  + 0;
   H117  = H117  + 0;
   H118  = H118  + 0;
   H119  = H119  + 0;
   H120  = H120  + 0;
   H101  =     1.40541899490872 + H101 ;
   H102  =     2.83773488032745 + H102 ;
   H103  =     0.36766843441698 + H103 ;
   H104  =     0.96384050564903 + H104 ;
   H105  =    -0.60985789935643 + H105 ;
   H106  =     0.63030803576629 + H106 ;
   H107  =    -0.64061000684715 + H107 ;
   H108  =     0.96658608015177 + H108 ;
   H109  =     0.96956555600231 + H109 ;
   H110  =    -1.04146858257887 + H110 ;
   H111  =     -0.4541134219528 + H111 ;
   H112  =     1.60444983139847 + H112 ;
   H113  =    -1.81296625180111 + H113 ;
   H114  =     1.05161370400887 + H114 ;
   H115  =    -0.77854677257992 + H115 ;
   H116  =     0.54263021711722 + H116 ;
   H117  =    -0.60373535577842 + H117 ;
   H118  =     1.38963116167163 + H118 ;
   H119  =     0.17442987027767 + H119 ;
   H120  =    -0.10053349765625 + H120 ;
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
   P_Adj_Prem  =    -9120.82449998431 * H101  +    -19679.9340350364 * H102
          +     19018.6396632308 * H103  +     28297.3503289804 * H104
          +      18182.587816832 * H105  +      21869.325510796 * H106
          +    -22301.6824785912 * H107  +     18576.3348681869 * H108
          +    -11080.9963490453 * H109  +     18434.6569560531 * H110
          +     177.803786561087 * H111  +       -6267.79586153 * H112
          +     7081.66698094916 * H113  +     2653.64681357054 * H114
          +    -2971.51409799224 * H115  +     4068.07442730781 * H116
          +     465.856884054195 * H117  +    -1206.80998970532 * H118
          +     13798.9238370583 * H119  +    -30658.1750904567 * H120 ;
   P_Adj_Prem  =     53507.7959492511 + P_Adj_Prem ;
END;
ELSE DO;
   P_Adj_Prem  = .;
END;
IF _DM_BAD EQ 1 THEN DO;
   P_Adj_Prem  =     60939.5490196078;
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
* Renaming variables for Neural4;
*------------------------------------------------------------*;
* Renaming Predicted variable for Neural4;
*------------------------------------------------------------*;
drop Neural4_P_Adj_Prem;
Neural4_P_Adj_Prem = P_Adj_Prem;
*------------------------------------------------------------*;
* Renaming _WARN_ variable for Neural4;
*------------------------------------------------------------*;
length Neural4_WARN_ $4;
drop Neural4_WARN_;
Neural4_WARN_ = _WARN_;
*------------------------------------------------------------*;
* TOOL: Ensemble;
* TYPE: MODEL;
* NODE: Ensmbl3;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* Ensmbl3: Average Predicted of 3 models;
*------------------------------------------------------------*;
P_Adj_Prem = (
Reg2_P_Adj_Prem +
Neural3_P_Adj_Prem +
Neural4_P_Adj_Prem
)/3;
*------------------------------------------------------------*;
* Ensmbl3: Computing _WARN_ Variable;
*------------------------------------------------------------*;
length _WARN_ $4;
label _WARN_ = 'Warnings';
_WARN_ = '';
if index(REG2_WARN_, 'M') and ^index(_WARN_, 'M') then substr(_WARN_, 1, 1) ='M';
if index(REG2_WARN_, 'U') and ^index(_WARN_, 'U') then substr(_WARN_, 2, 1) ='U';
if index(REG2_WARN_, 'P') and ^index(_WARN_, 'P') then substr(_WARN_, 3, 1) ='P';
if index(REG2_WARN_, 'C') and ^index(_WARN_, 'C') then substr(_WARN_, 4, 1) ='C';
if index(NEURAL3_WARN_, 'M') and ^index(_WARN_, 'M') then substr(_WARN_, 1, 1) ='M';
if index(NEURAL3_WARN_, 'U') and ^index(_WARN_, 'U') then substr(_WARN_, 2, 1) ='U';
if index(NEURAL3_WARN_, 'P') and ^index(_WARN_, 'P') then substr(_WARN_, 3, 1) ='P';
if index(NEURAL3_WARN_, 'C') and ^index(_WARN_, 'C') then substr(_WARN_, 4, 1) ='C';
if index(NEURAL4_WARN_, 'M') and ^index(_WARN_, 'M') then substr(_WARN_, 1, 1) ='M';
if index(NEURAL4_WARN_, 'U') and ^index(_WARN_, 'U') then substr(_WARN_, 2, 1) ='U';
if index(NEURAL4_WARN_, 'P') and ^index(_WARN_, 'P') then substr(_WARN_, 3, 1) ='P';
if index(NEURAL4_WARN_, 'C') and ^index(_WARN_, 'C') then substr(_WARN_, 4, 1) ='C';
