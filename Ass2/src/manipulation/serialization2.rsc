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
	lrel[int code, value location] cS = [];
	for (x <- ast) {
		cS += serialize(x);
	}
	return cS;
}

lrel[int code, value location] serialize(node x) {
	lrel[int code, value location] cS = [];	
	visit(x) {
	
	/* Declarations. */
    case \compilationUnit(list[Declaration] imports, list[Declaration] types): cS += [<1, x.src>];
    case \compilationUnit(Declaration package, list[Declaration] imports, list[Declaration] types): cS += [<2, x.src>];
    case \enum(str name, list[Type] implements, list[Declaration] constants, list[Declaration] body): cS += [<3, x.src>];
    case \enumConstant(str name, list[Expression] arguments, Declaration class): cS += [<4, x.src>];
    case \enumConstant(str name, list[Expression] arguments): cS += [<1, x.src>];
    case \class(str name, list[Type] extends, list[Type] implements, list[Declaration] body): cS += [<5, x.src>];
    case \class(list[Declaration] body): cS += [<1, x.src>];
    case \interface(str name, list[Type] extends, list[Type] implements, list[Declaration] body): cS += [<6, x.src>];
    case \field(Type \type, list[Expression] fragments): cS += [<7, x.src>];
    case \initializer(Statement initializerBody): cS += [<8, x.src>];
    case \method(Type \return, str name, list[Declaration] parameters, list[Expression] exceptions, Statement impl): cS += [<9, x.src>];
    case \method(Type \return, str name, list[Declaration] parameters, list[Expression] exceptions): cS += [<10, x.src>];
    case \constructor(str name, list[Declaration] parameters, list[Expression] exceptions, Statement impl): cS += [<11, x.src>];
    case \import(str name): cS += [<12, x.src>];
    case \package(str name): cS += [<13, x.src>];
    case \package(Declaration parentPackage, str name): cS += [<14, x.src>];
    case \variables(Type \type, list[Expression] \fragments): cS += [<15, x.src>];
    case \typeParameter(str name, list[Type] extendsList): cS += [<16, x.src>];
    case \annotationType(str name, list[Declaration] body): cS += [<17, x.src>];
    case \annotationTypeMember(Type \type, str name): cS += [<18, x.src>];
    case \annotationTypeMember(Type \type, str name, Expression defaultBlock): cS += [<19, x.src>];
    // initializers missing in parameter, is it needed in vararg?
    case \parameter(Type \type, str name, int extraDimensions): cS += [<20, x.src>];
    case \vararg(Type \type, str name): cS += [<21, x.src>];


	///* Expression */
    case \arrayAccess(Expression array, Expression index): cS += [<22,x.src>];
    case \newArray(Type \type, list[Expression] dimensions, Expression init): cS += [<23, x.src>];
    case \newArray(Type \type, list[Expression] dimensions): cS += [<24, x.src>];
    case \arrayInitializer(list[Expression] elements): cS += [<25, x.src>];
    case \assignment(Expression lhs, str operator, Expression rhs): cS += [<26, x.src>];
    case \cast(Type \type, Expression expression): cS += [<27, x.src>];
    case \characterLiteral(str charValue): cS += [<28, x.src>];
    case \newObject(Expression expr, Type \type, list[Expression] args, Declaration class): cS += [<29, x.src>];
    case \newObject(Expression expr, Type \type, list[Expression] args): cS += [<30, x.src>];
    case \newObject(Type \type, list[Expression] args, Declaration class): cS += [<31, x.src>];
    case \newObject(Type \type, list[Expression] args): cS += [<32, x.src>];
    case \qualifiedName(Expression qualifier, Expression expression): cS += [<33, x.src>];
    case \conditional(Expression expression, Expression thenBranch, Expression elseBranch): cS += [<34, x.src>];
    case \fieldAccess(bool isSuper, Expression expression, str name): cS += [<35, x.src>];
    case \fieldAccess(bool isSuper, str name): cS += [<36, x.src>];
    case \instanceof(Expression leftSide, Type rightSide): cS += [<37, x.src>];
    case \methodCall(bool isSuper, str name, list[Expression] arguments): cS += [<38, x.src>];
    case \methodCall(bool isSuper, Expression receiver, str name, list[Expression] arguments): cS += [<39, x.src>];
    case \null(): cS += [<1, x.src>];
    case \number(str numberValue): cS += [<1, x.src>];
    case \booleanLiteral(bool boolValue): cS += [<40, x.src>];
    case \stringLiteral(str stringValue): cS += [<41, x.src>];
    case \type(Type \type): cS += [<1, x.src>];
    case \variable(str name, int extraDimensions): cS += [<42, x.src>];
    case \variable(str name, int extraDimensions, Expression \initializer): cS += [<43, x.src>];
    case \bracket(Expression expression): cS += [<44, x.src>];
    case \this(): cS += [<45, x.src>];
    case \this(Expression thisExpression): cS += [<46, x.src>];
    case \super(): cS += [<47, x.src>];
    case \declarationExpression(Declaration declaration): cS += [<48, x.src>];
    case \infix(Expression lhs, str operator, Expression rhs): cS += [<49, x.src>];
    case \postfix(Expression operand, str operator): cS += [<50, x.src>];
    case \prefix(str operator, Expression operand): cS += [<51, x.src>];
    case \simpleName(str name): cS += [<52, x.src>];
    case \markerAnnotation(str typeName): cS += [<53, x.src>];
    case \normalAnnotation(str typeName, list[Expression] memberValuePairs): cS += [<54, x.src>];
    case \memberValuePair(str name, Expression \value) : cS += [<55, x.src>];          
    case \singleMemberAnnotation(str typeName, Expression \value) : cS += [<56, x.src>];                     
  
	/* Statement */             
    case \assert(Expression expression): cS += [<57, x.src>];
    case \assert(Expression expression, Expression message): cS += [<58, x.src>];
    case \block(list[Statement] statements): cS += [<59, x.src>];
    case \break(): cS += [<60, x.src>];
    case \break(str label): cS += [<61, x.src>];
    case \continue(): cS += [<62, x.src>];
    case \continue(str label): cS += [<63, x.src>];
    case \do(Statement body, Expression condition): cS += [<64, x.src>];
    case \empty(): cS += [<65, x.src>];
    case \foreach(Declaration parameter, Expression collection, Statement body): cS += [<66, x.src>];
    case \for(list[Expression] initializers, Expression condition, list[Expression] updaters, Statement body): cS += [<67, x.src>];
    case \for(list[Expression] initializers, list[Expression] updaters, Statement body): cS += [<68, x.src>];
    case \if(Expression condition, Statement thenBranch): cS += [<69, x.src>];
    case \if(Expression condition, Statement thenBranch, Statement elseBranch): cS += [<70, x.src>];
    case \label(str name, Statement body): cS += [<71, x.src>];
    case \return(Expression expression): cS += [<72, x.src>];
    case \return(): cS += [<73, x.src>];
    case \switch(Expression expression, list[Statement] statements): cS += [<74, x.src>];
    case \case(Expression expression): cS += [<75, x.src>];
    case \defaultCase(): cS += [<76, x.src>];
    case \synchronizedStatement(Expression lock, Statement body): cS += [<76, x.src>];
    case \throw(Expression expression): cS += [<77, x.src>];
    case \try(Statement body, list[Statement] catchClauses): cS += [<78, x.src>];
    case \try(Statement body, list[Statement] catchClauses, Statement \finally): cS += [<79, x.src>];                                     
    case \catch(Declaration exception, Statement body): cS += [<80, x.src>];
    case \declarationStatement(Declaration declaration): cS += [<81, x.src>];
    case \while(Expression condition, Statement body): cS += [<82, x.src>];
    case \expressionStatement(Expression stmt): cS += [<83, x.src>];
    case \constructorCall(bool isSuper, Expression expr, list[Expression] arguments): cS += [<84, x.src>];
    case \constructorCall(bool isSuper, list[Expression] arguments): cS += [<85, x.src>];
  
	///* Types */
 //   case arrayType(Type \type): cS += [<86, |empty:///|>];
 //   case parameterizedType(Type \type): cS += [<87, |empty:///|>];
 //   case qualifiedType(Type qualifier, Expression simpleName): cS += [<88, |empty:///|>];
 //   case simpleType(Expression typeName): cS += [<89, |empty:///|>];
 //   case unionType(list[Type] types): cS += [<90, |empty:///|>];
 //   case wildcard(): cS += [<91, |empty:///|>];
 //   case upperbound(Type \type): cS += [<92, |empty:///|>];
 //   case lowerbound(Type \type): cS += [<93, |empty:///|>];
 //   case \int(): cS += [<94, |empty:///|>];
 //   case short(): cS += [<95, |empty:///|>];
 //   case long(): cS += [<96, |empty:///|>];
 //   case float(): cS += [<97, |empty:///|>];
 //   case double(): cS += [<98, |empty:///|>];
 //   case char(): cS += [<99, |empty:///|>];
 //   case string(): cS += [<100, |empty:///|>];
 //   case byte(): cS += [<101, |empty:///|>];
 //   case \void(): cS += [<102, |empty:///|>];
 //   case \boolean(): cS += [<103, |empty:///|>];
 //
 //   /* Modifiers */
 //   case \private(): cS += [<104, |empty:///|>];
 //   case \public(): cS += [<105, |empty:///|>];
 //   case \protected(): cS += [<106, |empty:///|>];
 //   case \friendly(): cS += [<107, |empty:///|>];
 //   case \static(): cS += [<108, |empty:///|>];
 //   case \final(): cS += [<109, |empty:///|>];
 //   case \synchronized(): cS += [<110, |empty:///|>];
 //   case \transient(): cS += [<111, |empty:///|>];
 //   case \abstract(): cS += [<112, |empty:///|>];
 //   case \native(): cS += [<113, |empty:///|>];
 //   case \volatile(): cS += [<114, |empty:///|>];
 //   case \strictfp(): cS += [<115, |empty:///|>];
 //   case \annotation(Expression \anno): cS += [<116, |empty:///|>];
 //   case \onDemand(): cS += [<117, |empty:///|>];
 //   case \default(): cS += [<118, |empty:///|>];

	}
	return cS;
}
