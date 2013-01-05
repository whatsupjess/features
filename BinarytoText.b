implement BinarytoText;

include "sys.m"; sys: Sys;
include "draw.m"; 
include "bufio.m"; bufio: Bufio; Iobuf: import bufio;


BinarytoText: module {
	init: fn(nil: ref Draw->Context, args: list of string);
};

init(nil: ref Draw->Context, nil: list of string)
{
	sys = load Sys Sys->PATH;
	bufio = load Bufio Bufio->PATH;

	stdin := bufio->fopen(sys->fildes(0), Bufio->OREAD);
	if(stdin == nil) {
		sys->fprint(sys->fildes(2), "couldn't get bufio:  %r\n");
		raise "fail:error";
	}

	c := 0;
	bits := 0;

	#  1) read a character
	while((ch := stdin.getc()) != Bufio->EOF) {
		#  2) If it is one, add one to c

		#  3) If it is either one or zero, add one to n
		if((ch & ~1) == '0') { # i.e. if it is the char 0 or 1
			bits++;
			c |= (ch & 1);
		}
		#  4) If n is eight, then you have a full byte.  Print the character, and reset c and n to zero.
		if(bits == 8) {
			sys->print("%c", c);
			c = bits = 0;
		} else {
			#  5) If n is not eight, then multiply c by 2.	
			c *= 2; #same as c = c*2
		}
		#  sys->print("ch:%02x c:%02x bits: %d\n", ch, c, bits);
	}
}