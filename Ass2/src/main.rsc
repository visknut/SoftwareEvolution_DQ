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
//import manipulation::serialization;
import manipulation::serialization2;
import manipulation::nodeFilter;
import detection::createsuffix;

public loc hsqldb = |project://SQLBig|;
public loc smallsql = |project://smallsql0.21_src|;
public loc library = |project://Library|;

/* Choose the location of the project you want to test. */
public loc project = smallsql;

public void main() {
	/* Loading */
	startTime = now();
	ast = initAst(project);
	
	/* Serialization */
	//ast = serializeAst(initAst(project));
	
	/* Structuring and filtering old version*/
	//list[nodeStructure] filteredNodes = filterNodes(ast, 50);
	//text(filteredNodes);
  	
	/* Structuring and filtering new version*/
	//lrel[int code, value location] codeStructure = serializeAst(initAstFile(|project://Ass2/tests/testFile.java|));
	lrel[int code, value location] codeStructure = serializeAst(ast);
	
	//for (code <- codeStructure) {
	//	println(code.code);
	//}

	/* SuffixTree */
	startTime = now();
  	suffix = createSuffixTree(codeStructure);
  	printTimeStep(startTime);
  
  	
  	/* Export suffix tree */
  	exportResult(suffix);
}
