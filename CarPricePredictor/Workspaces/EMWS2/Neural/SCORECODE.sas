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

      label vehicle_classCategory_B = 'Dummy: vehicle_class=Category B' ;

      label H11 = 'Hidden: H1=1' ;

      label H12 = 'Hidden: H1=2' ;

      label H13 = 'Hidden: H1=3' ;

      label P_Adj_Prem = 'Predicted: Adj_Prem' ;

      label  _WARN_ = "Warnings"; 

*** Generate dummy variables for vehicle_class ;
drop vehicle_classCategory_B ;
if missing( vehicle_class ) then do;
   vehicle_classCategory_B = .;
   substr(_warn_,1,1) = 'M';
   _DM_BAD = 1;
end;
else do;
   length _dm10 $ 10; drop _dm10 ;
   _dm10 = put( vehicle_class , $10. );
   %DMNORMIP( _dm10 )
   if _dm10 = 'CATEGORY B'  then do;
      vehicle_classCategory_B = 1;
   end;
   else if _dm10 = 'CATEGORY E'  then do;
      vehicle_classCategory_B = -1;
   end;
   else do;
      vehicle_classCategory_B = .;
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
   S_Adjusted_Quota  =    -1.64370377769017 +     0.00280780900289 * 
        Adjusted_Quota ;
END;
ELSE DO;
   IF MISSING( Adjusted_Quota ) THEN S_Adjusted_Quota  = . ;
   ELSE S_Adjusted_Quota  =    -1.64370377769017 +     0.00280780900289 * 
        Adjusted_Quota ;
END;
*** *************************;
*** Writing the Node nom ;
*** *************************;
*** *************************;
*** Writing the Node H1 ;
*** *************************;
IF _DM_BAD EQ 0 THEN DO;
   H11  =    -2.04391246200017 * S_Adjusted_Quota ;
   H12  =    -9.45312524443988 * S_Adjusted_Quota ;
   H13  =    -7.91679432636959 * S_Adjusted_Quota ;
   H11  = H11  +     1.59066261884818 * vehicle_classCategory_B ;
   H12  = H12  +     8.62861151323544 * vehicle_classCategory_B ;
   H13  = H13  +     1.00375374415929 * vehicle_classCategory_B ;
   H11  =     0.52249685967013 + H11 ;
   H12  =     10.4595585793823 + H12 ;
   H13  =    -5.44204945446839 + H13 ;
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
   P_Adj_Prem  =     13315.9260785816 * H11  +    -5948.74449213692 * H12
          +     10413.5224540424 * H13 ;
   P_Adj_Prem  =     67312.3058406252 + P_Adj_Prem ;
END;
ELSE DO;
   P_Adj_Prem  = .;
END;
IF _DM_BAD EQ 1 THEN DO;
   P_Adj_Prem  =     59622.9019607843;
END;
********************************;
*** End Scoring Code for Neural;
********************************;
