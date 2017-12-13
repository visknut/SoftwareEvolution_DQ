module main

import IO;
import List;
import Set;
import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::m3::AST;
import DateTime;
import util::ValueUI;

import serialization;
import createsuffix;

public loc hsqldb = |project://SQLBig|;
public loc smallsql = |project://smallsql|;
public loc library = |project://Library|;

/* main dataTypes */
alias mainMap = tuple[map(int someInt, str someString), list[tuple[int someInt, loc someLoc]]];   

/* Choose the location of the project you want to test. */
public loc project = library;

public void main() {
	startTime = now();
	
	/* Serialization */
	ast = serializeAst(initAst(project));
	
	/* SuffixTree */
  	suffix = createSuffixTree([]);
  	printTimeStep(startTime);
}

/* Create ast node */
public set[node] initAst(loc l) {
	set[node] ast = {};
  	  	
	fileLocations = toList(files(createM3FromEclipseProject(l)));	
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
