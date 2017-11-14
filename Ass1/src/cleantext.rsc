module cleantext

import lang::java::jdt::m3::Core;
import List;
import Set;
import String;
import IO;
import util::Math;

private str removeComments(str text) {
	// Todo: some magic
	return text;
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