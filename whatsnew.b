implement Whatsnew;

include "sys.m"; sys: Sys;
include "draw.m";
include "string.m"; str: String;
stderr: ref sys->FD;
include "bufio.m"; bufio: Bufio;
include "readdir.m"; readdir: Readdir;

Whatsnew: module {
	init: fn(nil: ref Draw ->Context, args: list of string);

};

init(nil: ref Draw->Context, args: list of string)
{
	readdir = load Readdir Readdir->PATH;
	sys = load Sys Sys->PATH;
	stderr = sys->fildes(2);

	if(len args != 3) {
		sys->fprint(stderr, "whatsnew:  usage:  whatsnew srcdir destdir\n");
		raise "fail:usage";
	}
	args = tl args;

	#read all the files in both directories passed
	srcdirname := hd args;
	args = tl args;
	destdirname := hd args;
	
	srcdir := ls(srcdirname);
	destdir := ls(destdirname);
	
	newer := compare(srcdir, destdir);
	while(newer != nil) {
		sys->print("%s\n", hd newer);
		newer = tl newer;
	}

	
}

ls(dirname: string): array of ref Sys->Dir
{
	(entries, entrycounts) := readdir->init(dirname, Readdir->NAME);
	if (entrycounts <0){
		sys->fprint(stderr, "whatsnew could not read %s:%r\n", dirname);
		raise "fail:errors";
	}
	return entries;
	
}

#compare srcdir and destdir, return a list of files that are only present or are newer in 
# srcdir. 
compare(srcdir, destdir: array of ref Sys->Dir): list of string
{
	
	#sets up where the output of the sync program will go (the output)
	output: list of string = nil; #this is an empty list so far
	i, j: int;
	j=0;
	
	#goes through the lists of i and compares to j sequentially
	outer: for (i=0; i < len srcdir; i++) {
		while (srcdir[i].name > destdir[j].name) {
			j++;
			if (j >= len destdir)
				break outer;
		}

		if (srcdir[i].name < destdir[j].name || srcdir[i].mtime > destdir[j].mtime) {
			output = srcdir[i].name :: output;
		}
	}
			

	while (i < len srcdir) {
		output = srcdir[i].name :: output;
		i++;
	}

	return reverse(output);

}

reverse(l: list of string): list of string
{
	out: list of string = nil;
	while (l != nil) {
		out = hd l :: out;
		l = tl l;
	}
	
	return out;
}
	