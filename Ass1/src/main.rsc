module main

import IO;
import List;
import Set; 
import util::ValueUI;
import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;

import volume;
import size;
import complexity;
import duplication;

public loc hsqldb = |project://SQLBig|;
public loc smallsql = |project://smallsql|;
public loc libary = |project://Library|;

/* Set the max length of a unit. */
int maxUnitLength = 30;

public void main() {
	model = initModel(libary);
	
	println("Calculating Volume:");
	printVolume(model);

	println("Calculating Unit Size:");
	printSize(model, maxUnitLength);
	
	println("Calculating Unit complexity:");
	printComplexity(model);
	
	println("Calculating dode duplication:");
	printDuplication(model);
}

public M3 initModel(loc l) {
  myModel = createM3FromEclipseProject(l);
  return myModel;
}
