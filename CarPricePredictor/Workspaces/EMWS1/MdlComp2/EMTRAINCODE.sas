data EMWS1.MdlComp2_EMRANK;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGETLABEL =
   "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Reg2" MODEL "Reg2" MODELDESCRIPTION "Regression" TARGETLABEL "";
set EMWS1.Reg2_EMRANK;
where upcase(TARGET) = upcase("Adj_Prem");
run;
data EMWS1.MdlComp2_EMSCOREDIST;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGETLABEL =
   "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Reg2" MODEL "Reg2" MODELDESCRIPTION "Regression" TARGETLABEL "";
set EMWS1.Reg2_EMSCOREDIST;
where upcase(TARGET) = upcase("Adj_Prem");
run;
data EMWS1.MdlComp2_EMOUTFIT;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGETLABEL =
   "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Reg2" MODEL "Reg2" MODELDESCRIPTION "Regression" TARGETLABEL "";
set WORK.Reg2_OUTFIT;
where upcase(TARGET) = upcase("Adj_Prem");
run;
data EMWS1.MdlComp2_EMRESIDUAL;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGETLABEL =
   "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Reg2" MODEL "Reg2" MODELDESCRIPTION "Regression" TARGETLABEL "";
set EMWS1.Reg2_EMRESIDUAL;
where upcase(TARGET) = upcase("Adj_Prem");
run;
data work.MdlComp2_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Neural3" MODEL "Neural3" MODELDESCRIPTION "Neural Network" TARGETLABEL "";
set EMWS1.Neural3_EMRANK;
where upcase(TARGET) = upcase("Adj_Prem");
run;
data EMWS1.MdlComp2_EMRANK;
set EMWS1.MdlComp2_EMRANK work.MdlComp2_TEMP;
run;
data work.MdlComp2_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Neural3" MODEL "Neural3" MODELDESCRIPTION "Neural Network" TARGETLABEL "";
set EMWS1.Neural3_EMSCOREDIST;
where upcase(TARGET) = upcase("Adj_Prem");
run;
data EMWS1.MdlComp2_EMSCOREDIST;
set EMWS1.MdlComp2_EMSCOREDIST work.MdlComp2_TEMP;
run;
data work.MdlComp2_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Neural3" MODEL "Neural3" MODELDESCRIPTION "Neural Network" TARGETLABEL "";
set WORK.Neural3_OUTFIT;
where upcase(TARGET) = upcase("Adj_Prem");
run;
data EMWS1.MdlComp2_EMOUTFIT;
set EMWS1.MdlComp2_EMOUTFIT work.MdlComp2_TEMP;
run;
data work.MdlComp2_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Neural3" MODEL "Neural3" MODELDESCRIPTION "Neural Network" TARGETLABEL "";
set EMWS1.Neural3_EMRESIDUAL;
where upcase(TARGET) = upcase("Adj_Prem");
run;
data EMWS1.MdlComp2_EMRESIDUAL;
set EMWS1.MdlComp2_EMRESIDUAL work.MdlComp2_TEMP;
run;
data work.MdlComp2_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Neural4" MODEL "Neural4" MODELDESCRIPTION "Neural Network (2)" TARGETLABEL "";
set EMWS1.Neural4_EMRANK;
where upcase(TARGET) = upcase("Adj_Prem");
run;
data EMWS1.MdlComp2_EMRANK;
set EMWS1.MdlComp2_EMRANK work.MdlComp2_TEMP;
run;
data work.MdlComp2_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Neural4" MODEL "Neural4" MODELDESCRIPTION "Neural Network (2)" TARGETLABEL "";
set EMWS1.Neural4_EMSCOREDIST;
where upcase(TARGET) = upcase("Adj_Prem");
run;
data EMWS1.MdlComp2_EMSCOREDIST;
set EMWS1.MdlComp2_EMSCOREDIST work.MdlComp2_TEMP;
run;
data work.MdlComp2_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Neural4" MODEL "Neural4" MODELDESCRIPTION "Neural Network (2)" TARGETLABEL "";
set WORK.Neural4_OUTFIT;
where upcase(TARGET) = upcase("Adj_Prem");
run;
data EMWS1.MdlComp2_EMOUTFIT;
set EMWS1.MdlComp2_EMOUTFIT work.MdlComp2_TEMP;
run;
data work.MdlComp2_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Neural4" MODEL "Neural4" MODELDESCRIPTION "Neural Network (2)" TARGETLABEL "";
set EMWS1.Neural4_EMRESIDUAL;
where upcase(TARGET) = upcase("Adj_Prem");
run;
data EMWS1.MdlComp2_EMRESIDUAL;
set EMWS1.MdlComp2_EMRESIDUAL work.MdlComp2_TEMP;
run;
data work.MdlComp2_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Ensmbl3" MODEL "Ensmbl3" MODELDESCRIPTION "Ensemble (2)" TARGETLABEL "";
set EMWS1.Ensmbl3_EMRANK;
where upcase(TARGET) = upcase("Adj_Prem");
run;
data EMWS1.MdlComp2_EMRANK;
set EMWS1.MdlComp2_EMRANK work.MdlComp2_TEMP;
run;
data work.MdlComp2_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Ensmbl3" MODEL "Ensmbl3" MODELDESCRIPTION "Ensemble (2)" TARGETLABEL "";
set EMWS1.Ensmbl3_EMSCOREDIST;
where upcase(TARGET) = upcase("Adj_Prem");
run;
data EMWS1.MdlComp2_EMSCOREDIST;
set EMWS1.MdlComp2_EMSCOREDIST work.MdlComp2_TEMP;
run;
data work.MdlComp2_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Ensmbl3" MODEL "Ensmbl3" MODELDESCRIPTION "Ensemble (2)" TARGETLABEL "";
set WORK.Ensmbl3_OUTFIT;
where upcase(TARGET) = upcase("Adj_Prem");
run;
data EMWS1.MdlComp2_EMOUTFIT;
set EMWS1.MdlComp2_EMOUTFIT work.MdlComp2_TEMP;
run;
data work.MdlComp2_TEMP;
length PARENT $16 MODEL $16 MODELDESCRIPTION $81 DATAROLE $20 TARGET $32 TARGETLABEL $200;
label PARENT = "%sysfunc(sasmsg(sashelp.dmine, rpt_parent_vlabel  ,  NOQUOTE))" MODEL = "%sysfunc(sasmsg(sashelp.dmine, rpt_modelnode_vlabel, NOQUOTE))" MODELDESCRIPTION = "%sysfunc(sasmsg(sashelp.dmine, rpt_modeldesc_vlabel, NOQUOTE))" TARGET =
   "%sysfunc(sasmsg(sashelp.dmine, rpt_targetvar_vlabel, NOQUOTE))" TARGETLABEL = "%sysfunc(sasmsg(sashelp.dmine, meta_targetlabel_vlabel, NOQUOTE))";
retain parent "Ensmbl3" MODEL "Ensmbl3" MODELDESCRIPTION "Ensemble (2)" TARGETLABEL "";
set EMWS1.Ensmbl3_EMRESIDUAL;
where upcase(TARGET) = upcase("Adj_Prem");
run;
data EMWS1.MdlComp2_EMRESIDUAL;
set EMWS1.MdlComp2_EMRESIDUAL work.MdlComp2_TEMP;
run;
