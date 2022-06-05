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
