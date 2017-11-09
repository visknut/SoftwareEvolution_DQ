module main

import IO;
import List;
import lang::java::m3::Core;
import lang::java::jdt::m3::Core;

public loc hsqldb = |project://SQLBig|;
public loc smallsql = |project://smallsql|;
public loc ltest = |project://Library|;

public void main() {
	init(ltest);
}

void init(loc l) {
  myModel = createM3FromEclipseProject(l);
  iprintln(methods(myModel));
  println("Initialized project: <l>");
} 

void printVolume(loc l) {
	iprintln("Placeholder");
}

void printUnitSize(loc l) {
	iprintln("Placeholder");
}

void printUnitComplexity(loc l) {
	iprintln("Placeholder");
}

void printDuplication(loc l) {
	iprintln("Placeholder");
}