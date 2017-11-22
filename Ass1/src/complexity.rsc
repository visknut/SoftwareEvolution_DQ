module complexity

import lang::java::jdt::m3::Core;
import List;
import Set;
import Type;
import String;
import IO;
import util::Math;
import lang::java::\syntax::Java15;
import Exception;
import ParseTree;
import util::FileSystem;
import lang::java::\syntax::Disambiguate;

import cleantext;

// Code from rascasl website, metrics example
// http://www.rascal-mpl.org/#_Metrics
int cyclomaticComplexity(MethodDec model) {
	result = 1;
	visit (model) {
		//case (Stm)`<Expr _> ? <Stm _> : <Stm _>` : result += 1;
		case (Stm)`do <Stm _> while (<Expr _>);`: result += 1;
		case (Stm)`while (<Expr _>) <Stm _>`: result += 1;
		case (Stm)`if (<Expr _>) <Stm _>`: result +=1;
		case (Stm)`if (<Expr _>) <Stm _> else <Stm _>`: result +=1;
		case (Stm)`for (<{Expr ","}* _>; <Expr? _>; <{Expr ","}*_>) <Stm _>` : result += 1;
		case (Stm)`for (<LocalVarDec _> ; <Expr? e> ; <{Expr ","}* _>) <Stm _>`: result += 1;
		case (Stm)`for (<FormalParam _> : <Expr _>) <Stm _>` : result += 1;
		case (Stm)`switch (<Expr _> ) <SwitchBlock _>`: result += 1;
		case (SwitchLabel)`case <Expr _> :` : result += 1;
		case (CatchClause)`catch (<FormalParam _>) <Block _>` : result += 1;
		case (Expr)`<Expr _> && <Expr _>`: result += 1;
		case (Expr)`<Expr _> || <Expr _>`: result += 1;
	}
	return result;
}

list[list[int codeComplexity]] findUnitComplexity(loc project, list[int] codeComplexityInterval) {
  return [[*codeComplexity(f) | /file(f) <- crawl(project), f.extension == "java"],
  [*codeComplexityVolume(f) | /file(f) <- crawl(project), f.extension == "java"]];
}

set[MethodDec] allMethods(loc file) = {m | /MethodDec m := parse(#start[CompilationUnit], file)};

list[int cc] codeComplexity(loc file) = [cyclomaticComplexity(m) | m <- allMethods(file)];
list[int methodVolume] codeComplexityVolume(loc file) = [size(cleanText(m@\loc)) | m <- allMethods(file)];

list[real] complexityBins(loc project, list[int] codeComplexityInterval, int linesOfCode) {
	complexityResult = findUnitComplexity(project, codeComplexityInterval);
	unitComplexity = complexityResult[0];
	unitLength = [(x/(linesOfCode * 1.0)) * 100 | x <- complexityResult[1]];
	
	relativeComplexity = [0.0,0.0,0.0];
	
	for (int i <- [0 .. size(unitComplexity)]) {
		if (unitComplexity[i] > 50) {
			relativeComplexity[2] += unitLength[i];
		} else if (unitComplexity[i] > 20){
			relativeComplexity[1] += unitLength[i];
		} else if (unitComplexity[i] > 10) {
			relativeComplexity[0] += unitLength[i];
		}
	}
	
	return relativeComplexity;
}