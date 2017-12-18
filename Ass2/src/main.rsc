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
	//lrel[int code, value location] codeStructure = serializeAst(initAstFile(|project://Ass2/tests/testFile.java|));
	//lrel[int code, value location] codeStructure = serializeAst(ast);
	printTimeStep(startTime);
	//for (sxnode <- codeStructure) {
	//	println(sxnode);
	//}  

	/* SuffixTree */
	startTime = now();
	println("Creating a suffix tree.");
  	suffix = createSuffixTree([]);
  	printTimeStep(startTime);

	suffix = getLeafLength(suffix);
	//suffix = filterSuffix(suffix);
	//suffix = getLeafLocations(codeStructure, suffix);
  
	for (sxnode <- suffix) {
		println(sxnode);
	}

  	/* Export suffix tree */
  	startTime = now();
	println("Export suffix tree.");
	exportResult(suffix, project, projectName);
  	printTimeStep(startTime);
}
