if NAME = "P_Adj_Prem" then ROLE = 'REJECTED';
if NAME = "EM_CLASSIFICATION" then LEVEL = 'NOMINAL';
else if NAME = "EM_PREDICTION" then LEVEL = 'INTERVAL';
else if NAME = "EM_PROBABILITY" then LEVEL = 'INTERVAL';
else if NAME = "EM_EVENTPROBABILITY" then LEVEL = 'INTERVAL';
else if NAME = "EM_DECISION" then LEVEL = 'NOMINAL';
else if NAME = "EM_PROFIT" then LEVEL = 'INTERVAL';
else if NAME = "EM_SEGMENT" then LEVEL = 'NOMINAL';
else if NAME = "EM_VALUETARGET" then LEVEL = 'INTERVAL';
else if NAME = "EM_CLASSTARGET" then LEVEL = 'INTERVAL';
