module size

import lang::java::jdt::m3::Core;
import List;
import Set;
import String;
import IO;
import util::Math;

import cleantext;

public int countModelLoc(loc file) = size(cleanText(file));

public int unitPercentage(list[int] methodsSizeCategory, list[int] methodsSizes) = (100 *  size(methodsSizeCategory))/ size(methodsSizes);

public list[int] calculateUnitSize(M3 model, list[int] unitSizeInterval) {
	methodsSizes = mapper(toList(methods(model)), countModelLoc);
	
	noRisk = unitPercentage([ x | x <- methodsSizes, unitSizeInterval[0] > x], methodsSizes);
	moderateRisk = unitPercentage([ x | x <- methodsSizes, unitSizeInterval[0] <= x, x < unitSizeInterval[1]], methodsSizes);
	highRisk = unitPercentage([ x | x <- methodsSizes, unitSizeInterval[1] <= x, x < unitSizeInterval[2]], methodsSizes);
	veryHighRisk = unitPercentage([ x | x <- methodsSizes, x >= unitSizeInterval[2]], methodsSizes);
	
	return [noRisk, moderateRisk, highRisk, veryHighRisk];
}
