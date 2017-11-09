module main

import IO;
import List;
import lang::java::m3::Core;
import lang::java::jdt::m3::Core;

public loc hsqldb = |project://SoftwareEvolution_DQ/hsqldb|;
public loc smallsql = |project://SoftwareEvolution_DQ/smallsql|;

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