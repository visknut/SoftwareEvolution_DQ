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

/* Set the max length of a unit. */
int maxUnitLength = 30;

public void main() {
	model = initModel(libary);
	
	println("Calculating Volume:");
	linesOfCode = calculateVolume(model);
	println(linesOfCode);

	println("Calculating Unit Size:");
	unitSize = calculateUnitSize(model, maxUnitLength);
	println(unitSize);
	
	//println("Calculating Unit complexity:");
	//iprintln(findComplexFiles(|project://Library/|));
	
	//println("Calculating code duplication:");
	//printDuplication(model);
	
	printReport(linesOfCode);
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
	println("|Unit Size   | <rankVolume(linesOfCode)> |");	
	println("-------------------");	
}

public str rankVolume(int linesOfCode){
	if(linesOfCode < 66000) return "++";
	if(linesOfCode < 246000) return "+";
	if(linesOfCode < 665000) return "o";
	if(linesOfCode < 1310000) return "-"; 
	else return "--";
}