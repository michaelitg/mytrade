//+------------------------------------------------------------------+
//|                                                  TLine Alert.mq4 |
//+------------------------------------------------------------------+
// 4xleader@gmail.com - updated with popup and alert on new candle. enjoy the basics 
#property copyright "raff1410@o2.pl"

#property indicator_chart_window
extern string TLineName="MyLine2";
extern color LineColor=Red; 
extern int LineStyle=STYLE_SOLID;
extern int AlertPipRange=5;
extern string AlertWav="alert.wav";
extern bool popup = true;

bool alerted = false;
datetime prevtime=0;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
//---- indicators
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit()
  {
//----
   
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start()
  {
  
if(prevtime == Time[0]) return(0);

prevtime = Time[0];
alerted = false;


   int    counted_bars=IndicatorCounted();
      ObjectCreate(TLineName, OBJ_TREND, 0, Time[50], High[25], Time[2], High[2]);
      ObjectSet(TLineName, OBJPROP_STYLE, LineStyle);
      ObjectSet(TLineName, OBJPROP_COLOR, LineColor);

      double val=ObjectGetValueByShift(TLineName, 0);
      
      if (Bid-AlertPipRange*Point <= val && Bid+AlertPipRange*Point >= val)
      {
       if ( alerted == false){
      PlaySound(AlertWav); alerted = true;}
      if ( popup){ Alert(" Trend Line Break", Symbol());}
      } 
     
     
      
      
      
     
      

//----
//----
   return(0);
  }
//+------------------------------------------------------------------+