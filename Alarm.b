#make a very simple alarm-type program that pops up a shell after X seconds
#would have been nice to make inferno play a sound but apparently inferno "doesn't do sound well"

implement Alarm;

include "sys.m"; sys: Sys;
include "draw.m";
include "daytime.m";
include "sh.m";


Alarm: module {
	init: fn(ctxt: ref Draw ->Context, args: list of string);
};

init(ctxt: ref Draw->Context, args: list of string)
{

	#establish when you want the shell to pop up in seconds
	sys = load Sys Sys->PATH;
	stderr := sys ->fildes(2);
	args = tl args;

	if (args == nil) {
		sys->fprint(stderr, "doesn't work like that\n");
		raise "fail: usage";
	}
	
	#declare and initialize cmd, run the command 	
	cmd := load Command "/dis/wm/sh.dis";

	#raise a fail if path is invalid
	if (cmd == nil) {
		sys->fprint(stderr, "invalid path name: %r\n");
		raise "fail: module";
	}
		
	input:= int hd args;
	
	if (input > 0) {
		sys->sleep(input*1000);
	}

	cmd->init(ctxt, nil);
	

}