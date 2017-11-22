module cleantext

import lang::java::jdt::m3::Core;
import List;
import Set;
import String;
import IO;
import util::Math;

public list[str] cleanText(loc file) {
	text = readFile(file);
	
	textNoComments = visit(text) {
		case /\/\*.*?\*\//s => "" // MultiLine /s for single line matching regex flag	
	};
	textNoComments = visit(textNoComments) {
		case /\/\/.*/ => "" // SingleLine		
	};
	
	textInList = [ trim(x) | x <- split("\n", textNoComments), /^\s*$/ !:= x ]; // /^\s*$/ select white
	//println(textInList);
	return textInList;
}
