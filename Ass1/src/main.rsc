module main

import IO;
import List;
import Set; 
import util::ValueUI;
import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;

import volume;
import size;
import complexity;
import duplication;

public loc hsqldb = |project://SQLBig|;
public loc smallsql = |project://smallsql|;
public loc libary = |project://Library|;

/* Set the interval for unit size measurement */
list[int] unitSizeInterval = [15, 30, 60];
list[int] unitComplexityInterval = [10, 20, 50];

public void main() {
	model = initModel(libary);
	
	println("Calculating Volume:");
	linesOfCode = calculateVolume(model);
	println(linesOfCode);

	println("Calculating Unit Size with interval(<unitSizeInterval>):");
	unitSize = calculateUnitSize(model, unitSizeInterval);
	println(unitSize);
	
	println("Calculating Unit complexity:");
	unitComplexity = findUnitComplexity(libary, unitComplexityInterval);
	println(unitComplexity);
	
	println("Calculating code duplication:");
	printDuplication(model);
	
	// printReport(linesOfCode);
}

public M3 initModel(loc l) {
  myModel = createM3FromEclipseProject(l);
  return myModel;
}

void printReport(int linesOfCode){
	println("-------------------");
	println("|Metric      |Rank|");
	println("|-----------------|");
	println("|Volume      | <rankVolume(linesOfCode)> |");
	println("|Unit Size   | <rankUnitSize(linesOfCode)>|");	
	println("-------------------");	
}

public str rankVolume(int linesOfCode){
	if(linesOfCode < 66000) return "++";
	if(linesOfCode < 246000) return "+";
	if(linesOfCode < 665000) return "o";
	if(linesOfCode < 1310000) return "-"; 
	else return "--";
}

public str rankUnitSize(int UnitSize){
	return "Foo";
}