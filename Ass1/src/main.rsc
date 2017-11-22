module main

import IO;

import Set; 
import util::ValueUI;
import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;

import volume;
import size;
import complexity;
import duplication;
import DateTime;

public loc hsqldb = |project://SQLBig|;
public loc smallsql = |project://smallsql|;
public loc library = |project://Library|;

/* Set the interval for unit size measurement */
list[int] unitSizeInterval = [15, 30, 60];
list[int] unitComplexityInterval = [10, 20, 50];

public void main() {
	project = smallsql;
	startTime = now();

	println("Loading code: ");
	model = initModel(project);
	printTimeStep(startTime);
	
	print("Calculating Volume:");
	linesOfCode = calculateVolume(model);
	print(linesOfCode);
	println(" LOC");
	printTimeStep(startTime);
	
//	println("Calculating Unit Size with interval(<unitSizeInterval>):");
//	unitSize = calculateUnitSize(model, unitSizeInterval);
//	println(unitSize);
//	printTimeStep(startTime);
//	println("Calculating Unit complexity with interval(<unitComplexityInterval>):");
//	unitComplexity = findUnitComplexity(project, unitComplexityInterval);
//
//	println(unitComplexity);
//  printTimeStep(startTime);

	println("Calculating code duplication: ");
	print(linesOfCode / printDuplication(model) * 100);
	println("% of the code.");
	printTimeStep(startTime);
	
	//printReport(linesOfCode, unitSize, unitComplexity);
	
}

public M3 initModel(loc l) {
  myModel = createM3FromEclipseProject(l);
  return myModel;
}

void printReport(int linesOfCode, int unitSize, int unitComplexity){
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

public str rankUnitSize(int UnitSize){
	return "Foo";
}

public void printTimeStep(datetime startTime) {
	print("This step took: ");
	if ((now() - startTime).hours > 0) {
		print((now() - startTime).hours);
		print("h");
	}
	if ((now() - startTime).minutes > 0) {
		print((now() - startTime).minutes);
		print("m");
	}
	print((now() - startTime).seconds);
	print("s");
	print((now() - startTime).milliseconds);
	println("ms.\n");
}