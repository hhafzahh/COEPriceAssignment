*------------------------------------------------------------*;
* EM SCORE CODE;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* TOOL: Extension Class;
* TYPE: SAMPLE;
* NODE: FIMPORT;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* TOOL: Partition Class;
* TYPE: SAMPLE;
* NODE: Part;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* TOOL: Neural;
* TYPE: MODEL;
* NODE: Neural;
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

      label vehicle_classCategory_B = 'Dummy: vehicle_class=Category B' ;

      label H11 = 'Hidden: H1=1' ;

      label H12 = 'Hidden: H1=2' ;

      label H13 = 'Hidden: H1=3' ;

      label P_Adj_Prem = 'Predicted: Adj_Prem' ;

      label R_Adj_Prem = 'Residual: Adj_Prem' ;

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
*** *****************************;
*** Writing the Residuals  of the Node intervalTargets ;
*** ******************************;
IF MISSING( Adj_Prem ) THEN R_Adj_Prem  = . ;
ELSE R_Adj_Prem  = Adj_Prem  - P_Adj_Prem ;
********************************;
*** End Scoring Code for Neural;
********************************;
drop
H11
H12
H13
;
drop S_:;
*------------------------------------------------------------*;
* TOOL: Model Compare Class;
* TYPE: ASSESS;
* NODE: MdlComp;
*------------------------------------------------------------*;
if (P_Adj_Prem ge 82497.102022182) then do;
b_Adj_Prem = 1;
end;
else
if (P_Adj_Prem ge 81017.7376017623) then do;
b_Adj_Prem = 2;
end;
else
if (P_Adj_Prem ge 79449.310674135) then do;
b_Adj_Prem = 3;
end;
else
if (P_Adj_Prem ge 76607.9072844846) then do;
b_Adj_Prem = 4;
end;
else
if (P_Adj_Prem ge 75405.4884376069) then do;
b_Adj_Prem = 5;
end;
else
if (P_Adj_Prem ge 65743.8090108718) then do;
b_Adj_Prem = 6;
end;
else
if (P_Adj_Prem ge 64331.9546389506) then do;
b_Adj_Prem = 7;
end;
else
if (P_Adj_Prem ge 63985.3639521419) then do;
b_Adj_Prem = 8;
end;
else
if (P_Adj_Prem ge 62665.9250474854) then do;
b_Adj_Prem = 9;
end;
else
if (P_Adj_Prem ge 59469.7105883833) then do;
b_Adj_Prem = 10;
end;
else
if (P_Adj_Prem ge 54724.7562247901) then do;
b_Adj_Prem = 11;
end;
else
if (P_Adj_Prem ge 52460.7587667632) then do;
b_Adj_Prem = 12;
end;
else
if (P_Adj_Prem ge 49612.4695881872) then do;
b_Adj_Prem = 13;
end;
else
if (P_Adj_Prem ge 48514.5862463777) then do;
b_Adj_Prem = 14;
end;
else
if (P_Adj_Prem ge 46410.7939630466) then do;
b_Adj_Prem = 15;
end;
else
if (P_Adj_Prem ge 44419.8774226694) then do;
b_Adj_Prem = 16;
end;
else
if (P_Adj_Prem ge 42214.2109660753) then do;
b_Adj_Prem = 17;
end;
else
if (P_Adj_Prem ge 41191.5566209406) then do;
b_Adj_Prem = 18;
end;
else
if (P_Adj_Prem ge 39525.0375066273) then do;
b_Adj_Prem = 19;
end;
else
do;
b_Adj_Prem = 20;
end;
*------------------------------------------------------------*;
* TOOL: Score Node;
* TYPE: ASSESS;
* NODE: Score;
*------------------------------------------------------------*;
*------------------------------------------------------------*;
* Score: Creating Fixed Names;
*------------------------------------------------------------*;
LABEL EM_SEGMENT = 'Segment';
EM_SEGMENT = b_Adj_Prem;
LABEL EM_PREDICTION= "Prediction for Adj_Prem";
EM_PREDICTION = P_Adj_Prem;
LABEL = 'Target Variable: Adj_Prem';
EM_VALUETARGET = Adj_Prem;
