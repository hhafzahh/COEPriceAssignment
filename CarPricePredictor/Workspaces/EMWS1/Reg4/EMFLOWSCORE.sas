*************************************;
*** begin scoring code for regression;
*************************************;

length _WARN_ $4;
label _WARN_ = 'Warnings' ;

drop _Y;
_Y = premium ;

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

*** Predicted Value, Error, and Residual;
label P_premium = 'Predicted: premium' ;
P_premium = _LP0;

drop _R;
if _Y = . then do;
   R_premium = .;
end;
else do;
   _R = _Y - _LP0;
    label R_premium = 'Residual: premium' ;
   R_premium = _R;
end;

*************************************;
***** end scoring code for regression;
*************************************;
