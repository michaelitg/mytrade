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
//|                                                DragTrade Library |
//+------------------------------------------------------------------+
#property copyright "Copyright ?2009, TheXpert"
#property link      "theforexpert@gmail.com"

#property library

#include <DragTrade_v_1.0/DragTrade_SmartGlobals.mqh>
#include <DragTrade_v_1.0/DragTrade_Logical.mqh>
#include <DragTrade_v_1.0/DragTrade_Comments.mqh>
#include <DragTrade_v_1.0/DragTrade_ObjectsSettings.mqh>
#include <DragTrade_v_1.0/DragTrade_Property.mqh>
#include <DragTrade_v_1.0/DragTrade_Identification.mqh>

///=========================================================================
/// Comments
///=========================================================================

#include <DragTrade_v_1.0/DragTrade_Properties/CommentsProperties.mqh>

// current properties values for Comments
int            CommentsX;
int            CommentsY;
int            CommentsLinesDistance;
color          CommentsTextColor;
int            CommentsTextSize;
int            CommentsLineSymbols;
int            CommentsLinesCount;
int            CommentsLinesTabSize;

#define COMMENT_ID "_comment_"

string CommentId()
{
   static string id;
   if (StringLen(id) == 0)
   {
      id = ID() + COMMENT_ID;
   }
   return (id);
}

void UpdateCommentsProperties()
{
   CommentsLinesDistance= UpdateProperty(CommentsLinesDistanceName);
   CommentsTextColor    = UpdateProperty(CommentsTextColorName);
   CommentsTextSize     = UpdateProperty(CommentsTextSizeName);
   CommentsLineSymbols  = UpdateProperty(CommentsLineSymbolsName);
   CommentsLinesCount   = UpdateProperty(CommentsLinesCountName);
   CommentsLinesTabSize = UpdateProperty(CommentsLinesTabSizeName);
}

void CheckComments()
{
   CommentsX = DefaultCommentsX;
   CommentsY = DefaultCommentsY;

   bool actual;
   bool countsActual;

   actual =           IsPropertyActual(CommentsLinesDistanceName);
   actual = actual && IsPropertyActual(CommentsTextColorName);
   actual = actual && IsPropertyActual(CommentsTextSizeName);
   actual = actual && IsPropertyActual(CommentsLinesTabSizeName);

   countsActual = IsPropertyActual(CommentsLineSymbolsName);
   countsActual = countsActual && IsPropertyActual(CommentsLinesCountName);
   
   actual = actual && countsActual;
   
   if (!actual)
   {
      ClearComments();
      UpdateCommentsProperties();

      if (!countsActual)
      {
         CommentsInit(CommentsLineSymbols, CommentsLinesCount, CommentsLinesTabSize);
      }
   }
   
   string commentLabel = CommentId();
   string commentPos = commentLabel + "pos";
   
   int window = GetToolDrawWindow();
   
   if (!GetLabel(commentPos, CommentsX, CommentsY))
   {
      SetLeftLabel(commentPos, window, CommentsX, CommentsY, CharToStr(118), "Wingdings", CommentsTextColor, CommentsTextSize);
   }
   
   for (int i = 0; i < CommentsLines; i++)
   {
      SetLeftLabel(commentLabel + i + "p", window, CommentsX + 15,   CommentsY + 15 + CommentsLinesDistance*i, CommentsPrefixes[i],"Lucida console", CommentsTextColor, CommentsTextSize);
      SetLeftLabel(commentLabel + i,       window, CommentsX + 115,  CommentsY + 15 + CommentsLinesDistance*i, Comments[i],        "Lucida console", CommentsTextColor, CommentsTextSize);
   }
}

void ClearComments()
{
   string commentLabel = CommentId();
   
   for (int i = 0; i < CommentsLines; i++)
   {
      ObjectDelete(commentLabel + i);
      ObjectDelete(commentLabel + i + "p");
   }
   
   ObjectDelete(commentLabel + "pos");
}

void InitComments()
{
   InitProperty(CommentsLinesDistanceName,  DefaultCommentsLinesDistance);
   InitProperty(CommentsTextColorName,      DefaultCommentsTextColor);
   InitProperty(CommentsTextSizeName,       DefaultCommentsTextSize);
   InitProperty(CommentsLineSymbolsName,    DefaultCommentsLineSymbols);
   InitProperty(CommentsLinesCountName,     DefaultCommentsLinesCount);
   InitProperty(CommentsLinesTabSizeName,   DefaultCommentsLinesTabSize);

   UpdateCommentsProperties();

   CommentsInit(CommentsLineSymbols, CommentsLinesCount, CommentsLinesTabSize);
}

///=========================================================================
/// Manipulation objects
///=========================================================================

#include <DragTrade_v_1.0/DragTrade_Properties/ObjectsProperties.mqh>

int      CheckerSymbolCode;
color    CheckerColor;
int      AcceptorSymbolCode;
color    AcceptorColor;
int      ApplyDistance;
color    CaptionColor;
color    ValueColor;
int      PriceArrowCode;
int      PriceArrowSize;
int      PriceArrowColor;
color    StopLossColor;
color    TakeProfitColor;
int      StopLossStyle;
int      TakeProfitStyle;

color    BuyStopColor;
color    BuyLimitColor;
color    SellStopColor;
color    SellLimitColor;
int      BuyStopStyle;
int      BuyLimitStyle;
int      SellStopStyle;
int      SellLimitStyle;

bool     ObjectsInChartWindow;

int GetToolDrawWindow()
{
   if (ObjectsInChartWindow)  return (0);
   else                       return (GetToolWindow());
}

void InitObjectsProperties()
{
   InitProperty(CheckerSymbolCodeName, DefaultCheckerSymbolCode);
   InitProperty(CheckerColorName,      DefaultCheckerColor);
   InitProperty(AcceptorSymbolCodeName,DefaultAcceptorSymbolCode);
   InitProperty(AcceptorColorName,     DefaultAcceptorColor);
   InitProperty(ApplyDistanceName,     DefaultApplyDistance);
   InitProperty(CaptionColorName,      DefaultCaptionColor);
   InitProperty(ValueColorName,        DefaultValueColor);
   InitProperty(PriceArrowCodeName,    DefaultPriceArrowCode);
   InitProperty(PriceArrowSizeName,    DefaultPriceArrowSize);
   InitProperty(PriceArrowColorName,   DefaultPriceArrowColor);
   InitProperty(StopLossColorName,     DefaultStopLossColor);
   InitProperty(TakeProfitColorName,   DefaultTakeProfitColor);
   InitProperty(StopLossStyleName,     DefaultStopLossStyle);
   InitProperty(TakeProfitStyleName,   DefaultTakeProfitStyle);
   
   InitProperty(BuyStopColorName,      DefaultBuyStopColor);
   InitProperty(BuyLimitColorName,     DefaultBuyLimitColor);
   InitProperty(SellStopColorName,     DefaultSellStopColor);
   InitProperty(SellLimitColorName,    DefaultSellLimitColor);
   InitProperty(BuyStopStyleName,      DefaultBuyStopStyle);
   InitProperty(BuyLimitStyleName,     DefaultBuyLimitStyle);
   InitProperty(SellStopStyleName,     DefaultSellStopStyle);
   InitProperty(SellLimitStyleName,    DefaultSellLimitStyle);
   
   InitProperty(ObjectsInChartWindowName,   DefaultObjectsInChartWindow);

   UpdateObjectsProperties();
}

