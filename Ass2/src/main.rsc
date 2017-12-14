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
	list[nodeStructure] filteredNodes = filterNodes(ast, 6);
	
	/* SuffixTree */
  	suffix = createSuffixTree([]);
  	printTimeStep(startTime);
  	
  	/* Export suffix tree */
  	iprintln(suffix);
  	//iprintToFile(|cwd:///text.txt|, suffix);
}

/* Create ast node */
public set[Declaration] initAst(loc l) {
	set[Declaration] ast = {};
  	  	
	fileLocations = toList(files(createM3FromEclipseProject(l)));	
	for(int n <- [0..size(fileLocations)]) ast += createAstFromFile(fileLocations[n], true); 
	
	return ast;
}
