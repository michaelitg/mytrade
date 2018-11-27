/* =============================================================================================== */
/* Copyright (c) 2010 Andrey Nikolaevich Trukhanovich (aka TheXpert)                                  */
/*                                                                                                 */
/* Permission is hereby granted, free of charge, to any person obtaining a copy of this software           */
/* and associated documentation files (the "Software"),   */
/* to deal in the Software without restriction, including without limitation the rights           */
/* to use, copy, modify, merge, publish, distribute,                 */
/* sublicense, and/or sell copies of the Software, and to permit persons              */
/* to whom the Software is furnished to do so, subject to the following conditions:       */
/*                                                                                                 */
/*                                                                                                 */
/* The above copyright notice and this permission notice shall be included in all copies or substantial         */
/* portions of the Software.                                                         */
/*                                                                                                 */
/* THIS SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS       */
/* OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,   */
/* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR     */
/* COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER       */
/* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR    */
/* IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER      */
/* DEALINGS IN THE SOFTWARE.                                                          */
/* =============================================================================================== */

//+------------------------------------------------------------------+
//|                                    DragTrade_ObjectsSettings.mq4 |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2009, TheXpert"
#property link      "theforexpert@gmail.com"

#property show_inputs

#include <DragTrade_v_1.0/DragTrade_Property.mqh>
#include <DragTrade_v_1.0/DragTrade_Properties/ObjectsProperties.mqh>

extern string  _00_                 = "Draw trade objects in main chart window";
extern bool    Set_00_              = false;
extern bool    ObjectsInChartWindow = DefaultObjectsInChartWindow;

extern string  _01_                 = "Checker symbol code of accepting pair";
extern bool    Set_01_              = false;
extern int     CheckerSymbolCode    = DefaultCheckerSymbolCode;
extern string  _02_                 = "Checker color of accepting pair";
extern bool    Set_02_              = false;
extern color   CheckerColor         = DefaultCheckerColor;
extern string  _03_                 = "Acceptor symbol code of accepting pair";
extern bool    Set_03_              = false;
extern int     AcceptorSymbolCode   = DefaultAcceptorSymbolCode;
extern string  _04_                 = "Acceptor color of accepting pair";
extern bool    Set_04_              = false;
extern color   AcceptorColor        = DefaultAcceptorColor;
extern string  _05_                 = "if current distance is less than ApplyDistance, the command is applied";
extern bool    Set_05_              = false;
extern int     ApplyDistance        = DefaultApplyDistance;
extern string  _06_                 = "Color of the captions";
extern bool    Set_06_              = false;
extern color   CaptionColor         = DefaultCaptionColor;
extern string  _07_                 = "Color of the values";
extern bool    Set_07_              = false;
extern color   ValueColor           = DefaultValueColor;

extern string  _08_                 = "Arrow code for Price managing object";
extern bool    Set_08_              = false;
extern int     PriceArrowCode       = DefaultPriceArrowCode;
extern string  _09_                 = "Size for Price managing object";
extern bool    Set_09_              = false;
extern int     PriceArrowSize       = DefaultPriceArrowSize;
extern string  _10_                 = "Color for Price managing object";
extern bool    Set_10_              = false;
extern color   PriceArrowColor      = DefaultPriceArrowColor;

extern string  _11_                 = "Color of Buy Stop line";
extern bool    Set_11_              = false;
extern color   BuyStopColor         = DefaultBuyStopColor;
extern string  _12_                 = "Style of Buy Stop line";
extern bool    Set_12_              = false;
extern int     BuyStopStyle         = DefaultBuyStopStyle;
extern string  _13_                 = "Color of Buy Limit line";
extern bool    Set_13_              = false;
extern color   BuyLimitColor        = DefaultBuyLimitColor;
extern string  _14_                 = "Style of Buy Limit line";
extern bool    Set_14_              = false;
extern int     BuyLimitStyle        = DefaultBuyLimitStyle;
extern string  _15_                 = "Color of Sell Stop line";
extern bool    Set_15_              = false;
extern color   SellStopColor        = DefaultSellStopColor;
extern string  _16_                 = "Style of Sell Stop line";
extern bool    Set_16_              = false;
extern int     SellStopStyle        = DefaultSellStopStyle;
extern string  _17_                 = "Color of Sell Limit line";
extern bool    Set_17_              = false;
extern color   SellLimitColor       = DefaultSellLimitColor;
extern string  _18_                 = "Style of Sell Limit line";
extern bool    Set_18_              = false;
extern int     SellLimitStyle       = DefaultSellLimitStyle;

extern string  _19_                 = "Color of Stop Loss line";
extern bool    Set_19_              = false;
extern color   StopLossColor        = DefaultStopLossColor;
extern string  _20_                 = "Style of Stop Loss line";
extern bool    Set_20_              = false;
extern int     StopLossStyle        = DefaultStopLossStyle;
extern string  _21_                 = "Color of Take Profit line";
extern bool    Set_21_              = false;
extern color   TakeProfitColor      = DefaultTakeProfitColor;
extern string  _22_                 = "Style of Take Profit line";
extern bool    Set_22_              = false;
extern int     TakeProfitStyle      = DefaultTakeProfitStyle;

int start()
{
   SetTesting();
   DoIt();
   
   return(0);
}

void DoIt()
{
   if (Set_00_) SetProperty(ObjectsInChartWindowName,ObjectsInChartWindow);
   if (Set_01_) SetProperty(CheckerSymbolCodeName,  CheckerSymbolCode);
   if (Set_02_) SetProperty(CheckerColorName,       CheckerColor);
   if (Set_03_) SetProperty(AcceptorSymbolCodeName, AcceptorSymbolCode);
   if (Set_04_) SetProperty(AcceptorColorName,      AcceptorColor);
   if (Set_05_) SetProperty(ApplyDistanceName,      ApplyDistance);
   if (Set_06_) SetProperty(CaptionColorName,       CaptionColor);
   if (Set_07_) SetProperty(ValueColorName,         ValueColor);
   if (Set_08_) SetProperty(PriceArrowCodeName,     PriceArrowCode);
   if (Set_09_) SetProperty(PriceArrowSizeName,     PriceArrowSize);
   if (Set_10_) SetProperty(PriceArrowColorName,    PriceArrowColor);
   
   if (Set_11_) SetProperty(BuyStopColorName,       BuyStopColor);
   if (Set_12_) SetProperty(BuyLimitColorName,      BuyLimitColor);
   if (Set_13_) SetProperty(SellStopColorName,      SellStopColor);
   if (Set_14_) SetProperty(SellLimitColorName,     SellLimitColor);
   if (Set_15_) SetProperty(BuyStopStyleName,       BuyStopStyle);
   if (Set_16_) SetProperty(BuyLimitStyleName,      BuyLimitStyle);
   if (Set_17_) SetProperty(SellStopStyleName,      SellStopStyle);
   if (Set_18_) SetProperty(SellLimitStyleName,     SellLimitStyle);
   
   if (Set_19_) SetProperty(StopLossColorName,      StopLossColor);
   if (Set_20_) SetProperty(StopLossStyleName,      StopLossStyle);
   if (Set_21_) SetProperty(TakeProfitColorName,    TakeProfitColor);
   if (Set_22_) SetProperty(TakeProfitStyleName,    TakeProfitStyle);
}