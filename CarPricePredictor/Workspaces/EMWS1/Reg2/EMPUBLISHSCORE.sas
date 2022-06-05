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
