module main

import IO;

import Set;
import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import DateTime;

import volume;
import size;
import List;
import complexity;
import duplication;
import ranking;

public loc hsqldb = |project://SQLBig|;
public loc smallsql = |project://smallsql|;
public loc library = |project://Library|;

/* Choose the location of the project you want to test. */
public loc project = smallsql;

/* Set the interval for unit size measurement */
list[int] unitSizeInterval = [15, 30, 60];
list[int] unitComplexityInterval = [10, 20, 50];

public void main() {
	/* Declare all variables in case you don't want to test for all of the metrics. */
	linesOfCode = 0;
	unitSize = [0.0, 0.0, 0.0, 0.0];
	complexity = [0.0, 0.0, 0.0];
	duplication = 0;

	/* Calculate the metrics. */
	model = initModel(project);
	linesOfCode = startVolume(model);
	unitSize = startUnitSize(model);
	complexity = startComplexity(project, linesOfCode);
	duplication = startDuplication(model, linesOfCode);
	
	/* Print the results. */
	printReport(linesOfCode, unitSize, complexity, duplication);
}

/* Create m3 model */
public M3 initModel(loc l) {
	println("Loading code.");
	startTime = now();
  	myModel = createM3FromEclipseProject(l);
  	printTimeStep(startTime);
  	return myModel;
}

/* Calculate volume. */
int startVolume(M3 model) {
	print("Calculating Volume: ");
	startTime = now();
	linesOfCode = calculateVolume(model);
	print(linesOfCode);
	println(" LOC");
	printTimeStep(startTime);
	return linesOfCode;
}

/* Calculate unit size. */
list[real] startUnitSize(M3 model) {
	println("Calculating Unit Size with interval(<unitSizeInterval>): ");
	startTime = now();
	unitSize = calculateUnitSize(model, unitSizeInterval);
	println(unitSize);
	printTimeStep(startTime);
	return unitSize;
}

/* Calculate complexity. */
list[real] startComplexity(loc project, int linesOfCode) {
	println("Calculating Unit complexity with interval(<unitComplexityInterval>):");
	startTime = now();
	complexity = complexityBins(project, unitComplexityInterval, linesOfCode);
	println("Moderate: <complexity[0]>% | High: <complexity[1]>% | Very high <complexity[2]>%.");
	printTimeStep(startTime);
	return complexity;
}

/* Calculate duplication. */
real startDuplication(M3 model, int linesOfCode) {
	print("Calculating code duplication: ");
	startTime = now();
	duplication = (((printDuplication(model)) * 1.0) / linesOfCode) * 100;
	print(duplication);
	println("% of the code.");
	printTimeStep(startTime);
	return duplication;
}

/* Print how long a step took */
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