void UpdateObjectsProperties()
{
   CheckerSymbolCode = UpdateProperty(CheckerSymbolCodeName);
   CheckerColor      = UpdateProperty(CheckerColorName);
   AcceptorSymbolCode= UpdateProperty(AcceptorSymbolCodeName);
   AcceptorColor     = UpdateProperty(AcceptorColorName);
   ApplyDistance     = UpdateProperty(ApplyDistanceName);
   CaptionColor      = UpdateProperty(CaptionColorName);
   ValueColor        = clrBlack; //UpdateProperty(ValueColorName);
   PriceArrowCode    = UpdateProperty(PriceArrowCodeName);
   PriceArrowSize    = UpdateProperty(PriceArrowSizeName);
   PriceArrowColor   = clrBlack; //UpdateProperty(PriceArrowColorName);
   StopLossColor     = UpdateProperty(StopLossColorName);
   TakeProfitColor   = UpdateProperty(TakeProfitColorName);
   StopLossStyle     = UpdateProperty(StopLossStyleName);
   TakeProfitStyle   = UpdateProperty(TakeProfitStyleName);
   
   BuyStopColor      = UpdateProperty(BuyStopColorName);
   BuyLimitColor     = UpdateProperty(BuyLimitColorName);
   SellStopColor     = UpdateProperty(SellStopColorName);
   SellLimitColor    = UpdateProperty(SellLimitColorName);
   BuyStopStyle      = UpdateProperty(BuyStopStyleName);
   BuyLimitStyle     = UpdateProperty(BuyLimitStyleName);
   SellStopStyle     = UpdateProperty(SellStopStyleName);
   SellLimitStyle    = UpdateProperty(SellLimitStyleName);
   
   ObjectsInChartWindow = UpdateProperty(ObjectsInChartWindowName);
}

void CheckObjectsProperties()
{
   if (!IsPropertyActual(ObjectsInChartWindowName))
   {
      ClearButtons();
      ClearInformation();
      ClearComments();
   }
   
   bool actual;
   
   actual =             IsPropertyActual(CheckerSymbolCodeName);
   actual = actual &&   IsPropertyActual(CheckerColorName);
   actual = actual &&   IsPropertyActual(AcceptorSymbolCodeName);
   actual = actual &&   IsPropertyActual(AcceptorColorName);
   actual = actual &&   IsPropertyActual(CaptionColorName);
   actual = actual &&   IsPropertyActual(PriceArrowCodeName);
   actual = actual &&   IsPropertyActual(PriceArrowSizeName);
   actual = actual &&   IsPropertyActual(PriceArrowColorName);
   
   if (!actual)
   {
      ClearButtons();
      ClearInformation();
   }
   
   actual =             IsPropertyActual(StopLossColorName);
   actual = actual &&   IsPropertyActual(TakeProfitColorName);
   actual = actual &&   IsPropertyActual(StopLossStyleName);
   actual = actual &&   IsPropertyActual(TakeProfitStyleName);
   
   if (!actual)
   {
      ClearLines();
   }
   
   actual =             IsPropertyActual(BuyStopColorName);
   actual = actual &&   IsPropertyActual(BuyLimitColorName);
   actual = actual &&   IsPropertyActual(SellStopColorName);
   actual = actual &&   IsPropertyActual(SellLimitColorName);
   actual = actual &&   IsPropertyActual(BuyStopStyleName);
   actual = actual &&   IsPropertyActual(BuyLimitStyleName);
   actual = actual &&   IsPropertyActual(SellStopStyleName);
   actual = actual &&   IsPropertyActual(SellLimitStyleName);

   if (!actual)
   {
      ClearPendingLines();
   }
   
   if (!IsPropertyActual(ValueColorName))
   {
      ClearInformation();
   }
   
   UpdateObjectsProperties();
}

///=========================================================================
/// Main trade settings
///=========================================================================

int      Magic;
int      EAMagic;
int      TimesToRepeat;
int      Slippage;
string   OrdersComment;

///=========================================================================
/// Trading settings
///=========================================================================


#include <DragTrade_v_1.0/DragTrade_Properties/TradingProperties.mqh>

double   TradeLots;
double   RiskPercentage;
int      TargetMethod;
int      TargetPoints;
double   TargetKoef;

#include <DragTrade_v_1.0/DragTrade_Trading.mqh>

void InitTradeProperties()
{
   InitProperty(TradeLotsName,      DefaultTradeLots);
   InitProperty(RiskPercentageName, DefaultRiskPercentage);
   InitProperty(TargetMethodName,   DefaultTargetMethod);
   InitProperty(TargetPointsName,   DefaultTargetPoints);
   InitProperty(TargetKoefName,     DefaultTargetKoef);
}

void UpdateTradeProperties()
{
   TradeLots      = UpdateProperty(TradeLotsName);
   RiskPercentage = UpdateProperty(RiskPercentageName);
   TargetMethod   = UpdateProperty(TargetMethodName);
   TargetPoints   = UpdateProperty(TargetPointsName);
   TargetKoef     = UpdateProperty(TargetKoefName);
}

void CheckTradeProperties()
{
   UpdateTradeProperties();
}

///=========================================================================
/// Opening orders button
///=========================================================================

int ButtonsPosX;
int ButtonsPosY;

#define  DEFAULT_OPEN_POS_X      10
#define  DEFAULT_OPEN_POS_Y      20

#define  OPEN_MARKET_ACCEPTOR_X  45
#define  OPEN_MARKET_ACCEPTOR_Y  10
#define  OPEN_MARKET_CHECKER_X   10
#define  OPEN_MARKET_CHECKER_Y   10
#define  OPEN_MARKET_LABEL_X     80
#define  OPEN_MARKET_LABEL_Y     15

#define  OPEN_STOP_ACCEPTOR_X    45
#define  OPEN_STOP_ACCEPTOR_Y    40
#define  OPEN_STOP_CHECKER_X     10
#define  OPEN_STOP_CHECKER_Y     40
#define  OPEN_STOP_LABEL_X       80
#define  OPEN_STOP_LABEL_Y       45

#define  OPEN_LIMIT_ACCEPTOR_X   45
#define  OPEN_LIMIT_ACCEPTOR_Y   70
#define  OPEN_LIMIT_CHECKER_X    10
#define  OPEN_LIMIT_CHECKER_Y    70
#define  OPEN_LIMIT_LABEL_X      80
#define  OPEN_LIMIT_LABEL_Y      75

#define  OPENING_ID "_open_"
#define  OPEN_TYPE_ID "_open_type_"

void CommentOpenResult(int res)
{
   if (res > 0)
   {
      Comment_("Order #" + res + " opened successfully");
   }
   else
   {
      Comment_("Open failed, last error #" + (-res));
   }
}

bool CheckMarketOpening()
{
   int window = GetToolDrawWindow();
   
   string acceptor = " " + ID() + OPENING_ID + " m acceptor";
   string checker = " " + ID() + OPENING_ID + " m checker";
   string description = " " + ID() + OPENING_ID + " m label";

   int acceptorX, acceptorY;
   acceptorX = OPEN_MARKET_ACCEPTOR_X + ButtonsPosX;
   acceptorY = OPEN_MARKET_ACCEPTOR_Y + ButtonsPosY;
   
   int checkerX, checkerY;
   checkerX = OPEN_MARKET_CHECKER_X + ButtonsPosX;
   checkerY = OPEN_MARKET_CHECKER_Y + ButtonsPosY;

   SetLabel(description, window, OPEN_MARKET_LABEL_X + ButtonsPosX, OPEN_MARKET_LABEL_Y + ButtonsPosY, "Open Market Order", "Arial", CaptionColor);
   
   double price;
   bool canProcess = CheckOpening
      (
         acceptor, acceptorX, acceptorY,
         checker, checkerX, checkerY,
         price
      );
      
   if (canProcess)
   {
      double lots = DoubleIf(TradeLots == 0, GetLotsToBid(RiskPercentage), TradeLots);
      int res;
      
      int sl = MathRound(MathAbs(price - Bid)/Point);
      if (sl == 0) sl = 1;
   
      int tp = TargetPoints;
   
      if (TargetMethod == 1)
      {
         tp = sl*TargetKoef;
      }
   
      if (price > Ask)
      {
         Comment_("Open accepted. Trying to open " + DoubleToStr(lots, 2) + " Sell at " + DoubleToStr(Bid, Digits));
         res = OpenSell(Magic, tp, sl, lots, OrdersComment);
      }
      else if (price < Bid)
      {
         Comment_("Open accepted. Trying to open " + DoubleToStr(lots, 2) + " Buy at " + DoubleToStr(Ask, Digits));
         res = OpenBuy(Magic, tp, sl, lots, OrdersComment);
      }
      CommentOpenResult(res);
   }
   
   ModifyLabelPos(acceptor, acceptorX, acceptorY);
   ModifyLabelPos(checker, checkerX, checkerY);

   return (canProcess);
}

