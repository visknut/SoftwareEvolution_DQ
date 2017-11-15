module cleantext

import lang::java::jdt::m3::Core;
import List;
import Set;
import String;
import IO;
import util::Math;

private str removeComments(str text) {
	return visit(text) {
		case /\/\/.*/ => "" // SingleLine
		case /\/\*.*?\*\//s => "" // MultiLine /s for single line matching regex flag
	}
}

private list[str] removeEmptyLines(str text) {
	return [ x | x <- split("\n", text), /^\s*$/ !:= x ]; // /^\s*$/ removes empty lines
}

public list[str] cleanText(loc file) {
	text = readFile(file);
	textNoComments = removeComments(text);
	textInList = removeEmptyLines(textNoComments);
	return textInList;
}