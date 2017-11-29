module main

import IO;

import List;
import Set;
import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import DateTime;

public loc hsqldb = |project://SQLBig|;
public loc smallsql = |project://smallsql|;
public loc library = |project://Library|;

/* Choose the location of the project you want to test. */
public loc project = hsqldb;

public void main() {
	/* Calculate the metrics. */
	model = initModel(project);
}

/* Create m3 model */
public M3 initModel(loc l) {
	println("Loading code.");
	startTime = now();
  	myModel = createM3FromEclipseProject(l);
  	printTimeStep(startTime);
  	return myModel;
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