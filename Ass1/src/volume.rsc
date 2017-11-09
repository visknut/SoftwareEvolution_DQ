module volume

import lang::java::jdt::m3::Core;
import List;
import Set;
import String;
import IO;
import util::Math;

public int countModelLoc(loc file) = size(modelLoc(file));
private list[str] splitText(str text) = [ s | s <- split("\n", text), /^\s*$/ !:= s ];

void printVolume(M3 model) {
	println(sum(mapper(toList(classes(model)), countModelLoc)));
}

public list[str] modelLoc(loc file) {
	text = readFile(file);
	textNoComments = removeComments(text);
	textList = splitText(textNoComments);
	return textList;
}

private str removeComments(str text) {
	// Todo: some magic
	return text;
}