bool CheckLimitOpening()
{
   int window = GetToolDrawWindow();
   
   string acceptor = " " + ID() + OPENING_ID + " l acceptor";
   string checker = " " + ID() + OPENING_ID + " l checker";
   string description = " " + ID() + OPENING_ID + " l label";

   int acceptorX, acceptorY;
   acceptorX = OPEN_LIMIT_ACCEPTOR_X + ButtonsPosX;
   acceptorY = OPEN_LIMIT_ACCEPTOR_Y + ButtonsPosY;
   
   int checkerX, checkerY;
   checkerX = OPEN_LIMIT_CHECKER_X + ButtonsPosX;
   checkerY = OPEN_LIMIT_CHECKER_Y + ButtonsPosY;

   SetLabel(description, window, OPEN_LIMIT_LABEL_X + ButtonsPosX, OPEN_LIMIT_LABEL_Y + ButtonsPosY, "Open Limit Order", "Arial", CaptionColor);
   
   double price;
   bool canProcess = CheckOpening
      (
         acceptor, acceptorX, acceptorY,
         checker, checkerX, checkerY,
         price
      );
      
   if (canProcess)
   {
      double lots = DoubleIf(TradeLots == 0, GetLotsToBid(RiskPercentage), TradeLots);
      int res;
      
      if (price > Ask)
      {
         Comment_("Open accepted. Trying to open " + DoubleToStr(lots, 2) + " Sell Limit at " + DoubleToStr(price, Digits));
         res = OpenSellLimit(Magic, price, 0, 0, lots, OrdersComment);
      }
      else if (price < Bid)
      {
         Comment_("Open accepted. Trying to open " + DoubleToStr(lots, 2) + " Buy Limit at " + DoubleToStr(price, Digits));
         res = OpenBuyLimit(Magic, price, 0, 0, lots, OrdersComment);
      }

      CommentOpenResult(res);
   }
   
   ModifyLabelPos(acceptor, acceptorX, acceptorY);
   ModifyLabelPos(checker, checkerX, checkerY);
   
   return (canProcess);
}

bool CheckStopOpening()
{
   int window = GetToolDrawWindow();
   
   string acceptor = " " + ID() + OPENING_ID + " s acceptor";
   string checker = " " + ID() + OPENING_ID + " s checker";
   string description = " " + ID() + OPENING_ID + " s label";

   int acceptorX, acceptorY;
   acceptorX = OPEN_STOP_ACCEPTOR_X + ButtonsPosX;
   acceptorY = OPEN_STOP_ACCEPTOR_Y + ButtonsPosY;
   
   int checkerX, checkerY;
   checkerX = OPEN_STOP_CHECKER_X + ButtonsPosX;
   checkerY = OPEN_STOP_CHECKER_Y + ButtonsPosY;

   SetLabel(description, window, OPEN_STOP_LABEL_X + ButtonsPosX, OPEN_STOP_LABEL_Y + ButtonsPosY, "Open Stop Order", "Arial", CaptionColor);
   
   double price;
   bool canProcess = CheckOpening
      (
         acceptor, acceptorX, acceptorY,
         checker, checkerX, checkerY,
         price
      );
      
   if (canProcess)
   {
      double lots = DoubleIf(TradeLots == 0, GetLotsToBid(RiskPercentage), TradeLots);
      int res;
      
      if (price > Ask)
      {
         Comment_("Open accepted. Trying to open " + DoubleToStr(lots, 2) + " Buy Stop at " + DoubleToStr(price, Digits));
         res = OpenBuyStop(Magic, price, 0, 0, lots, OrdersComment);
      }
      else if (price < Bid)
      {
         Comment_("Open accepted. Trying to open " + DoubleToStr(lots, 2) + " Sell Stop at " + DoubleToStr(price, Digits));
         res = OpenSellStop(Magic, price, 0, 0, lots, OrdersComment);
      }

      CommentOpenResult(res);
   }
   
   ModifyLabelPos(acceptor, acceptorX, acceptorY);
   ModifyLabelPos(checker, checkerX, checkerY);

   return (canProcess);
}

bool CheckOpening
   (
      string acceptor, 
      int acceptorX,
      int acceptorY,
      string checker, 
      int checkerX,
      int checkerY,
      double& price
   )
{
   string mover = " " + ID() + OPENING_ID + " mover";

   datetime time;
   
   bool canProcess;
   
   canProcess = 
      CheckPressed(
            checker, checkerX, checkerY, CheckerSymbolCode, CheckerColor,
            acceptor, acceptorX, acceptorY, AcceptorSymbolCode, AcceptorColor);
            
   if (!GetArrow(mover, time, price))
   {
      SetArrow
         (
            mover, 
            Time[0] + 4*Period()*60, 
            Bid, 
            PriceArrowCode, 
            PriceArrowSize, 
            PriceArrowColor
         );
         
      canProcess = false;
   }

   if (price > WindowPriceMax() || price < WindowPriceMin())
   {
      int firstVisible = WindowFirstVisibleBar();
      int allVisible = WindowBarsPerChart();
      
      if (allVisible > firstVisible)
      {
         price = Bid;
      }
   }
   ModifyArrow(mover, Time[0] + 4*Period()*60, price);
   
   if (canProcess)
   {
      price = NormalizeDouble(price, Digits);
   }
   
   return (canProcess);
}

///=========================================================================
/// Manipulation
///=========================================================================

void ClearButtons()
{
   ObjectDelete(" " + ID() + OPENING_ID + " mover");

   ObjectDelete(" " + ID() + OPENING_ID + " m acceptor");
   ObjectDelete(" " + ID() + OPENING_ID + " m checker");
   ObjectDelete(" " + ID() + OPENING_ID + " m label");

   ObjectDelete(" " + ID() + OPENING_ID + " l acceptor");
   ObjectDelete(" " + ID() + OPENING_ID + " l checker");
   ObjectDelete(" " + ID() + OPENING_ID + " l label");

   ObjectDelete(" " + ID() + OPENING_ID + " s acceptor");
   ObjectDelete(" " + ID() + OPENING_ID + " s checker");
   ObjectDelete(" " + ID() + OPENING_ID + " s label");

   ObjectDelete(" " + ID() + OPENING_ID + "subpos");
   ObjectDelete(" " + ID() + OPENING_ID + "pos");
}

void CheckButtons()
{
   string subButtonPos = " " + ID() + OPENING_ID + "subpos";
   string buttonPos = " " + ID() + OPENING_ID + "pos";
   
   int window = GetToolDrawWindow();
   
   int   posx = DEFAULT_OPEN_POS_X, 
         posy = DEFAULT_OPEN_POS_Y,
         subposx = DEFAULT_OPEN_POS_X, 
         subposy = DEFAULT_OPEN_POS_Y;
   
   if (!GetLabel(subButtonPos, subposx, subposy))
   {
      SetLabel(subButtonPos, window, subposx, subposy, CharToStr(118), "Wingdings", CommentsTextColor, CommentsTextSize);
   }
   
   if (!GetLabel(buttonPos, posx, posy))
   {
      SetLabel(buttonPos, window, posx, posy, CharToStr(118), "Wingdings", CommentsTextColor, CommentsTextSize);
   }
   
   if (posx != subposx || posy != subposy)
   {
      ClearButtons();
      SetLabel(subButtonPos, window, posx, posy, CharToStr(118), "Wingdings", CommentsTextColor, CommentsTextSize);
      SetLabel(buttonPos, window, posx, posy, CharToStr(118), "Wingdings", CommentsTextColor, CommentsTextSize);
   }

   ButtonsPosX = posx;
   ButtonsPosY = posy;
   
   if (
         CheckMarketOpening() ||
         CheckLimitOpening()  ||
         CheckStopOpening()
      )
   {
      SetArrow
      (
         " " + ID() + OPENING_ID + " mover", 
         Time[0] + 4*Period()*60, 
         Bid, 
         PriceArrowCode, 
         PriceArrowSize, 
         PriceArrowColor
      );
   }
}

///=========================================================================
/// Modifying orders
///=========================================================================

int GetTicketFromName(string name)
{
   string ticket = StringSubstr(name, IDLen() + 3);
   
   int space = StringFind(ticket, " ");
   if (space == -1) return (-1);
   
   return (StrToInteger(StringSubstr(ticket, 0, space)));
}

