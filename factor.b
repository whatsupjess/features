implement Factor;

include "sys.m";
sys: Sys;
include "draw.m";

Factor: module

{
	init: fn(ctxt: ref Draw ->Context, argv : list of string);
};

factor(n : int)
{
	#print out the argument followed by a colon

	sys->print("%d :", n);

	#loop through positive integers starting at 2

   	for(i:=2; n > 1; i++) {
		# while i divides n

		while (n % i == 0) {
		# 	print i
		sys->print (" %d", i);

		#	divide n by i
		n = n/i;
		}
	}
	sys ->print ("\n");
}

init(ctxt: ref Draw ->Context, argv : list of string)
{
	sys =load Sys Sys->PATH;
	n := tl argv;

	while(n != nil) { 
	factor(int hd n);
	n = tl n; 
	}
}

