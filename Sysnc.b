implement Sysync;

include "sys.m"; sys:Sys;
include "daytime.m";
include "string.m"; str: String;
include "draw.m";
include "rand.m";

Sysync: module {
	init: fn(nil: ref Draw ->Context, args: list of string);
};

