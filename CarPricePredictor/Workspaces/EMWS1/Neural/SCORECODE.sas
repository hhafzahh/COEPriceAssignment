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
********************************;
*** End Scoring Code for Neural;
********************************;
