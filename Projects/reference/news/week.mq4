//+------------------------------------------------------------------+
//|                                                         news.mq4 |
//|                        Copyright 2013, MetaQuotes Software Corp. |
//|                                        http://www.metaquotes.net |
//+------------------------------------------------------------------+
#property copyright "Copyright 2013, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net"

#property indicator_chart_window


//--- input parameters

extern bool DisplayText = true;

extern bool Japan = true;
extern bool USA = true;
extern bool Germany = true;
extern bool EU = true;
extern bool GB = true;
extern bool Canada = true;
extern bool Australia = true;


 
extern string FileName = "week.txt";

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+

  int start()
  {
  
  ObjectsDeleteAll();
  
   int handle;
   handle=FileOpen(FileName,FILE_CSV|FILE_READ,';');
   if(handle<1)
    {
     Print("File not found, the last error is ", GetLastError());
     return(false);
    }
    
    
   int i= 0;
   while(!FileIsEnding(handle))
   {
    string sDate=FileReadString(handle); // Date
    string sTime=FileReadString(handle); // Time
    string sDescription=FileReadString(handle); // Description
    string sCountry=FileReadString(handle); // Country
    string sPeriod=FileReadString(handle); // Period
    string sCurrent=FileReadString(handle); // Current value
    string sForecast=FileReadString(handle); // Expected
    FileReadString(handle); // null
    
    i++;
    datetime dt = StrToTime(sDate+" "+sTime);
    
         color c = Red;


         if (sCountry == "Japan") c = Yellow;
         if (sCountry == "USA") c = Brown;
         if (sCountry == "Germany") c = Green;
         if (sCountry == "Eurozone") c = Blue;
         if (sCountry == "U.K.") c = Orange;
         if (sCountry == "Canada") c = Gray;
         if (sCountry == "Australia") c = DarkViolet;

         
 
 
         if ((sCountry == "Japan") && (!Japan)) continue;
         if ((sCountry == "USA") && (!USA)) continue;
         if ((sCountry == "Germany") && (!Germany)) continue;
         if ((sCountry == "Eurozone") && (!EU)) continue;
         if ((sCountry == "U.K.") && (!GB)) continue;
         if ((sCountry == "Canada") && (!Canada)) continue;
         if ((sCountry == "Australia") && (!Australia)) 
              continue;                   
            
            
          if (DisplayText)
          {
          ObjectCreate("x"+i, OBJ_TEXT, 0, dt, Close[0]);
          ObjectSet("x"+i, OBJPROP_COLOR, c);          
          ObjectSetText("x"+i, sDescription + " "+ sCountry + " " + sPeriod + " " + sCurrent + " " + sForecast, 8);          
          ObjectSet("x"+i, OBJPROP_ANGLE, 90);          
          }
          
                   
          ObjectCreate("y"+i, OBJ_VLINE, 0, dt, Close[0]);
          ObjectSet("y"+i, OBJPROP_COLOR, c);                    
          ObjectSet("y"+i, OBJPROP_STYLE, STYLE_DOT);                    
          ObjectSet("y"+i, OBJPROP_BACK, true);          
          ObjectSetText("y"+i, sDescription + " "+ sCountry + " " + sPeriod + " " + sCurrent + " " + sForecast, 8);                    

   }    

   return(0);
  }
//+------------------------------------------------------------------+