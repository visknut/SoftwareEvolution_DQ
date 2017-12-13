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

public loc hsqldb = |project://SQLBig|;
public loc smallsql = |project://smallsql|;
public loc library = |project://Library|;

/* main dataTypes */
alias mainMap = tuple[map(int someInt, str someString), list[tuple[int someInt, loc someLoc]]];   

/* Choose the location of the project you want to test. */
public loc project = library;

public void main() {
	ast = initAst(project);
	serializeAst(ast);
}

/* Create ast node */
public set[node] initAst(loc l) {
	set[node] ast = {};
  	  	
	fileLocations = toList(files(createM3FromEclipseProject(l)));	
	for(int n <- [0..size(fileLocations)]) ast += createAstFromFile(fileLocations[n], true);
	
	return ast;
}
