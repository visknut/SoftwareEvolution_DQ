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
import detection::createsuffix;
import detection::fillsuffix;
//import tests::main_test;

public loc smallsql = |project://smallsql|;
public loc bigsql = |project://bigsql|;
public loc library = |project://Library|;

/* Runners for the different projects */
public void run_library(int duplicationType) {
	main(library, 2000, duplicationType);
}

public void run_smallsql(int duplicationType) {
	main(smallsql, 50000, duplicationType);
}

public void run_bigsql(int duplicationType) {
	main(bigsql, 100, duplicationType);
}

public void run_tests() {
	main_tests();
}

/* Main Function to detect duplicates and export it to json */
public void main(loc project, int treshold, int duplicationType) {
	str projectName = project.uri[10..];

	/* Loading */
	startTime = now();
	println("Loading AST for <projectName>");
	ast = initAst(project);
	printTimeStep(startTime);
	
	/* Serialization */
	startTime = now();
	println("Serializing code");
	lrel[int code, value location] codeStructure = serializeAst(ast);
	text(codeStructure);
	printTimeStep(startTime);
	
	//lrel[int code, value location] codeStructure = serializeAst(initAstFile(|project://Ass2/tests/testFile.java|));

	/* SuffixTree */
	startTime = now();
	println("Creating a suffix tree.");
  	suffix = createSuffixTree(codeStructure);
  	printTimeStep(startTime);
	/* Fill suffix tree with info for visuals. */
	startTime = now();
	
	/* Add suffixTree visualization info */
	println("Filling suffix tree with info for visuals.");
	suffix = getLeafLength(suffix);
	suffix = filterSuffix(suffix, treshold);

	//suffix = reverse(suffix);
	//suffix = fixIds(suffix);
	//suffix = smoothOutEdges(suffix);
	suffix = getLeafLocations(codeStructure, suffix);
	printTimeStep(startTime);
	
  	/* Export suffix tree */
  	startTime = now();
	println("Export suffix tree.");
	exportResult(suffix, project, projectName);
  	printTimeStep(startTime);
}