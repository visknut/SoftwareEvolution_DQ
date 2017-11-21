module size

import lang::java::jdt::m3::Core;
import List;
import Set;
import String;
import IO;
import util::Math;

import cleantext;

public int countModelLoc(loc file) = size(cleanText(file));

int calculateUnitSize(M3 model, int maxUnitLength) {
	methodsSizes = mapper(toList(methods(model)), countModelLoc);
	methodsTooLarge = [ x | x <- methodsSizes, x > maxUnitLength];
	UnitPercentage = (100 *  size(methodsTooLarge))/ size(methodsSizes);
	println("<UnitPercentage>% of the units are over <maxUnitLength> lines long.");
	return UnitPercentage;
}