void ClearLines()
{
   for (int i = ObjectsTotal() - 1; i >= 0; i--)
   {
      string name = ObjectName(i);
      int type = ObjectType(name);
      
      if (
            (type == OBJ_HLINE || type == OBJ_ARROW) &&
            (
               StringFind(name, ID() + "SL") == 0 ||
               StringFind(name, ID() + "TP") == 0
            )
         )
      {
         ObjectDelete(name);
      }
   }
}

void CheckLines() 
{
   int count;
   string arrowPostfix = " arrow";
   
   int tickets[];

   ArrayResize(tickets, 0);

   count = OrdersTotal();
   for (int i = count - 1; i >= 0; i--) 
   {
      if (!OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) continue;
      if (OrderSymbol() != Symbol()) continue;
      if (OrderType() != OP_BUY && OrderType() != OP_SELL) continue;
      
      if (OrderStopLoss() > 0 || OrderTakeProfit() > 0)
      {
         PushBackInt(tickets, OrderTicket());
      }
   }

   count = ObjectsTotal();
   for (i = count - 1; i >= 0; i--)
   {
      string name = ObjectName(i);
      string arrowName = name + arrowPostfix;
      
      if (ObjectType(name) != OBJ_HLINE) continue;
      if (StringFind(name, ID() + "SL") != 0 && StringFind(name, ID() + "TP") != 0) continue;

      int current = GetTicketFromName(name);
      if (ArraySearchInt(tickets, current) < 0 || !OrderSelect(current, SELECT_BY_TICKET))
      {
         ObjectDelete(name);
         ObjectDelete(name + arrowPostfix);
         continue;
      }
      
      if (StringSubstr(name, IDLen(), 2) == "SL")
      {
         if (OrderStopLoss() > 0) 
         {
            double price = ObjectGet(name, OBJPROP_PRICE1);

            double currentSL = NormalizeDouble(OrderStopLoss(), Digits);
            double arrowSL;
            datetime arrowTime;
            
            if (!GetArrow(arrowName, arrowTime, arrowSL)) continue;
            arrowSL = NormalizeDouble(arrowSL, Digits);
            
            if (arrowSL != currentSL)
            {
               ModifyHLine(name, currentSL);
               ModifyArrow(arrowName, Time[0] - 4*Period()*60, currentSL);
               continue;
            }
            
            int type = OrderType();
            
            if ((type == OP_BUY && price > Ask) || (type == OP_SELL && price < Bid)) 
            {
               Comment_("Close command accepted for order #" + current);
               if (!OrderClose(current, OrderLots(), DoubleIf(type == OP_BUY, Bid, Ask), Slippage, IntIf(type == OP_BUY, Blue, Red)))
               {
                  Comment_("Close failed for order#" + current + ", last error #" + GetLastError());
               }
            }
            else
            {
               int err = ModifyOrder(NormalizeDouble(price, Digits), -1);
               if (err > 0)
               {
                  Comment_("Modify failed for order#" + current + ", last error #" + err);
               }
            }
         } 
         else 
         {
            ObjectDelete(name);
            ObjectDelete(arrowPostfix);
         }
      }
      else if (StringSubstr(name, IDLen(), 2) == "TP")
      {
         if (OrderTakeProfit() > 0) 
         {
            price = ObjectGet(name, OBJPROP_PRICE1);
            
            double currentTP = NormalizeDouble(OrderTakeProfit(), Digits);
            double arrowTP;
            
            if (!GetArrow(arrowName, arrowTime, arrowTP)) continue;
            arrowTP = NormalizeDouble(arrowTP, Digits);
            
            if (arrowTP != currentTP)
            {
               ModifyHLine(name, currentTP);
               ModifyArrow(arrowName, Time[0] - 4*Period()*60, currentTP);
               continue;
            }

            type = OrderType();
            
            if ((type == OP_BUY && price < Bid) || (type == OP_SELL && price > Ask)) 
            {
               Comment_("Close command accepted for order #" + current);
               if (!OrderClose(current, OrderLots(), DoubleIf(type == OP_BUY, Bid, Ask), Slippage, IntIf(type == OP_BUY, Blue, Red)))
               {
                  Comment_("Close failed for order#" + current + ", last error #" + GetLastError());
               }
            }
            else
            {
               err = ModifyOrder(-1, NormalizeDouble(price, Digits));
               if (err > 0)
               {
                  Comment_("Modify failed for order#" + current + ", last error #" + err);
               }
            }
         }
         else 
         {
            ObjectDelete(name);
            ObjectDelete(arrowPostfix);
         }
      }
   }

   string common;

   count = OrdersTotal();
   for (i = count - 1; i >= 0; i--) 
   {
      if (!OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) continue;
      if (OrderSymbol() != Symbol()) continue;

      type = OrderType();
      if (type != OP_BUY && type != OP_SELL) continue;

      common = 
         " " + 
         DoubleToStr(OrderLots(), 2) +
         " " + 
         StringIf(type == OP_BUY, "Buy", "Sell");
         
      string lineName;
         
      if (OrderStopLoss() > 0)
      {
         lineName = ID() + "SL " + OrderTicket() + common;
         arrowName = lineName + arrowPostfix;
         
         if (!GetHLine(lineName, price))
         {
            SetHLine(lineName, OrderStopLoss(), StopLossColor, StopLossStyle, 0);
         }
         SetArrow(arrowName, Time[0] - 4*Period()*60, OrderStopLoss(), SYMBOL_LEFTPRICE, 2, StopLossColor);
      }
      if (OrderTakeProfit() > 0)
      {
         lineName = ID() + "TP " + OrderTicket() + common;
         arrowName = lineName + arrowPostfix;

         if (!GetHLine(lineName, price))
         {
            SetHLine(lineName, OrderTakeProfit(), TakeProfitColor, TakeProfitStyle, 0);
         }
         SetArrow(arrowName, Time[0] - 4*Period()*60, OrderTakeProfit(), SYMBOL_LEFTPRICE, 2, TakeProfitColor);
      }
   }
}

int ModifyOrder(double StopLoss = -1, double TakeProfit = -1)
{
   double currentSL = NormalizeDouble(OrderStopLoss(), Digits);
   double currentTP = NormalizeDouble(OrderTakeProfit(), Digits);
   
   double sl = DoubleIf(StopLoss == -1, currentSL, NormalizeDouble(StopLoss, Digits));
   double tp = DoubleIf(TakeProfit == -1, currentTP, NormalizeDouble(TakeProfit, Digits));
   
   if (sl == currentSL && tp == currentTP) return (0);
   
   Comment_(
      "Trying to modify #" + 
      OrderTicket() + 
      " sl = " + 
      DoubleToStr(currentSL, Digits) + 
      ", tp = " + 
      DoubleToStr(currentTP, Digits) + 
      " to sl = " + 
      DoubleToStr(sl, Digits) + 
      ", tp = " + 
      DoubleToStr(tp, Digits));

   if (OrderModify(OrderTicket(), OrderOpenPrice(), sl, tp, 0))
   {
      Comment_("Order #" + OrderTicket() + "  modified successfully");
      return (0);
   }
   return (GetLastError());
}

///=========================================================================
/// Modifying pendings
///=========================================================================

void ClearPendingLines()
{
   for (int i = ObjectsTotal() - 1; i >= 0; i--)
   {
      string name = ObjectName(i);
      int type = ObjectType(name);
      
      if (
            (type == OBJ_HLINE || type == OBJ_ARROW) &&
            StringFind(name, ID() + "PO") == 0
         )
      {
         ObjectDelete(name);
      }
   }
}

int OrderColor(int type)
{
   switch (type)
   {
      case OP_BUY       : return (Blue);
      case OP_SELL      : return (Red);
      case OP_SELLLIMIT : return (SellLimitColor);
      case OP_SELLSTOP  : return (SellStopColor);
      case OP_BUYLIMIT  : return (BuyLimitColor);
      case OP_BUYSTOP   : return (BuyStopColor);
   }
   return (White);
}

int OrderStyle(int type)
{
   switch (type)
   {
      case OP_BUY       : return (STYLE_SOLID);
      case OP_SELL      : return (STYLE_SOLID);
      case OP_SELLLIMIT : return (SellLimitStyle);
      case OP_SELLSTOP  : return (SellStopStyle);
      case OP_BUYLIMIT  : return (BuyLimitStyle);
      case OP_BUYSTOP   : return (BuyStopStyle);
   }
   return (STYLE_SOLID);
}

