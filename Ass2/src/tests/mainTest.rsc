module tests::mainTest

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
import manipulation::serialization2;
import detection::createsuffix;
import detection::fillsuffix;
import tests::main_test;

public void mainTests(){
	test1();
	//test2();
	//|project://Ass2/tests/testFile.java|
}

public string test1(){
	createSuffixTree([<1, |empty:///|> ,<2, |empty:///|>, <3, |empty:///|>, 
		<1, |empty:///|>, <2, |empty:///|>, <4, |empty:///|>,
		<1, |empty:///|>, <2, |empty:///|>, <3, |empty:///|>, <5, |empty:///|>, <-1, |empty:///|>]);
}