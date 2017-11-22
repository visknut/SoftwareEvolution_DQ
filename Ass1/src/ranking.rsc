module ranking

import IO;

public void printReport(int linesOfCode, list[real] unitSize, list[real] unitComplexity, int duplication) {
	println("-----------------------");
	println("|Metric          |Rank|");
	println("|---------------------|");
	println("|Volume          | <rankVolume(linesOfCode)> |");
	println("|Unit Size       | <rankUnitSize(unitSize)> |");	
	println("|Unit Complexity | <rankUnitComplexity(unitComplexity)> |");
	println("|Duplication     | <rankDuplication(duplication)> |");	
	println("-----------------------");	
}

str rankVolume(int linesOfCode){
	if(linesOfCode < 66000) return "++";
	if(linesOfCode < 246000) return " +";
	if(linesOfCode < 665000) return " o";
	if(linesOfCode < 1310000) return " -"; 
	else return "--";
}

str rankUnitSize(list[real] unitSize){
	if (unitSize[3] > 10.0 || unitSize[2] > 40.0 || unitSize[1] > 60.0) return "--";
	if (unitSize[3] > 5.0 || unitSize[2] > 30.0 || unitSize[1] > 50.0) return " -";
	if (unitSize[3] > 0.0 || unitSize[2] > 2.0 || unitSize[1] > 40.0) return " o";
	if (unitSize[2] > 5.0 || unitSize[1] > 25.0) return " +";
	return "++";
}

str rankUnitComplexity(list[real] unitComplexity){
	if (unitComplexity[2] > 5.0 || unitComplexity[1] > 15.0 || unitComplexity[0] > 50.0) return "--";
	if (unitComplexity[2] > 0.0 || unitComplexity[1] > 10.0 || unitComplexity[0] > 40.0) return " -";
	if (unitComplexity[1] > 5.0 || unitComplexity[0] > 30.0) return " o";
	if (unitComplexity[0] > 25.0) return " +";
	return "++";
}

str rankDuplication(int duplication){
	if(duplication < 3) return "++";
	if(duplication < 5) return " +";
	if(duplication < 10) return " o";
	if(duplication < 20) return " -"; 
	return "--";
}