void CheckPendingLines() 
{
   int count;
   string arrowPostfix = " arrow";
   
   int tickets[];

   ArrayResize(tickets, 0);

   count = OrdersTotal();
   for (int i = count - 1; i >= 0; i--) 
   {
      if (!OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) continue;
      if (OrderSymbol() != Symbol()) continue;
      if (OrderType() == OP_BUY || OrderType() == OP_SELL) continue;
      
      PushBackInt(tickets, OrderTicket());
   }

   for (i = ObjectsTotal() - 1; i >= 0; i--)
   {
      string name = ObjectName(i);
      string arrowName = name + arrowPostfix;
      
      if (StringFind(name, ID() + "PO") != 0 || ObjectType(name) != OBJ_HLINE) continue;

      int current = GetTicketFromName(name);
      if (ArraySearchInt(tickets, current) < 0 || !OrderSelect(current, SELECT_BY_TICKET))
      {
         ObjectDelete(name);
         ObjectDelete(name + arrowPostfix);
         continue;
      }
      
      double price = NormalizeDouble(ObjectGet(name, OBJPROP_PRICE1), Digits);
      double currentPrice = NormalizeDouble(OrderOpenPrice(), Digits);

      double arrowPrice;
      datetime arrowTime;
      
      if (!GetArrow(arrowName, arrowTime, arrowPrice)) continue;
      arrowPrice = NormalizeDouble(arrowPrice, Digits);
      
      if (arrowPrice != currentPrice)
      {
         ModifyHLine(name, currentPrice);
         ModifyArrow(arrowName, Time[0] - 4*Period()*60, currentPrice);
         continue;
      }
      
      int type = OrderType();
      
      if (
            (type == OP_BUYSTOP && price < Bid) || 
            (type == OP_SELLLIMIT && price < Bid) ||
            (type == OP_BUYLIMIT && price > Ask) ||
            (type == OP_SELLSTOP && price > Ask)
         )
      {
         Comment_("Delete command accepted for order #" + current);
         if (!OrderDelete(current))
         {
            Comment_("Delete failed for order#" + current + ", last error #" + GetLastError());
         }
      }
      else
      {
         int err = ModifyPending(price);
         if (err > 0)
         {
            Comment_("Modify failed for order#" + current + ", last error #" + err);
         }
      }
   }

   string common;

   for (i = OrdersTotal() - 1; i >= 0; i--) 
   {
      if (!OrderSelect(i, SELECT_BY_POS)) continue;
      if (OrderSymbol() != Symbol()) continue;

      type = OrderType();
      if (type == OP_BUY || type == OP_SELL) continue;

      common = 
         " " + 
         DoubleToStr(OrderLots(), 2) +
         " " + 
         OrderTypeAsString(type);
         
      string lineName;
         
      lineName = ID() + "PO " + OrderTicket() + common;
      arrowName = lineName + arrowPostfix;
      
      if (!GetHLine(lineName, price))
      {
         SetHLine(lineName, OrderOpenPrice(), OrderColor(type), OrderStyle(type), 0);
      }
      SetArrow(arrowName, Time[0] - 4*Period()*60, OrderOpenPrice(), SYMBOL_LEFTPRICE, 2, OrderColor(type));
   }
}

int ModifyPending(double price)
{
   double currentPrice = NormalizeDouble(OrderOpenPrice(), Digits);
   if (price == currentPrice) return (0);
   
   Comment_(
      "Trying to modify #" + 
      OrderTicket() + 
      " at price " + 
      DoubleToStr(currentPrice, Digits) + 
      " to price " + 
      DoubleToStr(price, Digits)
   );

   if (OrderModify(OrderTicket(), price, OrderStopLoss(), OrderTakeProfit(), 0))
   {
      Comment_("Order #" + OrderTicket() + "  modified successfully");
      return (0);
   }
   return (GetLastError());
}

///=========================================================================
/// Implementation
///=========================================================================

bool CheckPressed(
      string name1, int& x1, int& y1, int id1, color clr1,
      string name2, int& x2, int& y2, int id2, color clr2,
      int window = -1, int corner = -1)
{
   bool canProcess;
   
   canProcess =   CheckAcceptor(name1, x1, y1, id1, clr1, name2, window, corner);
   canProcess =   canProcess && 
                  CheckAcceptor(name2, x2, y2, id2, clr2, name1, window, corner);
   
   if (  canProcess &&
         MathAbs(x1 - x2) <= ApplyDistance &&
         MathAbs(y1 - y2) <= ApplyDistance
      )
   {
      ObjectDelete(name1);
      ObjectDelete(name2);

      return (true);
   }
   return (false);
}

bool CheckAcceptor(string name1, int& x, int& y, int id, color clr, string name2, int wnd, int corner)
{
   int initialX = x;
   int initialY = y;
   
   int window = wnd;
   if (window == -1) window = GetToolDrawWindow();
   
   if (!GetLabel(name1, x, y))
   {
      int acceptorX, acceptorY;
      if (GetLabel(name2, acceptorX, acceptorY))
      {
         if (  MathAbs(acceptorX - x) >= ApplyDistance ||
               MathAbs(acceptorY - y) >= ApplyDistance)
         {
            if (corner == 1)
            {
               SetLeftLabel(name1, window, x, y, CharToStr(id), "Wingdings", clr, 20);
            }
            else
            {
               SetLabel(name1, window, x, y, CharToStr(id), "Wingdings", clr, 20);
            }
         }
         else
            ObjectDelete(name2);
      }
      else
      {
            if (corner == 1)
            {
               SetLeftLabel(name1, window, x, y, CharToStr(id), "Wingdings", clr, 20);
            }
            else
            {
               SetLabel(name1, window, x, y, CharToStr(id), "Wingdings", clr, 20);
            }
      }
         
      return (false);
   }
   return (true);
}

///=========================================================================
/// Information
///=========================================================================

#define INFO_SPREAD_CAPTION_X 10
#define INFO_SPREAD_CAPTION_Y 20
#define INFO_SPREAD_VALUE_X   90
#define INFO_SPREAD_VALUE_Y   20

#define INFO_STOPLEVEL_CAPTION_X 10
#define INFO_STOPLEVEL_CAPTION_Y 35
#define INFO_STOPLEVEL_VALUE_X   90
#define INFO_STOPLEVEL_VALUE_Y   35

#define INFO_BUYS_CAPTION_X 10
#define INFO_BUYS_CAPTION_Y 50
#define INFO_BUYS_VALUE_X   90
#define INFO_BUYS_VALUE_Y   50

#define INFO_SELLS_CAPTION_X 10
#define INFO_SELLS_CAPTION_Y 65
#define INFO_SELLS_VALUE_X   90
#define INFO_SELLS_VALUE_Y   65

#define INFO_EQUITY_CAPTION_X 310
#define INFO_EQUITY_CAPTION_Y 20
#define INFO_EQUITY_VALUE_X   390
#define INFO_EQUITY_VALUE_Y   20

#define INFO_TPTYPE_CAPTION_X 310
#define INFO_TPTYPE_CAPTION_Y 35
#define INFO_TPTYPE_VALUE_X   390
#define INFO_TPTYPE_VALUE_Y   35

#define INFO_LOTS_CAPTION_X   310
#define INFO_LOTS_CAPTION_Y   50
#define INFO_LOTS_VALUE_X     390
#define INFO_LOTS_VALUE_Y     50

#define INFO_LVRG_CAPTION_X   310
#define INFO_LVRG_CAPTION_Y   65
#define INFO_LVRG_VALUE_X     390
#define INFO_LVRG_VALUE_Y     65

#define INFO_COMPANY_CAPTION_X   610
#define INFO_COMPANY_CAPTION_Y   20
#define INFO_COMPANY_VALUE_X     720
#define INFO_COMPANY_VALUE_Y     20

#define INFO_CURR_CAPTION_X   610
#define INFO_CURR_CAPTION_Y   35
#define INFO_CURR_VALUE_X     720
#define INFO_CURR_VALUE_Y     35

#define INFO_SERVER_CAPTION_X   610
#define INFO_SERVER_CAPTION_Y   50
#define INFO_SERVER_VALUE_X     720
#define INFO_SERVER_VALUE_Y     50

