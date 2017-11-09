module main

import IO;
import List;
import Set; 
import util::ValueUI;
import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::jdt::m3::AST;

import volume;

public loc hsqldb = |project://SQLBig|;
public loc smallsql = |project://smallsql|;
public loc libary = |project://Library|;

public void main() {
	model = initModel(libary);
	
	println("Calculating Volume:");
	printVolume(model);

	println("Calculating Unit Size:");
}

public M3 initModel(loc l) {
  myModel = createM3FromEclipseProject(l);
  return myModel;
} 
