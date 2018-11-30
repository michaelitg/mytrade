//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2012, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
#property copyright "© 2013 BEHZAD.HABIBZADEH"
#property link      "behzadhabibzade@gmail.com"
#property strict

#define major   1
#define minor   0


extern string _tmp1_=" --- Trade params ---";
extern bool MarketExecution=false;
extern int AccDigits=5;
extern double Lots=0.01;
extern int StopLoss=100;
extern int TakeProfit=100;
extern int PipsRangeFromLine=10;
extern int Slippage=3;
extern int Magic=20100620;

extern string _tmp2_=" --- TrendLine params ---";
extern string LongTrendLineDescr="LTR";
extern string ShortTrendLineDescr="STR";

extern string _tmp3_=" --- Chart ---";
extern color clBuy=Blue;
extern color clSell=Red;

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#include <stdlib.mqh>
#include <stderror.mqh>

int RepeatN=5;

int BuyCnt,SellCnt;
int BuyStopCnt,SellStopCnt;
int BuyLimitCnt,SellLimitCnt;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnInit()
  {
//--- Kajos2250
   string ls_objName="LONGbtn";
   ObjectCreate(0,ls_objName,OBJ_BUTTON,0,0,0);

   ObjectSetInteger(0,ls_objName,OBJPROP_XDISTANCE,2);
   ObjectSetInteger(0,ls_objName,OBJPROP_YDISTANCE,15);
   ObjectSetInteger(0,ls_objName,OBJPROP_XSIZE,30);
   ObjectSetInteger(0,ls_objName,OBJPROP_YSIZE,13);
   ObjectSetInteger(0,ls_objName,OBJPROP_CORNER,CORNER_LEFT_LOWER);
   ObjectSetString(0,ls_objName,OBJPROP_TEXT,"LONG");
   ObjectSetString(0,ls_objName,OBJPROP_FONT,"Arial");
   ObjectSetInteger(0,ls_objName,OBJPROP_FONTSIZE,6);
   ObjectSetInteger(0,ls_objName,OBJPROP_COLOR,clrWheat);
   ObjectSetInteger(0,ls_objName,OBJPROP_BGCOLOR,clBuy);
   ObjectSetInteger(0,ls_objName,OBJPROP_BORDER_COLOR,clrNONE);
   ObjectSetInteger(0,ls_objName,OBJPROP_BACK,false);
   ObjectSetInteger(0,ls_objName,OBJPROP_SELECTABLE,false);
   ObjectSetInteger(0,ls_objName,OBJPROP_SELECTED,false);
   ObjectSetInteger(0,ls_objName,OBJPROP_HIDDEN,false);

   ls_objName="SHORTbtn";
   ObjectCreate(0,ls_objName,OBJ_BUTTON,0,0,0);

   ObjectSetInteger(0,ls_objName,OBJPROP_XDISTANCE,2);
   ObjectSetInteger(0,ls_objName,OBJPROP_YDISTANCE,30);
   ObjectSetInteger(0,ls_objName,OBJPROP_XSIZE,30);
   ObjectSetInteger(0,ls_objName,OBJPROP_YSIZE,13);
   ObjectSetInteger(0,ls_objName,OBJPROP_CORNER,CORNER_LEFT_LOWER);
   ObjectSetString(0,ls_objName,OBJPROP_TEXT,"SHORT");
   ObjectSetString(0,ls_objName,OBJPROP_FONT,"Arial");
   ObjectSetInteger(0,ls_objName,OBJPROP_FONTSIZE,6);
   ObjectSetInteger(0,ls_objName,OBJPROP_COLOR,clrWheat);
   ObjectSetInteger(0,ls_objName,OBJPROP_BGCOLOR,clSell);
   ObjectSetInteger(0,ls_objName,OBJPROP_BORDER_COLOR,clrNONE);
   ObjectSetInteger(0,ls_objName,OBJPROP_BACK,false);
   ObjectSetInteger(0,ls_objName,OBJPROP_SELECTABLE,false);
   ObjectSetInteger(0,ls_objName,OBJPROP_SELECTED,false);
   ObjectSetInteger(0,ls_objName,OBJPROP_HIDDEN,false);
//--- Kajos2250
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {

  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick()
  {
   string obj_name,obj_descr;
   color  obj_color;
   int obj_type;

   int total= ObjectsTotal();
   for(int i=total-1; i>= 0; i--)
     {
      obj_name = ObjectName(i);
      obj_type = ObjectType(obj_name);
      if(obj_type!=OBJ_TREND) continue;

      obj_descr = ObjectDescription(obj_name);
      obj_color = (color)ObjectGet(obj_name,OBJPROP_COLOR);

      if( (obj_descr == LongTrendLineDescr)  && (obj_color == clBuy)  ) LTR(obj_name);
      if( (obj_descr == ShortTrendLineDescr) && (obj_color == clSell) ) STR(obj_name);
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+



void OnChartEvent(const int id,const long &lparam,const double &dparam,const string &sparam)
  {
   string ls_objName="";

   if(id==CHARTEVENT_OBJECT_CLICK)
     {
      ls_objName="LONGbtn";
      if(sparam==ls_objName)
        {
         ObjectSetInteger(0,ls_objName,OBJPROP_STATE,false);
         
         ls_objName="LONGline";
         ObjectCreate(0,ls_objName,OBJ_TREND,0,0,0);
         ObjectSetInteger(0,ls_objName,OBJPROP_SELECTED,true);
         ObjectSetInteger(0,ls_objName,OBJPROP_RAY,false);
         ObjectSetInteger(0,ls_objName,OBJPROP_COLOR,clBuy);
         ObjectSetInteger(0,ls_objName,OBJPROP_TIME,Time[13]);
         ObjectSetDouble(0,ls_objName,OBJPROP_PRICE,Low[0]+MathAbs(Low[13]-High[0]));
         ObjectSetInteger(0,ls_objName,OBJPROP_TIME2,Time[0]+Period()*60*10);
         ObjectSetDouble(0,ls_objName,OBJPROP_PRICE2,Low[0]);

         ObjectSetString(0,ls_objName,OBJPROP_TEXT,LongTrendLineDescr);
         
        }

      ls_objName="SHORTbtn";
      if(sparam==ls_objName)
        {
         ObjectSetInteger(0,ls_objName,OBJPROP_STATE,false);
         
         ls_objName="SHORTline";
         ObjectCreate(0,ls_objName,OBJ_TREND,0,0,0);
         ObjectSetInteger(0,ls_objName,OBJPROP_SELECTED,true);
         ObjectSetInteger(0,ls_objName,OBJPROP_RAY,false);
         ObjectSetInteger(0,ls_objName,OBJPROP_COLOR,clSell);
         ObjectSetInteger(0,ls_objName,OBJPROP_TIME,Time[13]);
         ObjectSetDouble(0,ls_objName,OBJPROP_PRICE,High[0]-MathAbs(Low[13]-High[0]));
         ObjectSetInteger(0,ls_objName,OBJPROP_TIME2,Time[0]+Period()*60*10);
         ObjectSetDouble(0,ls_objName,OBJPROP_PRICE2,High[0]);
         ObjectSetString(0,ls_objName,OBJPROP_TEXT,ShortTrendLineDescr);
        }

     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void LTR(string obj_name)
  {
   double TL1 = ObjectGetValueByShift(obj_name, 1);
   double TL2 = ObjectGetValueByShift(obj_name, 2);

   bool BuySig=((Close[1]>TL1 && Close[2]<=TL2)
                && (Close[1]-PipsRangeFromLine*Point*fpc()>TL1));

//-----

   RecountOrders();

   double price,sl,tp;
   int ticket=0;
   string comment;

   if(BuySig)
     {
      ObjectSet(obj_name,OBJPROP_COLOR,White);
      ObjectSet(obj_name,OBJPROP_WIDTH,2);
      //if (BuyCnt > 0) return;
      if(OrdersCountBar0(0, OP_BUY, obj_name) > 0) return;

      //-----

      if(MarketExecution)
        {
         for(int i=0; i<RepeatN; i++)
           {
            RefreshRates();
            price=Ask;

            comment="{"+obj_name+"}";

            ticket=Buy(Symbol(),GetLots(),price,0,0,Magic,comment);
            if(ticket>0) break;
           }

         for(int i=0; i<2*RepeatN; i++)
           {
            if(ticket<=0) break;
            if(!OrderSelect(ticket,SELECT_BY_TICKET)) break;

            sl = If(StopLoss > 0, OrderOpenPrice() - StopLoss*Point*fpc(), 0);
            tp = If(TakeProfit > 0, OrderOpenPrice() + TakeProfit*Point*fpc(), 0);

            if(sl>0 || tp>0)
              {
               bool res=OrderModify(OrderTicket(),OrderOpenPrice(),sl,tp,0);
               if(res) break;
              }
           }
        }

      else
        {
         for(int i=0; i<RepeatN; i++)
           {
            RefreshRates();
            price=Ask;

            sl = If(StopLoss > 0, price - StopLoss*Point*fpc(), 0);
            tp = If(TakeProfit > 0, price + TakeProfit*Point*fpc(), 0);

            comment="{"+obj_name+"}";

            ticket=Buy(Symbol(),GetLots(),price,sl,tp,Magic,comment);
            if(ticket>0) break;
           }
        }
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void STR(string obj_name)
  {
   double TL1 = ObjectGetValueByShift(obj_name, 1);
   double TL2 = ObjectGetValueByShift(obj_name, 2);

   bool SellSig=((Close[1]<TL1 && Close[2]>=TL2)
                 && (Close[1]+PipsRangeFromLine*Point*fpc()<TL1));

//-----

   double price,sl,tp;
   int ticket=0;
   string comment;

   RecountOrders();

   if(SellSig)
     {
      ObjectSet(obj_name,OBJPROP_COLOR,White);
      ObjectSet(obj_name,OBJPROP_WIDTH,2);
      //if (SellCnt > 0) return;
      if(OrdersCountBar0(0, OP_SELL, obj_name) > 0) return;

      //-----

      if(MarketExecution)
        {
         for(int i=0; i<RepeatN; i++)
           {
            RefreshRates();
            price=Bid;

            comment="{"+obj_name+"}";

            ticket=Sell(Symbol(),GetLots(),price,0,0,Magic,comment);
            if(ticket>0) break;
           }

         for(int i=0; i<2*RepeatN; i++)
           {
            if(ticket<=0) break;
            if(!OrderSelect(ticket,SELECT_BY_TICKET)) break;

            sl = If(StopLoss > 0, OrderOpenPrice() + StopLoss*Point*fpc(), 0);
            tp = If(TakeProfit > 0, OrderOpenPrice() - TakeProfit*Point*fpc(), 0);

            if(sl>0 || tp>0)
              {
               bool res=OrderModify(OrderTicket(),OrderOpenPrice(),sl,tp,0);
               if(res) break;
              }
           }
        }

      else
        {
         for(int i=0; i<RepeatN; i++)
           {
            RefreshRates();
            price=Bid;

            sl = If(StopLoss > 0, price + StopLoss*Point*fpc(), 0);
            tp = If(TakeProfit > 0, price - TakeProfit*Point*fpc(), 0);

            comment="{"+obj_name+"}";

            ticket=Sell(Symbol(),GetLots(),price,sl,tp,Magic,comment);
            if(ticket>0) break;
           }
        }
     }
  }
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

double If(bool cond,double if_true,double if_false)
  {
   if(cond) return (if_true);
   return (if_false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int fpc()
  {
   if(AccDigits == 5) return (10);
   if(AccDigits == 6) return (100);
   return (1);
  }
//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

double GetLots()
  {
   return (Lots);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void RecountOrders()
  {
   BuyCnt=0;
   SellCnt=0;
   BuyStopCnt=0;
   SellStopCnt = 0;
   BuyLimitCnt = 0;
   SellLimitCnt= 0;

   int cnt=OrdersTotal();
   for(int i=0; i<cnt; i++)
     {
      if(!OrderSelect(i,SELECT_BY_POS,MODE_TRADES)) continue;
      if(OrderSymbol()!=Symbol()) continue;
      if(OrderMagicNumber()!=Magic) continue;

      int type= OrderType();
      if(type == OP_BUY) BuyCnt++;
      if(type == OP_SELL) SellCnt++;
      if(type == OP_BUYSTOP) BuyStopCnt++;
      if(type == OP_SELLSTOP) SellStopCnt++;
      if(type == OP_BUYLIMIT) BuyLimitCnt++;
      if(type == OP_SELLLIMIT) SellLimitCnt++;
     }
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OrdersCountBar0(int TF,int type,string comment)
  {
   int orders=0;

   int cnt=OrdersTotal();
   for(int i=0; i<cnt; i++)
     {
      if(!OrderSelect(i,SELECT_BY_POS,MODE_TRADES)) continue;
      if(OrderSymbol()!=Symbol()) continue;
      if(OrderMagicNumber()!=Magic) continue;
      if(OrderType()!=type) continue;
      if(StringFind(OrderComment(),comment)==-1) continue;

      if(OrderOpenTime()>=iTime(NULL,TF,0)) orders++;
     }

   cnt=OrdersHistoryTotal();
   for(int i=0; i<cnt; i++)
     {
      if(!OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)) continue;
      if(OrderSymbol()!=Symbol()) continue;
      if(OrderMagicNumber()!=Magic) continue;
      if(OrderType()!=type) continue;
      if(StringFind(OrderComment(),comment)==-1) continue;

      if(OrderOpenTime()>=iTime(NULL,TF,0)) orders++;
     }

   return (orders);
  }

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

int SleepOk=500;
int SleepErr=2000;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int Buy(string symbol,double lot,double price,double sl,double tp,int magic,string comment="")
  {
   int dig=(int)MarketInfo(symbol,MODE_DIGITS);

   price=NormalizeDouble(price,dig);
   sl = NormalizeDouble(sl, dig);
   tp = NormalizeDouble(tp, dig);

   string _lot=DoubleToStr(lot,2);
   string _price=DoubleToStr(price,dig);
   string _sl = DoubleToStr(sl, dig);
   string _tp = DoubleToStr(tp, dig);

   Print("Buy \"",symbol,"\", ",_lot,", ",_price,", ",Slippage,", ",_sl,", ",_tp,", ",magic,", \"",comment,"\"");

   int res= OrderSend(symbol, OP_BUY, lot, price, Slippage, sl, tp, comment, magic, 0, clBuy);
   if(res>=0)
     {
      Sleep(SleepOk);
      return (res);
     }

   int code=GetLastError();
   Print("Error opening BUY order: ",ErrorDescription(code)," (",code,")");
   Sleep(SleepErr);

   return (-1);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int Sell(string symbol,double lot,double price,double sl,double tp,int magic,string comment="")
  {
   int dig=(int)MarketInfo(symbol,MODE_DIGITS);

   price=NormalizeDouble(price,dig);
   sl = NormalizeDouble(sl, dig);
   tp = NormalizeDouble(tp, dig);

   string _lot=DoubleToStr(lot,2);
   string _price=DoubleToStr(price,dig);
   string _sl = DoubleToStr(sl, dig);
   string _tp = DoubleToStr(tp, dig);

   Print("Sell \"",symbol,"\", ",_lot,", ",_price,", ",Slippage,", ",_sl,", ",_tp,", ",magic,", \"",comment,"\"");

   int res= OrderSend(symbol, OP_SELL, lot, price, Slippage, sl, tp, comment, magic, 0, clSell);
   if(res>=0)
     {
      Sleep(SleepOk);
      return (res);
     }

   int code=GetLastError();
   Print("Error opening SELL order: ",ErrorDescription(code)," (",code,")");
   Sleep(SleepErr);

   return (-1);
  }
//+------------------------------------------------------------------+
