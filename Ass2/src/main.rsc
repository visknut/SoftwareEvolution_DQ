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
import manipulation::nodeFilter;
import detection::createsuffix2;

public loc bigsql = |project://SQLBig|;
public loc smallsql = |project://smallsql|;
public loc library = |project://Library|;

/* Runners for the different projects */
public void run_library() {
	main(library);
}

public void run_smallsql() {
	main(smallsql);
}

public void run_bigsql() {
	main(bigsql);
}

/* Main Function to detect duplicates and export it to json */
public void main(loc project) {
	str projectName = project.uri[10..];

	/* Loading */
	startTime = now();
	println("Loading AST for <projectName>");
	ast = initAst(project);
	printTimeStep(startTime);
	
	/* Serialization */
	startTime = now();
	println("Serializing code");
	lrel[int code, value location] codeStructure = serializeAst(initAstFile(|project://Ass2/tests/testFile.java|));
	//lrel[int code, value location] codeStructure = serializeAst(ast);
	printTimeStep(startTime);

	/* SuffixTree */
	startTime = now();
	println("Creating a suffix tree.");
  	suffix = createSuffixTree(codeStructure);
  	printTimeStep(startTime);
  
  	/* Export suffix tree */
  	startTime = now();
	println("Export suffix tree.");
	exportResult(suffix, project, projectName);
  	printTimeStep(startTime);
}
