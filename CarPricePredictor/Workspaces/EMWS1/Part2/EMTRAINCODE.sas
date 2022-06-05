*------------------------------------------------------------*;
* Part2: Create random partition;
*------------------------------------------------------------*;
data
EMWS1.Part2_TRAIN(label="")
EMWS1.Part2_TEST(label="")
;
retain _seed_ 12345;
drop _seed_ _genvalue_;
call ranuni(_seed_, _genvalue_);
label _dataobs_ = "%sysfunc(sasmsg(sashelp.dmine, sample_dataobs_vlabel, NOQUOTE))";
_dataobs_ = _N_;
drop _c00:;
set EMWS1.FIMPORT2_train;
if (146 +1-_n_)*_genvalue_ <= (102 - _C000001) then do;
_C000001 + 1;
output EMWS1.Part2_TRAIN;
end;
else do;
_C000002 + 1;
output EMWS1.Part2_TEST;
end;
run;
run;
