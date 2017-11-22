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

// Inspired by rascal website, metrics example:
int cyclomaticComplexity(MethodDec model) {
	result = 1;
	visit (model) {
		case (Stm)`<Expr _> ? <Stm _> : <Stm _>`: result += 1;
		case (Expr)`<Expr _> && <Expr _>`: result += 1;
		case (Expr)`<Expr _> || <Expr _>`: result += 1;
		case (Stm)`do <Stm _> while (<Expr _>);`: result += 1;
		case (Stm)`while (<Expr _>) <Stm _>`: result += 1;
		case (Stm)`if (<Expr _>) <Stm _>`: result +=1;
		case (Stm)`if (<Expr _>) <Stm _> else <Stm _>`: result +=1;
		case (Stm)`for (<{Expr ","}* _>; <Expr? _>; <{Expr ","}*_>) <Stm _>` : result += 1;
		case (Stm)`for (<LocalVarDec _> ; <Expr? e> ; <{Expr ","}* _>) <Stm _>`: result += 1;
		case (Stm)`for (<FormalParam _> : <Expr _>) <Stm _>` : result += 1;
		//case (Stm)`switch (<Expr _> ) <SwitchBlock _>`: result += 1;
		case (SwitchLabel)`case <Expr _> :` : result += 1;
		case (CatchClause)`catch (<FormalParam _>) <Block _>` : result += 1;
	}
	return result;
}

lrel[int cc, loc method] findUnitComplexity(loc project, list[int] codeComplexityInterval) {
  result = [*maxCC(f) | /file(f) <- crawl(project), f.extension == "java"];	
  result = sort(result, bool (<int a, loc _>, <int b, loc _>) { return a < b; });
  
  unitComplexity = [];
  
  for(int n <- [0..(size(result))]) println("n = <result[n].cc>"); //push(result[n].cc, unitComplexity)
     
  return result; 
}

set[MethodDec] allMethods(loc file) = {m | /MethodDec m := parse(#start[CompilationUnit], file)};

lrel[int cc, loc method] maxCC(loc file) = [<cyclomaticComplexity(m), m@\loc> | m <- allMethods(file)];
