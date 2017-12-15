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
import manipulation::serialization;
import manipulation::nodeFilter;
import detection::createsuffix;

public loc hsqldb = |project://SQLBig|;
public loc smallsql = |project://smallsql|;
public loc library = |project://Library|;

/* Choose the location of the project you want to test. */
public loc project = library;

public void main() {
	startTime = now();
	
	/* Serialization */
	ast = serializeAst(initAst(project));
	
	/* Structuring and filtering */
	list[nodeStructure] filteredNodes = filterNodes(ast, 50);
	text(filteredNodes);

	/* SuffixTree */
  	//suffix = createSuffixTree([]);
  	
  	/* Export suffix tree */
  	//iprintln(suffix);
  	
  	printTimeStep(startTime);
}
