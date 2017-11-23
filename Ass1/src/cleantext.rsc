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
		case /\/\/.*/ => "" // SingleLine		
	};
	
	textNoComments = visit(textNoComments) {
		case /\/\*.*?\*\//s => "" // MultiLine /s for single line matching regex flag	
	};
	
	textInList = [ trim(x) | x <- split("\n", textNoComments), /^\s*$/ !:= x ]; // /^\s*$/ select white
	
	return textInList;
}
