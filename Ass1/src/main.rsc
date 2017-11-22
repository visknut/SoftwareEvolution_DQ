module main

import IO;

import Set; 
import util::ValueUI;
import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;
import ListRelation;

import volume;
import size;
import complexity;
import duplication;

public loc hsqldb = |project://SQLBig|;
public loc smallsql = |project://smallsql|;
public loc library = |project://Library|;

/* Set the interval for unit size measurement */
list[int] unitSizeInterval = [15, 30, 60];
list[int] unitComplexityInterval = [10, 20, 50];

public void main() {
		
	println("Loading code");
	project = library;
	model = initModel(project);
	
	//println("Calculating Volume:");
	//linesOfCode = calculateVolume(model);
	//println(linesOfCode);
	//
	//println("Calculating Unit Size with interval(<unitSizeInterval>):");
	//unitSize = calculateUnitSize(model, unitSizeInterval);
	//println(unitSize);
	
	println("Calculating Unit complexity with interval(<unitComplexityInterval>):");
	unitComplexity = findUnitComplexity(project, unitComplexityInterval);
	
	println(size(unitComplexity));
	
	//b = size(unitComplexity);
	
	//y = [];
	//n = 0;
	//while (n < (b/2)) {
	//	if(x < 11) y + x[(b/2)+1];
	//	n += 1;
	//}
	//println(y);
	//println("Calculating code duplication:");
	//printDuplication(model);
	
	 //printReport(linesOfCode, unitSize, unitComplexity);
}

public M3 initModel(loc l) {
  myModel = createM3FromEclipseProject(l);
  return myModel;
}

void printReport(int linesOfCode, list[int] unitSize, list[int] unitComplexity){
	println("-----------------------");
	println("|Metric          |Rank|");
	println("|---------------------|");
	println("|Volume          | <rankVolume(linesOfCode)> |");
	println("|Unit Size       | <rankUnitSize(unitSize)>|");	
	println("|Unit Complexity | <rankUnitComplexity(unitComplexity)>|");	
	println("-----------------------");	
}

public str rankVolume(int linesOfCode){
	if(linesOfCode < 66000) return "++";
	if(linesOfCode < 246000) return "+";
	if(linesOfCode < 665000) return "o";
	if(linesOfCode < 1310000) return "-"; 
	else return "--";
}

public str rankUnitSize(list[int] UnitSize){
	
	return "Foo";
}

public str rankUnitComplexity(list[int] unitComplexity){
	return "Foo";
}