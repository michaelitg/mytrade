//+------------------------------------------------------------------+
//| My Automated Trading EA.mq4
//| Copyright 2013, Ryan Sheehy
//| http://www.currencysecrets.com
//+------------------------------------------------------------------+
#property copyright "Copyright 2013, Ryan Sheehy"
#property link      "http://www.currencysecrets.com"

//--- input parameters

// daily drawdown limit where account ceases trading for the day - as a decimal (i.e. 0.1 = 10%)
extern double 	EXT_DAILY_EQUITY_LIMIT	= 0.1; 
// weekly drawdown limit where account ceases trading for the rest of the week - as a decimal (i.e. 0.2 = 20%)
extern double 	EXT_WEEKLY_EQUITY_LIMIT = 0.2; 
// monthly drawdown limit where account ceases trading for the rest of the month - as a decimal (i.e. 0.3 = 30%)
extern double 	EXT_MONTHLY_EQUITY_LIMIT = 0.3;


//--- currency globals
datetime NEWDAY, NEWWEEK, NEWMONTH;

int start()
{
	if ( NEWDAY != iTime( SYM, PERIOD_D1, 0 ) ) {
		GlobalVariableSet( "EQUITY-DAILY", AccountEquity() );
		NEWDAY = iTime( SYM, PERIOD_D1, 0 );
	}
	if ( NEWWEEK != iTime( SYM, PERIOD_W1, 0 ) ) {
		GlobalVariableSet( "EQUITY-WEEKLY", AccountEquity() );
		// as the global variable resets every 4 weeks we will reset the monthly
		// account equity: http://docs.mql4.com/globals/globalvariableset
		if ( GlobalVariableCheck( "EQUITY-MONTHLY" ) ) 
			GlobalVariableSet( "EQUITY-MONTHLY", GlobalVariableGet( "EQUITY-MONTHLY" ) );
		NEWWEEK = iTime( SYM, PERIOD_W1, 0 );
	}
	if ( NEWMONTH != iTime( SYM, PERIOD_MN1, 0 ) ) {
		GlobalVariableSet( "EQUITY-MONTHLY", AccountEquity() );
		NEWMONTH = iTime( SYM, PERIOD_MN1, 0 );
	}


	return(0);
}

// function to determine whether entry is viable according to other constraints
bool finalGate() {
	// check that the daily drawdown limit has not been reached
	if ( GlobalVariableCheck( "EQUITY-DAILY") && GlobalVariableGet( "EQUITY-DAILY" ) > 0 &&
		AccountEquity() / GlobalVariableGet( "EQUITY-DAILY" ) > 1 - EXT_DAILY_EQUITY_LIMIT ) return ( true );
	// check that the weekly drawdown limit has not been reached
	if ( GlobalVariableCheck( "EQUITY-WEEKLY") && GlobalVariableGet( "EQUITY-WEEKLY" ) > 0 &&
		AccountEquity() / GlobalVariableGet( "EQUITY-WEEKLY" ) > 1 - EXT_WEEKLY_EQUITY_LIMIT ) return ( true );
	// check that the monthly drawdown limit has not been reached
	if ( GlobalVariableCheck( "EQUITY-MONTHLY") && GlobalVariableGet( "EQUITY-MONTHLY" ) > 0 &&
		AccountEquity() / GlobalVariableGet( "EQUITY-MONTHLY" ) > 1 - EXT_MONTHLY_EQUITY_LIMIT ) return ( true );
	return ( false );
}