module main

import IO;
import List;
import lang::java::m3::Core;
import lang::java::jdt::m3::Core;

public loc hsqldb = |project://SQLBig|;
public loc smallsql = |project://smallsql|;

public void main() {
	init(hsqldb);
}

void init(loc l) {
  createM3FromEclipseProject(l);
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