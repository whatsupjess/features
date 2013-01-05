implement Phone;

include "sys.m"; sys: Sys; stderr: ref sys->FD;
include "bufio.m"; bufio: Bufio; Iobuf: import bufio;
include "draw.m";

Phone: module {
	init: fn(nil: ref Draw->Context, args: list of string);
};

words: list of string;
numbers := array[10] of {
	2 => "abcABC",
	3 => "defDEF",
	4 => "ghiGHI",
	5 => "jklJKL",
	6 => "mnoMNO",
	7 => "pqrsPQRS",
	8 => "tuvTUV",
	9 => "wxyzWXYZ",
	* => "",
};

load_dictionary(path: string)
{
	file := bufio->open(path, Bufio->OREAD);
	if (file == nil) {
		sys->fprint(stderr, "could not open %s for reading: %r", path);
		raise "load_dictionary";
	}

	word := file.gets('\n');
	while (word != "") {
		words = word[0:len word -1] :: words;
		word = file.gets('\n');
	}

	file.close();
}

includes_letter(s: string, c: int): int
{
	for (i:=0; i<len s; i++)
		if (s[i]==c)
			return 1;

	return 0;
}

number_makes_word(n, word: string): int 
{
	if (len n != len word)
		return 0;

	for (i :=0; i<len word; i++) {
		if (!includes_letter(numbers[int n[i:i+1]], word[i]))
			return 0;
	}

	return 1;
}

	

number_to_words(n: string): list of string
{
	r: list of string;
	wordlist := words;
	while (wordlist != nil){
		if (number_makes_word(n, hd wordlist))
			r = hd wordlist :: r;
		wordlist = tl wordlist;
	}
	return r;
}

init(nil: ref Draw->Context, args: list of string)
{
	sys = load Sys Sys->PATH;
	bufio = load Bufio Bufio->PATH;
	stderr = sys->fildes(2);

	ws: list of string;
	load_dictionary("/lib/words");
	sys->print ("%d words loaded \n", len words);

	args = tl args;
	while (args != nil) {
		sys->print ("%s:", hd args);
		#fill in here the words that the number could spell
		ws = number_to_words(hd args);
		while (ws != nil){
			sys->print (" %s", hd ws);
			ws = tl ws;
		}
		sys->print ("\n");
		args = tl args;
	}
		
}