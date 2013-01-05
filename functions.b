implement Functions;

include "sys.m"; sys: Sys;
include "string.m"; str: String;
include "draw.m"; 

Functions: module {
	init: fn(nil: ref Draw->Context, nil: list of string);

};

init(nil: ref Draw->Context, args: list of string)
{
	sys = load Sys Sys->PATH;
	args = tl args;
	i:= int hd args;
	sys->print("fact(%d) = %d\n", i, fact(i));
	sys->print("fib(%d) = %d\n", i, fib(i));
}

# 0! = 1
# N! = N * (N - 1)!
fact(i: int): int 
{
	if (i == 0)
		return 1;
	return i*fact(i -1);
}

# fib(0) = fib(1) = 1
# fib(N) = fib(N - 1) + fib(N - 2) 

fib(i:int): int
{
	if (i == 0)
		return 1;
	if (i == 1)
		return 1;
	
	return fib(i-1) + fib(i-2);
	
}
