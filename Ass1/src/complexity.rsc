module complexity

import lang::java::jdt::m3::Core;
import List;
import Set;
import String;
import IO;
import util::Math;

import cleantext;

public int countComplexity(loc file) {
	cleanMethod = cleanText(file);
	return 1 + sum(mapper(cleanMethod, countComplexityLine));	
}

void printComplexity(M3 model) {
	methodsSizes = mapper(toList(methods(model)), countComplexity);
}


//• if
//• case
//• ?
//• &&, ||
//• while
//• for
//• catch