#define INFO_MAGIC_CAPTION_X   610
#define INFO_MAGIC_CAPTION_Y   65
#define INFO_MAGIC_VALUE_X     720
#define INFO_MAGIC_VALUE_Y     65

#define INFO_TIME_VALUE_X   2
#define INFO_TIME_VALUE_Y   2

#define INFO_ID "_info_"

void ClearInformation()
{
   ObjectDelete(ID() + INFO_ID + "spread C");
   ObjectDelete(ID() + INFO_ID + "spread V");
   ObjectDelete(ID() + INFO_ID + "slevel C");
   ObjectDelete(ID() + INFO_ID + "slevel V");
   ObjectDelete(ID() + INFO_ID + "buys C");
   ObjectDelete(ID() + INFO_ID + "buys V");
   ObjectDelete(ID() + INFO_ID + "sells C");
   ObjectDelete(ID() + INFO_ID + "sells V");
   ObjectDelete(ID() + INFO_ID + "equity C");
   ObjectDelete(ID() + INFO_ID + "equity V");
   ObjectDelete(ID() + INFO_ID + "time V");
   ObjectDelete(ID() + INFO_ID + "tp type C");
   ObjectDelete(ID() + INFO_ID + "tp type V");
   ObjectDelete(ID() + INFO_ID + "lots C");
   ObjectDelete(ID() + INFO_ID + "lots V");
   ObjectDelete(ID() + INFO_ID + "lvrg C");
   ObjectDelete(ID() + INFO_ID + "lvrg V");
   ObjectDelete(ID() + INFO_ID + "cmp C");
   ObjectDelete(ID() + INFO_ID + "cmp V");
   ObjectDelete(ID() + INFO_ID + "curr C");
   ObjectDelete(ID() + INFO_ID + "curr V");
   ObjectDelete(ID() + INFO_ID + "srvr C");
   ObjectDelete(ID() + INFO_ID + "srvr V");
   ObjectDelete(ID() + INFO_ID + "magic C");
   ObjectDelete(ID() + INFO_ID + "magic V");
}

void DrawInformation()
{
   int window = GetInfoWindow();
   double value;
   string str;
   
   //spread
   str = DoubleToStr(MathRound((Ask - Bid)/Point), 0);
   
   SetLeftLabel(ID() + INFO_ID + "spread C", window, INFO_SPREAD_CAPTION_X, INFO_SPREAD_CAPTION_Y, "Spread:", "Arial", CaptionColor);
   SetLeftLabel(ID() + INFO_ID + "spread V", window, INFO_SPREAD_VALUE_X, INFO_SPREAD_VALUE_Y, str, "Arial", ValueColor);

   //stop level
   str = DoubleToStr(MarketInfo(Symbol(), MODE_STOPLEVEL), 0);

   SetLeftLabel(ID() + INFO_ID + "slevel C", window, INFO_STOPLEVEL_CAPTION_X, INFO_STOPLEVEL_CAPTION_Y, "Stop Level:", "Arial", CaptionColor);
   SetLeftLabel(ID() + INFO_ID + "slevel V", window, INFO_STOPLEVEL_VALUE_X, INFO_STOPLEVEL_VALUE_Y, str, "Arial", ValueColor);

   //opened buys
   double lots = 0;
   int count = 0;
   
   if (Magic == -1)
   {
      lots = GetLotsCount(-1, OP_BUY);
      count = GetOrdersCount(-1, OP_BUY);
   }
   else
   {
      lots = GetLotsCount(Magic, OP_BUY);
      count = GetOrdersCount(Magic, OP_BUY);
      
      if (EAMagic != -1 && EAMagic != Magic)
      {
         lots += GetLotsCount(EAMagic, OP_BUY);
         count += GetOrdersCount(EAMagic, OP_BUY);
      }
   }
   
   str = DoubleToStr(lots, 2) + " Lots in " + count + " Orders";

   SetLeftLabel(ID() + INFO_ID + "buys C", window, INFO_BUYS_CAPTION_X, INFO_BUYS_CAPTION_Y, "Buys:", "Arial", CaptionColor);
   SetLeftLabel(ID() + INFO_ID + "buys V", window, INFO_BUYS_VALUE_X, INFO_BUYS_VALUE_Y, str, "Arial", ValueColor);

   if (Magic == -1)
   {
      lots = GetLotsCount(-1, OP_SELL);
      count = GetOrdersCount(-1, OP_SELL);
   }
   else
   {
      lots = GetLotsCount(Magic, OP_SELL);
      count = GetOrdersCount(Magic, OP_SELL);
      
      if (EAMagic != -1 && EAMagic != Magic)
      {
         lots += GetLotsCount(EAMagic, OP_SELL);
         count += GetOrdersCount(EAMagic, OP_SELL);
      }
   }
   //opened sells
   str = DoubleToStr(lots, 2) + " Lots in " + count + " Orders";

   SetLeftLabel(ID() + INFO_ID + "sells C", window, INFO_SELLS_CAPTION_X, INFO_SELLS_CAPTION_Y, "Sells:", "Arial", CaptionColor);
   SetLeftLabel(ID() + INFO_ID + "sells V", window, INFO_SELLS_VALUE_X, INFO_SELLS_VALUE_Y, str, "Arial", ValueColor);

   //profit
   if (Magic == -1)
   {
      value = GetProfitCount(-1);
   }
   else
   {
      value = GetProfitCount(Magic);
      
      if (EAMagic != -1 && EAMagic != Magic)
      {
         value += GetProfitCount(EAMagic);
      }
   }

   str = StringIf(value >= 0, "+", " ") + DoubleToStr(value, 2);

   SetLeftLabel(ID() + INFO_ID + "equity C", window, INFO_EQUITY_CAPTION_X, INFO_EQUITY_CAPTION_Y, "Equity:", "Arial", CaptionColor);
   SetLeftLabel(ID() + INFO_ID + "equity V", window, INFO_EQUITY_VALUE_X, INFO_EQUITY_VALUE_Y, str, "Arial", IntIf(value >= 0, Green, Red));

   //take profit
   SetLeftLabel(ID() + INFO_ID + "tp type C", window, INFO_TPTYPE_CAPTION_X, INFO_TPTYPE_CAPTION_Y, "Take Profit:", "Arial", CaptionColor);

   if (TargetMethod == 1)
   {
      str = " = " + DoubleToStr(TargetKoef, 2) + " x Stop Loss";
   }
   else
   {
      str = "Fixed = " + DoubleToStr(TargetPoints, 0) + " Points";
   }
   SetLeftLabel(ID() + INFO_ID + "tp type V", window, INFO_TPTYPE_VALUE_X, INFO_TPTYPE_VALUE_Y, str, "Arial", ValueColor);

   //lots
   SetLeftLabel(ID() + INFO_ID + "lots C", window, INFO_LOTS_CAPTION_X, INFO_LOTS_CAPTION_Y, "Lot to open:", "Arial", CaptionColor);

   if (TradeLots == 0)
   {
      if (RiskPercentage <= 0)
      {
         str = StringConcatenate("Minimal (", GetLotsToBid(RiskPercentage), ") ");
      }
      else
      {
         str = StringConcatenate(DoubleToStr(RiskPercentage, 1), "% of free margin (", GetLotsToBid(RiskPercentage), " lots)");
      }
   }
   else
   {
      str = "Fixed = " + TradeLots;
   }
   SetLeftLabel(ID() + INFO_ID + "lots V", window, INFO_LOTS_VALUE_X, INFO_LOTS_VALUE_Y, str, "Arial", ValueColor);

   //leverage
   str = AccountLeverage() + ":1";
   if (str == "") str = "N\A";

   SetLeftLabel(ID() + INFO_ID + "lvrg C", window, INFO_LVRG_CAPTION_X, INFO_LVRG_CAPTION_Y, "Leverage:", "Arial", CaptionColor);
   SetLeftLabel(ID() + INFO_ID + "lvrg V", window, INFO_LVRG_VALUE_X, INFO_LVRG_VALUE_Y, str, "Arial", ValueColor);

   //company
   str = AccountCompany();
   if (str == "") str = "N\A";

   SetLeftLabel(ID() + INFO_ID + "cmp C", window, INFO_COMPANY_CAPTION_X, INFO_COMPANY_CAPTION_Y, "Company:", "Arial", CaptionColor);
   SetLeftLabel(ID() + INFO_ID + "cmp V", window, INFO_COMPANY_VALUE_X, INFO_COMPANY_VALUE_Y, str, "Arial", ValueColor);

   //currency
   str = AccountCurrency();
   if (str == "") str = "N\A";

   SetLeftLabel(ID() + INFO_ID + "curr C", window, INFO_CURR_CAPTION_X, INFO_CURR_CAPTION_Y, "Currency:", "Arial", CaptionColor);
   SetLeftLabel(ID() + INFO_ID + "curr V", window, INFO_CURR_VALUE_X, INFO_CURR_VALUE_Y, str, "Arial", ValueColor);

   //server
   str = AccountServer();
   if (str == "") str = "N\A";

   SetLeftLabel(ID() + INFO_ID + "srvr C", window, INFO_SERVER_CAPTION_X, INFO_SERVER_CAPTION_Y, "Active Server:", "Arial", CaptionColor);
   SetLeftLabel(ID() + INFO_ID + "srvr V", window, INFO_SERVER_VALUE_X, INFO_SERVER_VALUE_Y, str, "Arial", ValueColor);

   //magic
   str = Magic;
   if (Magic == -1) str = "Not Accounted";

   SetLeftLabel(ID() + INFO_ID + "magic C", window, INFO_MAGIC_CAPTION_X, INFO_MAGIC_CAPTION_Y, "Magic number:", "Arial", CaptionColor);
   SetLeftLabel(ID() + INFO_ID + "magic V", window, INFO_MAGIC_VALUE_X, INFO_MAGIC_VALUE_Y, str, "Arial", ValueColor);

   //time
   str = "Copyright (c) 2010, TheXpert       " + TimeToStr(MarketInfo(Symbol(), MODE_TIME), TIME_DATE | TIME_MINUTES | TIME_SECONDS);

   SetLabel(ID() + INFO_ID + "time V", window, INFO_TIME_VALUE_X, INFO_TIME_VALUE_Y, str, "Arial", ValueColor);
}

