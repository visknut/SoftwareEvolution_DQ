module main

import IO;
//import test123;
import List;
import Set;
import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::m3::AST;
import DateTime;
import util::ValueUI;

import createsuffix;

public loc hsqldb = |project://SQLBig|;
public loc smallsql = |project://smallsql|;
public loc library = |project://Library|;

/* Choose the location of the project you want to test. */
public loc project = library;

public void main() {
	/* Calculate the metrics. */
	
	startTime = now();
  	suffix = createSuffixTree([]);
  	printTimeStep(startTime);
  	
	//model = initModel(project);
	//ast = initAst(model);
	//text(ast);
}

/* Create m3 model */
public M3 initModel(loc l) {
	println("Loading code.");

  	model = createM3FromEclipseProject(l);
	
  	return model;
}

/* Create ast set */
public set[Declaration] initAst(M3 model) {
	set[Declaration] ast = {};

	fileLocations = toList(files(model));	
	for(int n <- [0..size(fileLocations)]) ast += createAstFromFile(fileLocations[n], true);
	
	return ast;
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