module volume

import lang::java::jdt::m3::Core;
import List;
import Set;
import String;
import IO;
import util::Math;

import cleantext;

public int countModelLoc(loc file) = size(cleanText(file));

public int calculateVolume(M3 model) {
	return sum(mapper(toList(classes(model)), countModelLoc)); // 'classes' does not entail all code, 'declarations' should be used.
}
