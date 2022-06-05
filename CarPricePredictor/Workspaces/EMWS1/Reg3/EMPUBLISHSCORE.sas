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
drop _0_0 ;
if missing( vehicle_class ) then do;
   _0_0 = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm10 $ 10; drop _dm10 ;
   _dm10 = put( vehicle_class , $10. );
   %DMNORMIP( _dm10 )
   if _dm10 = 'CATEGORY B'  then do;
      _0_0 = 1;
   end;
   else if _dm10 = 'CATEGORY E'  then do;
      _0_0 = -1;
   end;
   else do;
      _0_0 = .;
      substr(_warn_,2,1) = 'U';
      _DM_BAD = 1;
   end;
end;

*** If missing inputs, use averages;
if _DM_BAD > 0 then do;
   _LP0 =     59622.9019607843;
   goto REG3DR1;
end;

*** Compute Linear Predictor;
drop _TEMP;
drop _LP0;
_LP0 = 0;

***  Effect: Adjusted_Quota ;
_TEMP = Adjusted_Quota ;
_LP0 = _LP0 + (   -42.3000109599249 * _TEMP);

***  Effect: vehicle_class ;
_TEMP = 1;
_LP0 = _LP0 + (    8488.39980100425) * _TEMP * _0_0;
*--- Intercept ---*;
_LP0 = _LP0 + (    84219.0757826353);

REG3DR1:

*** Predicted Value;
label P_Adj_Prem = 'Predicted: Adj_Prem' ;
P_Adj_Prem = _LP0;


*************************************;
***** end scoring code for regression;
*************************************;
