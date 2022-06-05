data EMWS1.MdlComp5_EMRANK;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGETLABEL =
   "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Neural2" MODEL "Neural2" MODELDESCRIPTION "Neural Network (2)" TARGETLABEL "";
set EMWS1.Neural2_EMRANK;
where upcase(TARGET) = upcase("Adj_Prem");
run;
data EMWS1.MdlComp5_EMSCOREDIST;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGETLABEL =
   "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Neural2" MODEL "Neural2" MODELDESCRIPTION "Neural Network (2)" TARGETLABEL "";
set EMWS1.Neural2_EMSCOREDIST;
where upcase(TARGET) = upcase("Adj_Prem");
run;
data EMWS1.MdlComp5_EMOUTFIT;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGETLABEL =
   "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Neural2" MODEL "Neural2" MODELDESCRIPTION "Neural Network (2)" TARGETLABEL "";
set WORK.Neural2_OUTFIT;
where upcase(TARGET) = upcase("Adj_Prem");
run;
data EMWS1.MdlComp5_EMRESIDUAL;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGETLABEL =
   "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Neural2" MODEL "Neural2" MODELDESCRIPTION "Neural Network (2)" TARGETLABEL "";
set EMWS1.Neural2_EMRESIDUAL;
where upcase(TARGET) = upcase("Adj_Prem");
run;
data work.MdlComp5_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Reg2" MODEL "Reg2" MODELDESCRIPTION "Regression" TARGETLABEL "";
set EMWS1.Reg2_EMRANK;
where upcase(TARGET) = upcase("Adj_Prem");
run;
data EMWS1.MdlComp5_EMRANK;
set EMWS1.MdlComp5_EMRANK work.MdlComp5_TEMP;
run;
data work.MdlComp5_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Reg2" MODEL "Reg2" MODELDESCRIPTION "Regression" TARGETLABEL "";
set EMWS1.Reg2_EMSCOREDIST;
where upcase(TARGET) = upcase("Adj_Prem");
run;
data EMWS1.MdlComp5_EMSCOREDIST;
set EMWS1.MdlComp5_EMSCOREDIST work.MdlComp5_TEMP;
run;
data work.MdlComp5_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Reg2" MODEL "Reg2" MODELDESCRIPTION "Regression" TARGETLABEL "";
set WORK.Reg2_OUTFIT;
where upcase(TARGET) = upcase("Adj_Prem");
run;
data EMWS1.MdlComp5_EMOUTFIT;
set EMWS1.MdlComp5_EMOUTFIT work.MdlComp5_TEMP;
run;
data work.MdlComp5_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Reg2" MODEL "Reg2" MODELDESCRIPTION "Regression" TARGETLABEL "";
set EMWS1.Reg2_EMRESIDUAL;
where upcase(TARGET) = upcase("Adj_Prem");
run;
data EMWS1.MdlComp5_EMRESIDUAL;
set EMWS1.MdlComp5_EMRESIDUAL work.MdlComp5_TEMP;
run;
data work.MdlComp5_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Neural5" MODEL "Neural5" MODELDESCRIPTION "Neural Network" TARGETLABEL "";
set EMWS1.Neural5_EMRANK;
where upcase(TARGET) = upcase("Adj_Prem");
run;
data EMWS1.MdlComp5_EMRANK;
set EMWS1.MdlComp5_EMRANK work.MdlComp5_TEMP;
run;
data work.MdlComp5_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Neural5" MODEL "Neural5" MODELDESCRIPTION "Neural Network" TARGETLABEL "";
set EMWS1.Neural5_EMSCOREDIST;
where upcase(TARGET) = upcase("Adj_Prem");
run;
data EMWS1.MdlComp5_EMSCOREDIST;
set EMWS1.MdlComp5_EMSCOREDIST work.MdlComp5_TEMP;
run;
data work.MdlComp5_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Neural5" MODEL "Neural5" MODELDESCRIPTION "Neural Network" TARGETLABEL "";
set WORK.Neural5_OUTFIT;
where upcase(TARGET) = upcase("Adj_Prem");
run;
data EMWS1.MdlComp5_EMOUTFIT;
set EMWS1.MdlComp5_EMOUTFIT work.MdlComp5_TEMP;
run;
data work.MdlComp5_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Neural5" MODEL "Neural5" MODELDESCRIPTION "Neural Network" TARGETLABEL "";
set EMWS1.Neural5_EMRESIDUAL;
where upcase(TARGET) = upcase("Adj_Prem");
run;
data EMWS1.MdlComp5_EMRESIDUAL;
set EMWS1.MdlComp5_EMRESIDUAL work.MdlComp5_TEMP;
run;
