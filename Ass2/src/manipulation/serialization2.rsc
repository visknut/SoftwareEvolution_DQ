module manipulation::serialization2

import IO;
import lang::java::m3::Core;
import lang::java::jdt::m3::AST;
import lang::java::jdt::m3::Core;
import List;
import Map;
import Set;
import Node;
import util::ValueUI;

private list[&T] emptyList(type[&T] _) = [];

lrel[int code, value location] serializeAst(set[Declaration] projectAst) {
	return traverseNodes(projectAst);
}

lrel[int code, value location] traverseNodes(set[Declaration] ast) {
	lrel[int code, value location] ids = [];
	for (x <- ast) {
		ids += serialize(x);
	}
	return ids;
}

lrel[int code, value location] serialize(node x) {
	list[int] ids = [];
	lrel[int code, value location] cS = [];
	
	visit(x) {
		
		/* Declarations. */
	    case \compilationUnit(list[Declaration] imports, list[Declaration] types): 										ids += 1;
	    case \compilationUnit(Declaration package, list[Declaration] imports, list[Declaration] types): 				ids += 2;
	    case \enum(str name, list[Type] implements, list[Declaration] constants, list[Declaration] body): 				ids += 3;
	    case \enumConstant(str name, list[Expression] arguments, Declaration class): 									ids += 4;
	    case \enumConstant(str name, list[Expression] arguments): 														ids += 5;
	    case \class(str name, list[Type] extends, list[Type] implements, list[Declaration] body): 						ids += 6;
	    case \class(list[Declaration] body): 																			ids += 7;
	    case \interface(str name, list[Type] extends, list[Type] implements, list[Declaration] body): 					ids += 8;
	    case \field(Type \type, list[Expression] fragments): 															ids += 9;
	    case \initializer(Statement initializerBody): 																	ids += 10;
	    case \method(Type \return, str name, list[Declaration] parameters, list[Expression] exceptions, Statement impl):ids += 11;
	    case \method(Type \return, str name, list[Declaration] parameters, list[Expression] exceptions): 				ids += 12;
	    case \constructor(str name, list[Declaration] parameters, list[Expression] exceptions, Statement impl): 		ids += 13;
	    case \import(str name): 																						ids += 14;
	    case \package(str name): 																						ids += 15;
	    case \package(Declaration parentPackage, str name): 															ids += 16;
	    case \variables(Type \type, list[Expression] \fragments): 														ids += 17;
	    case \typeParameter(str name, list[Type] extendsList): 															ids += 18;
	    case \annotationType(str name, list[Declaration] body): 														ids += 19;
	    case \annotationTypeMember(Type \type, str name): 																ids += 20;
	    case \annotationTypeMember(Type \type, str name, Expression defaultBlock): 										ids += 21;
	    // initializers missing in parameter, is it needed in vararg?
	    case \parameter(Type \type, str name, int extraDimensions): 													ids += 22;
	    case \vararg(Type \type, str name): 																			ids += 23;
	
	
		///* Expression */
	    case \arrayAccess(Expression array, Expression index): 															ids += 24;
	    case \newArray(Type \type, list[Expression] dimensions, Expression init): 										ids += 25;
	    case \newArray(Type \type, list[Expression] dimensions): 														ids += 26;
	    case \arrayInitializer(list[Expression] elements): 																ids += 27;
	    case \assignment(Expression lhs, str operator, Expression rhs): 												ids += 28;
	    case \cast(Type \type, Expression expression): 																	ids += 29;
	    case \characterLiteral(str charValue): 																			ids += 30;
	    case \newObject(Expression expr, Type \type, list[Expression] args, Declaration class): 						ids += 31;
	    case \newObject(Expression expr, Type \type, list[Expression] args): 											ids += 32;
	    case \newObject(Type \type, list[Expression] args, Declaration class): 											ids += 33;
	    case \newObject(Type \type, list[Expression] args): 															ids += 34;
	    case \qualifiedName(Expression qualifier, Expression expression): 												ids += 35;
	    case \conditional(Expression expression, Expression thenBranch, Expression elseBranch): 						ids += 36;
	    case \fieldAccess(bool isSuper, Expression expression, str name): 												ids += 37;
	    case \fieldAccess(bool isSuper, str name): 																		ids += 38;
	    case \instanceof(Expression leftSide, Type rightSide): 															ids += 39;
	    case \methodCall(bool isSuper, str name, list[Expression] arguments): 											ids += 40;
	    case \methodCall(bool isSuper, Expression receiver, str name, list[Expression] arguments): 						ids += 41;
	    case \null():																									ids += 42;
	    case \number(str numberValue):																					ids += 43;
	    case \booleanLiteral(bool boolValue):																			ids += 44;
	    case \stringLiteral(str stringValue):																			ids += 45;
	    case \type(Type \type):																							ids += 46;
	    case \variable(str name, int extraDimensions):																	ids += 47;
	    case \variable(str name, int extraDimensions, Expression \initializer):											ids += 48;
	    case \bracket(Expression expression):																			ids += 49;
	    case \this():																									ids += 50;
	    case \this(Expression thisExpression):																			ids += 51;
	    case \super():																									ids += 52;
	    case \declarationExpression(Declaration declaration):															ids += 53;
	    case \infix(Expression lhs, str operator, Expression rhs):														ids += 54;
	    case \postfix(Expression operand, str operator):																ids += 55;
	    case \prefix(str operator, Expression operand):																	ids += 56;
	    case \simpleName(str name):																						ids += 57;
	    case \markerAnnotation(str typeName):																			ids += 58;
	    case \normalAnnotation(str typeName, list[Expression] memberValuePairs):										ids += 59;
	    case \memberValuePair(str name, Expression \value): 															ids += 60;          
	    case \singleMemberAnnotation(str typeName, Expression \value):													ids += 61;                     
	  
		/* Statement */             
	    case \assert(Expression expression):																			ids += 62;
	    case \assert(Expression expression, Expression message):														ids += 63;
	    case \block(list[Statement] statements):																		ids += 64;
	    case \break():																									ids += 65;
	    case \break(str label):																							ids += 66;
	    case \continue():																								ids += 67;
	    case \continue(str label):																						ids += 68;
	    case \do(Statement body, Expression condition):																	ids += 69;
	    case \empty():																									ids += 70;
	    case \foreach(Declaration parameter, Expression collection, Statement body):									ids += 71;
	    case \for(list[Expression] initializers, Expression condition, list[Expression] updaters, Statement body):		ids += 72;
	    case \for(list[Expression] initializers, list[Expression] updaters, Statement body):							ids += 73;
	    case \if(Expression condition, Statement thenBranch):															ids += 74;
	    case \if(Expression condition, Statement thenBranch, Statement elseBranch):										ids += 75;
	    case \label(str name, Statement body):																			ids += 76;
	    case \return(Expression expression):																			ids += 77;
	    case \return():																									ids += 78;
	    case \switch(Expression expression, list[Statement] statements):												ids += 79;
	    case \case(Expression expression):																				ids += 80;
	    case \defaultCase():																							ids += 81;
	    case \synchronizedStatement(Expression lock, Statement body):													ids += 82;
	    case \throw(Expression expression):																				ids += 83;
	    case \try(Statement body, list[Statement] catchClauses):														ids += 84;
	    case \try(Statement body, list[Statement] catchClauses, Statement \finally):									ids += 85;                                     
	    case \catch(Declaration exception, Statement body):																ids += 86;
	    case \declarationStatement(Declaration declaration):															ids += 87;
	    case \while(Expression condition, Statement body):																ids += 88;
	    case \expressionStatement(Expression stmt):																		ids += 89;
	    case \constructorCall(bool isSuper, Expression expr, list[Expression] arguments):								ids += 90;
	    case \constructorCall(bool isSuper, list[Expression] arguments):												ids += 91;
	  
		///* Types */
	 //   case arrayType(Type \type):																						ids += 92;
	 //   case parameterizedType(Type \type):																				ids += 93;
	 //   case qualifiedType(Type qualifier, Expression simpleName):														ids += 94;
	 //   case simpleType(Expression typeName):																			ids += 95;
	 //   case unionType(list[Type] types):																				ids += 96;
	 //   case wildcard():																								ids += 97;
	 //   case upperbound(Type \type):																					ids += 98;
	 //   case lowerbound(Type \type):																					ids += 99;
	 //   case \int():																									ids += 100;
	 //   case short():																									ids += 101;
	 //   case long():																									ids += 102;
	 //   case float():																									ids += 103;
	 //   case double():																									ids += 104;
	 //   case char():																									ids += 105;
	 //   case string():																									ids += 106;
	 //   case byte():																									ids += 107;
	 //   case \void():																									ids += 108;
	 //   case \boolean():																								ids += 109;
	 //
	 //   /* Modifiers */
	 //   case \private():																								ids += 110;
	 //   case \public():																									ids += 111;
	 //   case \protected():																								ids += 112;
	 //   case \friendly():																								ids += 113;
	 //   case \static():																									ids += 114;
	 //   case \final():																									ids += 115;
	 //   case \synchronized():																							ids += 116;
	 //   case \transient():																								ids += 117;
	 //   case \abstract():																								ids += 118;
	 //   case \native():																									ids += 119;
	 //   case \volatile():																								ids += 120;
	 //   case \strictfp():																								ids += 121;
	 //   case \annotation(Expression \anno):																				ids += 122;
	 //   case \onDemand():																								ids += 123;
	 //   case \default():																								ids += 124;
	}
	
	visit(x) {
		case Declaration d: 	{cS += [<head(ids), d.src>]; ids = tail(ids);}
		case Expression e: 		{cS += [<head(ids), e.src>]; ids = tail(ids);}
		case Statement s: 		{cS += [<head(ids), s.src>]; ids = tail(ids);}
		//case Type t: 			{cS += [<head(ids), |empty:///|>]; ids = tail(ids);}
		//case Modifier m: 		{cS += [<head(ids), |empty:///|>]; ids = tail(ids);}
	}
	
	return cS;
}