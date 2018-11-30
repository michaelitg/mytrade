//+------------------------------------------------------------------+
//|                                                           Z1.mq4 |
//|                      Copyright © 2005, MetaQuotes Software Corp. |
//|                                       http://www.metaquotes.net/ |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2005, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net/"

#property indicator_chart_window
#property indicator_buffers 1
#property indicator_color1 Blue

//---- indicator parameters
extern int ExtDepth=25;
extern int ExtDeviation=5;
extern int ExtBackstep=3;
extern int barn=1500;
extern int from=0;

extern bool alertsSound     = true; 

//---- indicator buffers
double ExtMapBuffer[];
double ExtMapBuffer2[];

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
   IndicatorBuffers(2);
   
//---- drawing settings
   SetIndexStyle(0,DRAW_ARROW);
   SetIndexArrow(0,108);
   
//---- indicator buffers mapping
   SetIndexBuffer(0,ExtMapBuffer);
   SetIndexBuffer(1,ExtMapBuffer2);
   SetIndexEmptyValue(0,0.0);
   ArraySetAsSeries(ExtMapBuffer,true);
   ArraySetAsSeries(ExtMapBuffer2,true);
   
//---- indicator short name
   IndicatorShortName("ZigZag("+ExtDepth+","+ExtDeviation+","+ExtBackstep+")");
   
//---- initialization done
   return(0);
  }
  
datetime last_time = 0;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int start()
  {
   int    shift=barn, back,lasthighpos,lastlowpos;
   double val,res;
   double curlow,curhigh,lasthigh,lastlow;

   for(shift=barn-ExtDepth; shift>from; shift--){
      val=Low[Lowest(NULL,0,MODE_LOW,ExtDepth,shift)];
      if(val==lastlow) 
         val=0.0;
      else { 
         lastlow=val; 
         if((Low[shift]-val)>(ExtDeviation*Point)) 
            val=0.0;
         else{
            for(back=1; back<=ExtBackstep; back++){
               res=ExtMapBuffer[shift+back];
               if((res!=0)&&(res>val)) ExtMapBuffer[shift+back]=0.0; 
               }
            }
         } 
      ExtMapBuffer[shift]=val;
      //--- high
      val=High[Highest(NULL,0,MODE_HIGH,ExtDepth,shift)];
      if(val==lasthigh) 
         val=0.0;
      else{
         lasthigh=val;
         if((val-High[shift])>(ExtDeviation*Point)) 
            val=0.0;
         else{
            for(back=1; back<=ExtBackstep; back++){
               res=ExtMapBuffer2[shift+back];
               if((res!=0)&&(res<val)) ExtMapBuffer2[shift+back]=0.0; 
               } 
            }
         }
      ExtMapBuffer2[shift]=val;
      }

   // final cutting 
   lasthigh=-1; lasthighpos=-1;
   lastlow=-1;  lastlowpos=-1;

   for(shift=barn-ExtDepth; shift>from; shift--){
      curlow=ExtMapBuffer[shift];
      curhigh=ExtMapBuffer2[shift];
      if((curlow==0)&&(curhigh==0)) continue;
      //---
      if(curhigh!=0){
         if(lasthigh>0){
            if(lasthigh<curhigh) ExtMapBuffer2[lasthighpos]=0;
            else ExtMapBuffer2[shift]=0;
            }
         //---
         if(lasthigh<curhigh || lasthigh<0){
            lasthigh=curhigh;
            lasthighpos=shift;
            }
         lastlow=-1;
         }
      //----
      if(curlow!=0){
         if(lastlow>0){
            if(lastlow>curlow) ExtMapBuffer[lastlowpos]=0;
            else ExtMapBuffer[shift]=0;
            }
         //---
         if((curlow<lastlow)||(lastlow<0)){
            lastlow=curlow;
            lastlowpos=shift;
            } 
         lasthigh=-1;
         }
      }
  
   for(shift=barn-1; shift>from; shift--){
      if(shift>=barn-ExtDepth) ExtMapBuffer[shift]=0.0;
      else{
         res=ExtMapBuffer2[shift];
         if(res!=0.0) ExtMapBuffer[shift]=res;
         }
      }
   int last_found[2],f = 0; 
   for(shift=from+1; f<2 && shift<barn; shift++){
      if(ExtMapBuffer[shift]!=0){
         last_found[f] = shift;
         f++;
         }
      }
   if(f>0){
      if(last_time != Time[last_found[0]]){
         last_time = Time[last_found[0]];
         double dir = ExtMapBuffer[last_found[0]]-ExtMapBuffer[last_found[1]];
         if(dir>0){
            Alert("Found SELL signal Z-Z1["+Period()+"] at "+Symbol()+",bar = "+last_found[0]);
            }
         else if(dir<0){
            Alert("Found BUY signal Z-Z1["+Period()+"] at "+Symbol()+",bar = "+last_found[0]);
            }
         else if(f==1){
            Alert("Found signal Z-Z1["+Period()+"] at "+Symbol()+",bar = "+last_found[0]);
             if (alertsSound)   PlaySound("alert2.wav");
            }
         }
      }
}