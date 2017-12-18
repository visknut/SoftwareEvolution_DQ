module main

import IO;
import List;
import Set;
import Node;
import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::m3::AST;
import util::ValueUI;
import DateTime;

import util::time;
import util::loading;
import util::jsonExporter;
import manipulation::serialization2;
import detection::createsuffix3;

public loc hsqldb = |project://hsqldb-2.3.1|;
public loc smallsql = |project://smallsql0.21_src|;
public loc bigsql = |project://SQLBig|;
public loc smallsql2 = |project://smallsql|;
public loc library = |project://Library|;

/* Runners for the different projects */
public void run_library() {
	main(library, 10);
}

public void run_smallsql() {
	main(smallsql, 50);
}

public void run_bigsql() {
	main(bigsql, 100);
}

/* Main Function to detect duplicates and export it to json */
public void main(loc project, int tresh) {
	str projectName = project.uri[10..];
	int treshold = tresh;

	/* Loading */
	startTime = now();
	println("Loading AST for <projectName>");
	ast = initAst(project);
	printTimeStep(startTime);
	
	/* Serialization */
	startTime = now();
	println("Serializing code");
	//lrel[int code, value location] codeStructure = serializeAst(initAstFile(|project://Ass2/tests/testFile.java|));
	lrel[int code, value location] codeStructure = serializeAst(ast);
	codeStructure += [<0, |empty:///|>];
	printTimeStep(startTime);

	println(codeStructure);
	
	/* SuffixTree */
	startTime = now();
	println("Creating a suffix tree.");
  	suffix = createSuffixTree(codeStructure);
  	printTimeStep(startTime);
	/* Fill suffix tree with info for visuals. */
	suffix = getLeafLength(suffix);
	suffix = filterSuffix(suffix, 0, treshold);
	suffix = getLeafLocations(codeStructure, suffix);
  
	for (sxnode <- suffix) {
		println(sxnode);
	}
	
  	/* Export suffix tree */
  	startTime = now();
	println("Export suffix tree.");
	exportResult(suffix, project, projectName);
  	printTimeStep(startTime);
}
