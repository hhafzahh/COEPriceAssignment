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
