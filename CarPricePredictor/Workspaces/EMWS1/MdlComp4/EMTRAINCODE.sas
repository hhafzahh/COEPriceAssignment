data EMWS1.MdlComp4_EMRANK;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGETLABEL =
   "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Reg4" MODEL "Reg4" MODELDESCRIPTION "Regression" TARGETLABEL "";
set EMWS1.Reg4_EMRANK;
where upcase(TARGET) = upcase("premium");
run;
data EMWS1.MdlComp4_EMSCOREDIST;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGETLABEL =
   "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Reg4" MODEL "Reg4" MODELDESCRIPTION "Regression" TARGETLABEL "";
set EMWS1.Reg4_EMSCOREDIST;
where upcase(TARGET) = upcase("premium");
run;
data EMWS1.MdlComp4_EMOUTFIT;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGETLABEL =
   "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Reg4" MODEL "Reg4" MODELDESCRIPTION "Regression" TARGETLABEL "";
set WORK.Reg4_OUTFIT;
where upcase(TARGET) = upcase("premium");
run;
data EMWS1.MdlComp4_EMRESIDUAL;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGETLABEL =
   "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Reg4" MODEL "Reg4" MODELDESCRIPTION "Regression" TARGETLABEL "";
set EMWS1.Reg4_EMRESIDUAL;
where upcase(TARGET) = upcase("premium");
run;
data work.MdlComp4_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Neural7" MODEL "Neural7" MODELDESCRIPTION "Neural Network" TARGETLABEL "";
set EMWS1.Neural7_EMRANK;
where upcase(TARGET) = upcase("premium");
run;
data EMWS1.MdlComp4_EMRANK;
set EMWS1.MdlComp4_EMRANK work.MdlComp4_TEMP;
run;
data work.MdlComp4_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Neural7" MODEL "Neural7" MODELDESCRIPTION "Neural Network" TARGETLABEL "";
set EMWS1.Neural7_EMSCOREDIST;
where upcase(TARGET) = upcase("premium");
run;
data EMWS1.MdlComp4_EMSCOREDIST;
set EMWS1.MdlComp4_EMSCOREDIST work.MdlComp4_TEMP;
run;
data work.MdlComp4_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Neural7" MODEL "Neural7" MODELDESCRIPTION "Neural Network" TARGETLABEL "";
set WORK.Neural7_OUTFIT;
where upcase(TARGET) = upcase("premium");
run;
data EMWS1.MdlComp4_EMOUTFIT;
set EMWS1.MdlComp4_EMOUTFIT work.MdlComp4_TEMP;
run;
data work.MdlComp4_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Neural7" MODEL "Neural7" MODELDESCRIPTION "Neural Network" TARGETLABEL "";
set EMWS1.Neural7_EMRESIDUAL;
where upcase(TARGET) = upcase("premium");
run;
data EMWS1.MdlComp4_EMRESIDUAL;
set EMWS1.MdlComp4_EMRESIDUAL work.MdlComp4_TEMP;
run;
data work.MdlComp4_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Neural8" MODEL "Neural8" MODELDESCRIPTION "ANN w Settings" TARGETLABEL "";
set EMWS1.Neural8_EMRANK;
where upcase(TARGET) = upcase("premium");
run;
data EMWS1.MdlComp4_EMRANK;
set EMWS1.MdlComp4_EMRANK work.MdlComp4_TEMP;
run;
data work.MdlComp4_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Neural8" MODEL "Neural8" MODELDESCRIPTION "ANN w Settings" TARGETLABEL "";
set EMWS1.Neural8_EMSCOREDIST;
where upcase(TARGET) = upcase("premium");
run;
data EMWS1.MdlComp4_EMSCOREDIST;
set EMWS1.MdlComp4_EMSCOREDIST work.MdlComp4_TEMP;
run;
data work.MdlComp4_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Neural8" MODEL "Neural8" MODELDESCRIPTION "ANN w Settings" TARGETLABEL "";
set WORK.Neural8_OUTFIT;
where upcase(TARGET) = upcase("premium");
run;
data EMWS1.MdlComp4_EMOUTFIT;
set EMWS1.MdlComp4_EMOUTFIT work.MdlComp4_TEMP;
run;
data work.MdlComp4_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Neural8" MODEL "Neural8" MODELDESCRIPTION "ANN w Settings" TARGETLABEL "";
set EMWS1.Neural8_EMRESIDUAL;
where upcase(TARGET) = upcase("premium");
run;
data EMWS1.MdlComp4_EMRESIDUAL;
set EMWS1.MdlComp4_EMRESIDUAL work.MdlComp4_TEMP;
run;
data work.MdlComp4_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Ensmbl" MODEL "Ensmbl" MODELDESCRIPTION "Ensemble" TARGETLABEL "";
set EMWS1.Ensmbl_EMRANK;
where upcase(TARGET) = upcase("premium");
run;
data EMWS1.MdlComp4_EMRANK;
set EMWS1.MdlComp4_EMRANK work.MdlComp4_TEMP;
run;
data work.MdlComp4_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Ensmbl" MODEL "Ensmbl" MODELDESCRIPTION "Ensemble" TARGETLABEL "";
set EMWS1.Ensmbl_EMSCOREDIST;
where upcase(TARGET) = upcase("premium");
run;
data EMWS1.MdlComp4_EMSCOREDIST;
set EMWS1.MdlComp4_EMSCOREDIST work.MdlComp4_TEMP;
run;
data work.MdlComp4_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Ensmbl" MODEL "Ensmbl" MODELDESCRIPTION "Ensemble" TARGETLABEL "";
set WORK.Ensmbl_OUTFIT;
where upcase(TARGET) = upcase("premium");
run;
data EMWS1.MdlComp4_EMOUTFIT;
set EMWS1.MdlComp4_EMOUTFIT work.MdlComp4_TEMP;
run;
data work.MdlComp4_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Ensmbl" MODEL "Ensmbl" MODELDESCRIPTION "Ensemble" TARGETLABEL "";
set EMWS1.Ensmbl_EMRESIDUAL;
where upcase(TARGET) = upcase("premium");
run;
data EMWS1.MdlComp4_EMRESIDUAL;
set EMWS1.MdlComp4_EMRESIDUAL work.MdlComp4_TEMP;
run;
