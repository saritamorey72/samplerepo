proc export data=sashelp.class
outfile="/test_mosaic/G2/U1run_text_file.txt"
dbms=tab;
run;

proc import datafile="/test_mosaic/G2/U1run_text_file.txt" out=mydata dbms=dlm replace;
   delimiter='09'x;
   getnames=yes;
run;

proc print data=mydata;
run;