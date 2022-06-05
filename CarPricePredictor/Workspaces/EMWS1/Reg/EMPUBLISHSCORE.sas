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

*** Predicted Value;
label P_Adj_Prem = 'Predicted: Adj_Prem' ;
P_Adj_Prem = _LP0;


*************************************;
***** end scoring code for regression;
*************************************;
