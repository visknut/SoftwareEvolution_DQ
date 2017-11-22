module duplication

import lang::java::jdt::m3::Core;
import analysis::m3::Core;
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

import cleantext;

/* Take every method and compare to all the other methods once. */
void printDuplication(M3 model) {
	cleanMethods = mapper(toList(methods(model)), cleanText);
	lines = 0;
	duplicateLines = 0;
	while (size(cleanMethods) > 1) {
		checkMethod = head(cleanMethods);
		cleanMethods = drop(1, cleanMethods);
		cleanMethods = [ x | x <- cleanMethods, size(x) > 6];
		cleanMethods = [ x | x <- cleanMethods, size(x) > 6];
		duplicateLines += compareWithAll(checkMethod, cleanMethods);
		lines += size(checkMethod);
	}
	iprintln(duplicateLines);
	iprintln(lines);
}

/* Compare a method with a list of methods. */
int compareWithAll(list[str] method, list[list[str]] methods) {
	print(".");
	duplicateLines = 0;
	for(list [str] comparedMethod <- methods) {
		newDuplicateLines = compareMethods(method, comparedMethod);
		if (newDuplicateLines > duplicateLines) {
			duplicateLines = newDuplicateLines;
		}
	}
	return duplicateLines;
}

/* Compare two method to find the number of duplicate lines. */
int compareMethods(list[str] method, list[str] comparedMethod) {
	duplicateLines = 0;
	for(int i <- [0 .. size(comparedMethod)]) {
		for(int j <- [0 .. size(method)]) {
			if(method[j] == comparedMethod[i]) {
				sameLines = checkLines(method, i, comparedMethod, j);
				if (sameLines > 6 && sameLines > duplicateLines) {
					duplicateLines = sameLines;
					//println("-----------------------------");
					//println(method);
					//println();
					//println(comparedMethod);
					//println();
					//print("Number of line: "); println(sameLines);
					//println("-----------------------------");
				}
			}
		}
	}
	return duplicateLines;
}

/* Compare a subseuqent set of lines until they don't match */
int checkLines(list[str] method, int i, list[str] comparedMethod, int j) {
	lines = 0;
	line = "";
	comparedLine = "";
	do {
		lines += 1;
		i += 1;
		j += 1;
		
		if (i < size(comparedMethod)) {
			comparedLine = comparedMethod[i];
		} else {
			break;
		}
		
		if (j < size(method)) {
			line = method[j];
		} else {
			break;
		}
	} while (line == comparedLine);
	
	return lines;
}


// x = [ f | /file(f) <- crawl(|project://Library|), f.extension == "java"];
// Code block is at least 6 loc