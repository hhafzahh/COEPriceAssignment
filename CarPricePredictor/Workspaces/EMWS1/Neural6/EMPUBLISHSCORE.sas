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
   H101  =     0.64797570329534 * S_Adjusted_Quota ;
   H102  =     1.32597366339027 * S_Adjusted_Quota ;
   H103  =     0.49745117517427 * S_Adjusted_Quota ;
   H104  =     1.87569460310576 * S_Adjusted_Quota ;
   H105  =    -0.14185241468197 * S_Adjusted_Quota ;
   H106  =    -0.23890381715264 * S_Adjusted_Quota ;
   H107  =    -0.02008602032159 * S_Adjusted_Quota ;
   H108  =     0.78114977877569 * S_Adjusted_Quota ;
   H109  =     0.96387989519895 * S_Adjusted_Quota ;
   H110  =    -0.27248740079573 * S_Adjusted_Quota ;
   H111  =    -0.35404162044693 * S_Adjusted_Quota ;
   H112  =     3.87103537905882 * S_Adjusted_Quota ;
   H113  =    -1.43512788745263 * S_Adjusted_Quota ;
   H114  =     3.96300391049919 * S_Adjusted_Quota ;
   H115  =    -0.42442803732638 * S_Adjusted_Quota ;
   H116  =     0.54472078871894 * S_Adjusted_Quota ;
   H117  =    -0.83040465372898 * S_Adjusted_Quota ;
   H118  =     0.84536759433205 * S_Adjusted_Quota ;
   H119  =      0.0447089681765 * S_Adjusted_Quota ;
   H120  =     0.19582043272484 * S_Adjusted_Quota ;
   H101  = H101  +    -0.64996058445145 * vehicle_classCategory_B ;
   H102  = H102  +    -0.42524976329234 * vehicle_classCategory_B ;
   H103  = H103  +    -1.25546882726277 * vehicle_classCategory_B ;
   H104  = H104  +    -1.84813177666984 * vehicle_classCategory_B ;
   H105  = H105  +    -0.30122438540591 * vehicle_classCategory_B ;
   H106  = H106  +    -0.02883969696436 * vehicle_classCategory_B ;
   H107  = H107  +      0.1223717150837 * vehicle_classCategory_B ;
   H108  = H108  +     -0.5205098264903 * vehicle_classCategory_B ;
   H109  = H109  +     0.56985562828286 * vehicle_classCategory_B ;
   H110  = H110  +    -0.84198585903898 * vehicle_classCategory_B ;
   H111  = H111  +    -0.66232910778851 * vehicle_classCategory_B ;
   H112  = H112  +     1.25106929148192 * vehicle_classCategory_B ;
   H113  = H113  +     0.32348277389725 * vehicle_classCategory_B ;
   H114  = H114  +    -0.39881404233828 * vehicle_classCategory_B ;
   H115  = H115  +    -1.50955173797035 * vehicle_classCategory_B ;
   H116  = H116  +     0.44358050193108 * vehicle_classCategory_B ;
   H117  = H117  +    -0.10569912891827 * vehicle_classCategory_B ;
   H118  = H118  +      0.1266801895489 * vehicle_classCategory_B ;
   H119  = H119  +    -0.36029236964274 * vehicle_classCategory_B ;
   H120  = H120  +    -0.60671264397755 * vehicle_classCategory_B ;
   H101  =     0.97581170717534 + H101 ;
   H102  =    -2.13459485229217 + H102 ;
   H103  =     0.21973894473311 + H103 ;
   H104  =    -0.24148292931493 + H104 ;
   H105  =    -0.45444232250271 + H105 ;
   H106  =    -0.97892913370129 + H106 ;
   H107  =     1.71593225232248 + H107 ;
   H108  =    -1.19001147259891 + H108 ;
   H109  =    -0.15561179336485 + H109 ;
   H110  =     0.16717686839313 + H110 ;
   H111  =     0.01799262205943 + H111 ;
   H112  =     -0.4553139269063 + H112 ;
   H113  =      0.0034672900325 + H113 ;
   H114  =     2.71417321170581 + H114 ;
   H115  =     0.51826184214865 + H115 ;
   H116  =    -1.57505397074414 + H116 ;
   H117  =    -0.52744519549276 + H117 ;
   H118  =    -0.17419660806239 + H118 ;
   H119  =     1.92178084105053 + H119 ;
   H120  =      0.7164136818597 + H120 ;
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
   P_Adj_Prem  =     -21797.024699147 * H101  +     4670.10224215114 * H102
          +     9629.97118001381 * H103  +    -13968.0504101666 * H104
          +    -3932.51173549932 * H105  +    -13180.8401031364 * H106
          +     4419.37980333567 * H107  +     1436.74377989238 * H108
          +    -9241.35155162992 * H109  +    -1044.95791661515 * H110
          +     521.197617944967 * H111  +     8802.91104622464 * H112
          +    -1559.40966329306 * H113  +    -10630.6025936185 * H114
          +    -1632.11147652328 * H115  +     3137.10068364992 * H116
          +     5367.80707469991 * H117  +    -1733.19190081798 * H118
          +     4644.20345968211 * H119  +     8121.65889564774 * H120 ;
   P_Adj_Prem  =     64083.3762488153 + P_Adj_Prem ;
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
