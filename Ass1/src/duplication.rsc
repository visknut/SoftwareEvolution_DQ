module duplication

import lang::java::jdt::m3::Core;
import List;
import Set;
import String;
import IO;
import util::Math;
import lang::java::\syntax::Java15;
import Exception;
import ParseTree;
import util::FileSystem;
import lang::java::\syntax::Disambiguate;


void printDuplication(M3 model) {
	x = [ f | /file(f) <- crawl(|project://Library|), f.extension == "java"];
	// Code block is at least 6 loc
	iprintln(x);
}
