module util::loading

import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::m3::AST;
import List;
import IO;
import Set;

/* Create ast node */
public set[Declaration] initAst(loc l) {
	set[Declaration] ast = {};
  	  	
	fileLocations = toList(files(createM3FromEclipseProject(l)));	
	for(int n <- [0..size(fileLocations)]) ast += createAstFromFile(fileLocations[n], true); 
	
	return ast;
}