///=========================================================================
/// Orders bar
///=========================================================================

#define ORDERS_ACCEPT_X 10
#define ORDERS_CHECK_X  40
#define ORDERS_TICKET_X 80
#define ORDERS_TYPE_X   150
#define ORDERS_LOTS_X   230
#define ORDERS_OPEN_X   310
#define ORDERS_SL_X     390
#define ORDERS_TP_X     470

#define ORDERS_ID "_order_"

void ClearOrders()
{
   string prefix = ORDERS_ID + ID();

   for (int i = ObjectsTotal() - 1; i >= 0; i--)
   {
      string name = ObjectName(i);
      int pos = StringFind(name, prefix);
      if (pos >= 0)
      {
         string ticket = StringSubstr(name, 0, pos - 1);
         if (ticket == "")
         {
            ObjectDelete(name);
            continue;
         }
         
         if (!OrderSelect(StrToInteger(ticket), SELECT_BY_TICKET))
         {
            ObjectDelete(name);
         }
         else if (OrderCloseTime() != 0)
         {
            ObjectDelete(name);
         }
      }
   }
}

void DrawOrders()
{
   int window = GetOrdersWindow();
   int pos;
   
   if (window == -1) return;
   
   string prefix = ORDERS_ID + ID();
   
   string ticketCaption = prefix + "ticket";
   string typeCaption   = prefix + "type";
   string lotsCaption   = prefix + "lots";
   string openCaption   = prefix + "open";
   string slCaption     = prefix + "sl";
   string tpCaption     = prefix + "tp";
   string checkCaption  = prefix + "check";
   string acceptCaption = prefix + "accept";

   pos = 70;

   int count = OrdersTotal();
   for (int i = 0; i < count; i++)
   {
      if (!OrderSelect(i, SELECT_BY_POS))             continue;
      if(OrderSymbol() != Symbol())    continue;
      
      int magic = OrderMagicNumber();
      if(Magic != -1 && magic != Magic && (magic != EAMagic || EAMagic == -1))  continue;
      
      string add = OrderTicket() + " ";
      
      int checkX = ORDERS_CHECK_X;
      int acceptX = ORDERS_ACCEPT_X;
      
      if (
            CheckPressed(
               add + checkCaption, checkX, pos, CheckerSymbolCode, CheckerColor,
               add + acceptCaption, acceptX, pos, AcceptorSymbolCode, AcceptorColor,
               window, 1
            )
         )
      {
         int ticket = OrderTicket();
         Comment_("\"Close\" command accepted for order #" + ticket);
         int type = OrderType();
         
         if (type == OP_BUY || type == OP_SELL)
         {
            OrderClose(ticket, OrderLots(), OrderClosePrice(), Slippage);
         }
         else
         {
            OrderDelete(ticket);
         }
      }

      pos += 15;
   }

   ClearOrders();
   
   SetLeftLabel(ticketCaption,window, ORDERS_TICKET_X, 40, "Ticket",       "Arial", CaptionColor, 10);
   SetLeftLabel(typeCaption,  window, ORDERS_TYPE_X,   40, "Order Type",   "Arial", CaptionColor, 10);
   SetLeftLabel(lotsCaption,  window, ORDERS_LOTS_X,   40, "Lots",         "Arial", CaptionColor, 10);
   SetLeftLabel(openCaption,  window, ORDERS_OPEN_X,   40, "Open Price",   "Arial", CaptionColor, 10);
   SetLeftLabel(slCaption,    window, ORDERS_SL_X,     40, "Stop Loss",    "Arial", CaptionColor, 10);
   SetLeftLabel(tpCaption,    window, ORDERS_TP_X,     40, "Take Profit",  "Arial", CaptionColor, 10);
   SetLeftLabel(checkCaption, window, ORDERS_ACCEPT_X, 40, "Close",        "Arial", CaptionColor, 10);

   pos = 55;

   count = OrdersTotal();
   for (i = 0; i < count; i++)
   {
      if (!OrderSelect(i, SELECT_BY_POS))             continue;
      if(OrderSymbol() != Symbol())    continue;

      magic = OrderMagicNumber();
      if(Magic != -1 && magic != Magic && (magic != EAMagic || EAMagic == -1))  continue;
      
      add = OrderTicket() + " ";
      
      SetLeftLabel(add + checkCaption,    window, ORDERS_CHECK_X,  pos, CharToStr(CheckerSymbolCode), "Wingdings", CheckerColor, 10);
      SetLeftLabel(add + acceptCaption,   window, ORDERS_ACCEPT_X, pos, CharToStr(AcceptorSymbolCode),"Wingdings", AcceptorColor,10);
      string text = OrderTicket();
      SetLeftLabel(add + ticketCaption,   window, ORDERS_TICKET_X, pos, text, "Arial", ValueColor, 10);
      text = OrderTypeAsString(OrderType());
      SetLeftLabel(add + typeCaption,     window, ORDERS_TYPE_X,   pos, text, "Arial", ValueColor, 10);
      text = DoubleToStr(OrderLots(), 2);
      SetLeftLabel(add + lotsCaption,     window, ORDERS_LOTS_X,   pos, text, "Arial", ValueColor, 10);
      text = DoubleToStr(OrderOpenPrice(), Digits);
      SetLeftLabel(add + openCaption,     window, ORDERS_OPEN_X,   pos, text, "Arial", ValueColor, 10);
      text = DoubleToStr(OrderStopLoss(), Digits);
      SetLeftLabel(add + slCaption,       window, ORDERS_SL_X,     pos, text, "Arial", ValueColor, 10);
      text = DoubleToStr(OrderTakeProfit(), Digits);
      SetLeftLabel(add + tpCaption,       window, ORDERS_TP_X,     pos, text, "Arial", ValueColor, 10);
      
      pos += 15;
   }
}

#define ORDERS_CLOSE_X  300
#define ORDERS_CLOSE_Y  10

#define ORDERS_CLOSE_BUYS_X      50
#define ORDERS_BUYS_CHK_X        120
#define ORDERS_BUYS_ACC_X        90

#define ORDERS_CLOSE_SELLS_X     200
#define ORDERS_SELLS_CHK_X       270
#define ORDERS_SELLS_ACC_X       240

#define ORDERS_CLOSE_ALL_X       350
#define ORDERS_ALL_CHK_X         420
#define ORDERS_ALL_ACC_X         390

