//+------------------------------------------------------------------+
//|                                                        test1.mq4 |
//+------------------------------------------------------------------+
//#property copyright "Copyright © 2011-2012, David Louisson"
//#property link      "http://www.metaquotes.net"

#property show_inputs

#include <hanover --- function header (np).mqh>

extern  string    InputFilename              = "allnews.csv";
extern  string    OutputFilename             = "GBP CPI.csv";

string     ccy, sym, IndiName, diag_string, FontName, arr[50], s, out;
int        dig, tf, tmf, vis, wno, RefreshEveryXMins, bar, Window, Corner, HorizPos, VertPos, VertSpacing, FontSize;
double     spr, pnt, tickval, bidp, askp, minlot, lswap, sswap, NewSL;

//+------------------------------------------------------------------+
int start()  {
//+------------------------------------------------------------------+

// file I/O code.....
  int h_out = FileOpen(OutputFilename,FILE_CSV|FILE_WRITE,'~');
  if (h_out < 0)    { MessageBox("Unable to open file '...\\MT4\\Files\\" + OutputFilename + "': " + err_msg(GetLastError()));   return(0); }
  int h_inp = FileOpen(InputFilename,FILE_CSV|FILE_READ,'~');
  if (h_inp < 0)    { MessageBox("Unable to open file '...\\MT4\\Files\\" + InputFilename + "': " + err_msg(GetLastError()));    return(0); }
  while (!FileIsEnding(h_inp))    {
    string s_inp = FileReadString(h_inp);
    if (FileIsEnding(h_inp))    break;
    StrToStringArray(s_inp,arr);
    if (StringFind(arr[2],"GBP")>=0 && StringFind(arr[4],"CPI y/y")>=0)
      FileWrite(h_out,s_inp);
  }
  FileClose(h_inp);
  FileClose(h_out);
  MessageBox("Job done!");
  return(0);
}

//+------------------------------------------------------------------+
#include <hanover --- extensible functions (np).mqh>