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
import manipulation::serialization2;
import manipulation::nodeFilter;
import detection::createsuffix2;

public loc hsqldb = |project://SQLBig|;
public loc smallsql = |project://smallsql|;
public loc library = |project://Library|;

/* Choose the location of the project you want to test. */
public loc project = library;

public void main() {
	/* Loading */
	startTime = now();
	println("Loading AST");
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
  
  	println(suffix);
  	/* Export suffix tree */
  	startTime = now();
	println("Export suffix tree.");
  	printTimeStep(startTime);
}