#define ORDERS_CLOSE_PENDING_X   500
#define ORDERS_PEND_CHK_X        600
#define ORDERS_PEND_ACC_X        570

#define ORDERS_COMMANDS_Y 25

#define ORDERS_CMD_ID "_orders_cmd_"

void CheckOrders()
{
   int window = GetOrdersWindow();
   if (window == -1) return;
   
   string prefix = ORDERS_CMD_ID + ID();
   
   string closeCaption  = prefix + "close cmd";
   string allCaption    = prefix + "close all";
   string buysCaption   = prefix + "close buys";
   string sellsCaption  = prefix + "close sells";
   string pendingCaption= prefix + "close pend";

   SetLeftLabel(closeCaption,    window, ORDERS_CLOSE_X,          ORDERS_CLOSE_Y,      "Close for " + Symbol() + " :",   "Arial", CaptionColor, 10);
   SetLeftLabel(allCaption,      window, ORDERS_CLOSE_ALL_X,      ORDERS_COMMANDS_Y,   "All",      "Arial", CaptionColor, 10);
   SetLeftLabel(buysCaption,     window, ORDERS_CLOSE_BUYS_X,     ORDERS_COMMANDS_Y,   "Buys",     "Arial", CaptionColor, 10);
   SetLeftLabel(sellsCaption,    window, ORDERS_CLOSE_SELLS_X,    ORDERS_COMMANDS_Y,   "Sells",    "Arial", CaptionColor, 10);
   SetLeftLabel(pendingCaption,  window, ORDERS_CLOSE_PENDING_X,  ORDERS_COMMANDS_Y,   "Pendings", "Arial", CaptionColor, 10);
   
   int x1 = ORDERS_ALL_CHK_X;
   int x2 = ORDERS_ALL_ACC_X;
   int y1 = ORDERS_COMMANDS_Y;
   int y2 = ORDERS_COMMANDS_Y;
   
   if (CheckPressed(
         allCaption + "chk", x1, y1, CheckerSymbolCode, CheckerColor,
         allCaption + "acc", x2, y2, AcceptorSymbolCode, AcceptorColor,
         window, 1)
     )
   {
      Comment_("\"Close all\" command accepted. Closing orders...");
      CloseBuys(Magic, Slippage);
      CloseSells(Magic, Slippage);
      DeletePending(Magic);
      
      if (Magic != -1 && EAMagic != -1 && Magic != EAMagic)
      {
         CloseBuys(EAMagic, Slippage);
         CloseSells(EAMagic, Slippage);
         DeletePending(EAMagic);
      }
   }
   
   SetLeftLabel(allCaption + "chk",   window, ORDERS_ALL_CHK_X, ORDERS_COMMANDS_Y, CharToStr(CheckerSymbolCode), "Wingdings", CheckerColor, 10);
   SetLeftLabel(allCaption + "acc",   window, ORDERS_ALL_ACC_X, ORDERS_COMMANDS_Y, CharToStr(AcceptorSymbolCode),"Wingdings", AcceptorColor,10);

   x1 = ORDERS_BUYS_CHK_X;
   x2 = ORDERS_BUYS_ACC_X;
   y1 = ORDERS_COMMANDS_Y;
   y2 = ORDERS_COMMANDS_Y;

   if (CheckPressed(
         buysCaption + "chk", x1, y1, CheckerSymbolCode, CheckerColor,
         buysCaption + "acc", x2, y2, AcceptorSymbolCode, AcceptorColor,
         window, 1)
     )
   {
      Comment_("\"Close buys\" command accepted. Closing orders...");
      CloseBuys(Magic, Slippage);

      if (Magic != -1 && EAMagic != -1 && Magic != EAMagic)
      {
         CloseBuys(EAMagic, Slippage);
      }
   }
   
   SetLeftLabel(buysCaption + "chk",   window, ORDERS_BUYS_CHK_X, ORDERS_COMMANDS_Y, CharToStr(CheckerSymbolCode), "Wingdings", CheckerColor, 10);
   SetLeftLabel(buysCaption + "acc",   window, ORDERS_BUYS_ACC_X, ORDERS_COMMANDS_Y, CharToStr(AcceptorSymbolCode),"Wingdings", AcceptorColor,10);

   x1 = ORDERS_SELLS_CHK_X;
   x2 = ORDERS_SELLS_ACC_X;
   y1 = ORDERS_COMMANDS_Y;
   y2 = ORDERS_COMMANDS_Y;

   if (CheckPressed(
         sellsCaption + "chk", x1, y1, CheckerSymbolCode, CheckerColor,
         sellsCaption + "acc", x2, y2, AcceptorSymbolCode, AcceptorColor,
         window, 1)
     )
   {
      Comment_("\"Close sells\" command accepted. Closing orders...");
      CloseSells(Magic, Slippage);

      if (Magic != -1 && EAMagic != -1 && Magic != EAMagic)
      {
         CloseSells(EAMagic, Slippage);
      }
   }

   SetLeftLabel(sellsCaption + "chk",   window, ORDERS_SELLS_CHK_X, ORDERS_COMMANDS_Y, CharToStr(CheckerSymbolCode), "Wingdings", CheckerColor, 10);
   SetLeftLabel(sellsCaption + "acc",   window, ORDERS_SELLS_ACC_X, ORDERS_COMMANDS_Y, CharToStr(AcceptorSymbolCode),"Wingdings", AcceptorColor,10);

   x1 = ORDERS_PEND_CHK_X;
   x2 = ORDERS_PEND_ACC_X;
   y1 = ORDERS_COMMANDS_Y;
   y2 = ORDERS_COMMANDS_Y;

   if (CheckPressed(
         pendingCaption + "chk", x1, y1, CheckerSymbolCode, CheckerColor,
         pendingCaption + "acc", x2, y2, AcceptorSymbolCode, AcceptorColor,
         window, 1)
     )
   {
      Comment_("\"Close pending\" command accepted. Closing orders...");
      DeletePending(Magic);

      if (Magic != -1 && EAMagic != -1 && Magic != EAMagic)
      {
         DeletePending(EAMagic);
      }
   }

   SetLeftLabel(pendingCaption + "chk",   window, ORDERS_PEND_CHK_X, ORDERS_COMMANDS_Y, CharToStr(CheckerSymbolCode), "Wingdings", CheckerColor, 10);
   SetLeftLabel(pendingCaption + "acc",   window, ORDERS_PEND_ACC_X, ORDERS_COMMANDS_Y, CharToStr(AcceptorSymbolCode),"Wingdings", AcceptorColor,10);

   DrawOrders();
}

///=========================================================================
/// Body
///=========================================================================

void CheckToolbar()
{
   if (GetToolWindow() == -1)
   {
      ClearButtons();
      ClearLines();
      ClearPendingLines();
      
      return;
   }
   
   CheckObjectsProperties();
   
   CheckButtons();
   CheckLines();
   CheckPendingLines();
   
   CheckComments();
}

void CheckInfobar()
{
   int window = GetInfoWindow();
   if (window == -1)
   {
      ClearInformation();
      
      return;
   }
   
   DrawInformation();
}

void CheckOrdersbar()
{
   int window = GetOrdersWindow();
   if (window == -1)
   {
      ClearOrders();
      
      return;
   }
   
   CheckOrders();
}

void DragTrade_Init(int magic, int eaMagic, int timesToRepeat, int slippage, string ordersComment = "")
{
   Magic = magic;
   EAMagic = eaMagic;
   TimesToRepeat = timesToRepeat;
   Slippage = slippage;
   
   OrdersComment = ordersComment;
   if (OrdersComment == "")
   {
      OrdersComment = "Opened via Drag Trade";
   }
   
   InitProperties();
   
   InitObjectsProperties();
   InitTradeProperties();
   InitComments();

   Comment_("Init finished successfully");
}

void DragTrade_Start()
{
   CheckTradeProperties();

   CheckToolbar();
   CheckInfobar();
   CheckOrdersbar();

   WindowRedraw();
}

void DragTrade_Deinit()
{
   int count = ObjectsTotal();
   for (int i = count - 1; i >= 0; i--)
   {
      string name = ObjectName(i);
      if (StringFind(name, ID()) != -1)
      {
         ObjectDelete(name);
      }
   }
}