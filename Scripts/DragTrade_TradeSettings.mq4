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
//|                                      DragTrade_TradeSettings.mq4 |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2009, TheXpert"
#property link      "theforexpert@gmail.com"

#property show_inputs

#include <DragTrade_v_1.0/DragTrade_Property.mqh>
#include <DragTrade_v_1.0/DragTrade_Properties/TradingProperties.mqh>

extern string  _1_                  = "Lot size for opening orders. If 0 not used. Risk percentage is used instead";
extern bool    Set_1_               = false;
extern double  TradeLots            = DefaultTradeLots;
extern string  _2_                  = "Risk for opening orders. 0-100. If 0 -- minimal lot is used";
extern bool    Set_2_               = false;
extern double  RiskPercentage       = DefaultRiskPercentage;
extern string  _3_                  = "If 0 -- fixed TP = TargetPoints, if 1 -- TP depends of SL, TP = TargetKoef*SL";
extern bool    Set_3_               = false;
extern int     TargetMethod         = DefaultTargetMethod;
extern string  _4_                  = "TP in points";
extern bool    Set_4_               = false;
extern int     TargetPoints         = DefaultTargetPoints;
extern string  _5_                  = "TP koef";
extern bool    Set_5_               = false;
extern double  TargetKoef           = DefaultTargetKoef;

int start()
{
   DoIt();

   return(0);
}

void DoIt()
{
   if (Set_1_) SetProperty(TradeLotsName,       TradeLots);
   if (Set_2_) SetProperty(RiskPercentageName,  RiskPercentage);
   if (Set_3_) SetProperty(TargetMethodName,    TargetMethod);
   if (Set_4_) SetProperty(TargetPointsName,    TargetPoints);
   if (Set_5_) SetProperty(TargetKoefName,      TargetKoef);
}