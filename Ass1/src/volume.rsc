module volume

import lang::java::jdt::m3::Core;
import List;
import Set;
import String;
import IO;
import util::Math;

public int countModelLoc(loc file) = size(modelLoc(file));

void printVolume(M3 model) {
	println(sum(mapper(toList(classes(model)), countModelLoc)));
}

public list[str] modelLoc(loc file) {
	text = readFile(file);
	textNoComments = removeComments(text);
	textInList = [ x | x <- split("\n", textNoComments), /^\s*$/ !:= x ]; // /^\s*$/ removes empty lines
	return textInList;
}

private str removeComments(str text) {
	// Todo: some magic
	return text;
}
