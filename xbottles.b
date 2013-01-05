#prints out lyrics to "X bottles of beer" starting at specified X 

implement xbottles;

include "sys.m";
sys: Sys;
include "draw.m";

xbottles: module

{
	init: fn(ctxt: ref Draw ->Context, argv : list of string);
};


pluralize_bottles (i:int): string
{
 

#if i =1, use "1 bottle."
#return isn't just a fancier print, it means there is a value

if (i==1)
return sys->sprint("%d bottle", i);
 
#if i=0, say "no more bottles"

if (i==0)
return "no more bottles";

#if i >1, use "i bottles."

return sys->sprint("%d bottles", i);

}

init(ctxt : ref Draw ->Context, args : list of string)

{
	i:= 3;
	sys =load Sys Sys->PATH;

	if (tl args != nil)
		i= int hd tl args;

	for (; i>0; i--) {
		sys->print("%s of beer on the wall,\n",pluralize_bottles(i));
		sys->print("%s of beer,\n",pluralize_bottles(i));
		sys->print("Take one down, pass it around,\n");
		sys->print("%s of beer on the wall.\n\n", pluralize_bottles(i-1));

  	}


	
}

