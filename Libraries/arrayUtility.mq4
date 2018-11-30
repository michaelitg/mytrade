void flushArray( int& arr[] ) {
	ArrayInitialize( arr, 0 );
	ArrayResize( arr, 0 );
}

// append new element to end of int array
void intArrayPush( int& arr[], int elem ) {
	int size = ArraySize( arr );
	ArrayResize( arr, size + 1 );
	arr[ size ] = elem;
}

// remove last element of int array
void intArrayPop( int& arr[] ) {
	int size = ArraySize( arr );
	ArrayResize( arr, size - 1 );
}