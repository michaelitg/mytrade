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
//|                                   DragTrade_CommentsSettings.mq4 |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2009, TheXpert"
#property link      "theforexpert@gmail.com"

#property show_inputs

#include <DragTrade_v_1.0/DragTrade_Property.mqh>
#include <DragTrade_v_1.0/DragTrade_Properties/CommentsProperties.mqh>

extern string  _1_                   = "Distance between comments lines";
extern bool    Set_1_                = false;
extern int     CommentsLinesDistance = DefaultCommentsLinesDistance;
extern string  _2_                   = "Text color for comments";
extern bool    Set_2_                = false;
extern color   CommentsTextColor     = DefaultCommentsTextColor;
extern string  _3_                   = "Text size for comments";
extern bool    Set_3_                = false;
extern int     CommentsTextSize      = DefaultCommentsTextSize;
extern string  _4_                   = "Max symbols count in comments line";
extern bool    Set_4_                = false;
extern int     CommentsLineSymbols   = DefaultCommentsLineSymbols;
extern string  _5_                   = "Count of comments lines";
extern bool    Set_5_                = false;
extern int     CommentsLinesCount    = DefaultCommentsLinesCount;
extern string  _6_                   = "Count of spaces in tab symbol";
extern bool    Set_6_                = false;
extern int     CommentsLinesTabSize  = DefaultCommentsLinesTabSize;

int start()
{
   SetTesting(true);
   DoIt();
   
   return(0);
}

void DoIt()
{
   if (Set_1_) SetProperty(CommentsLinesDistanceName, CommentsLinesDistance);
   if (Set_2_) SetProperty(CommentsTextColorName,     CommentsTextColor);
   if (Set_3_) SetProperty(CommentsTextSizeName,      CommentsTextSize);
   if (Set_4_) SetProperty(CommentsLineSymbolsName,   CommentsLineSymbols);
   if (Set_5_) SetProperty(CommentsLinesCountName,    CommentsLinesCount);
   if (Set_6_) SetProperty(CommentsLinesTabSizeName,  CommentsLinesTabSize);
}