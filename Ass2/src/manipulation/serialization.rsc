module manipulation::serialization

import IO;
import lang::java::m3::Core;
import lang::java::jdt::m3::AST;
import lang::java::jdt::m3::Core;
import List;
import Map;
import Set;
import Node;
import util::ValueUI;

set[Declaration] serializeAst(set[Declaration] projectAst) {
	return traverseNodes(projectAst);
}

set[Declaration] traverseNodes(set[Declaration] ast) {
	return visit(ast) {
		case node x => serialize(x)
	}
}

node serialize(node x) {
	// for all posiblities see: https://github.com/usethesource/rascal/blob/56b48973b85ab0770cd7abe04c45a5d6b9ebe109/src/org/rascalmpl/library/lang/java/m3/AST.rsc
	return visit(x) {
		//case EmptyList() : println("emptyLine Found");
	
		// Declaration
		case \enumConstant(_, ecArgs, ecClass) => \enumConstant("enumConstantID", ecArgs, ecClass)
		case \enumConstant(_, ecArgs) => \enumConstant("enumConstantID", ecArgs)
		case \class(_, cExt, cImp, cBody) => \class("classID", cExt, cImp, cBody)
		//case \class(_)
		case \interface(_, iExt, iImp, iBody) => \interface("interfaceID", iExt, iImp, iBody)
		//case \method(_, _, xPrmtrs, mExcpt, mImp) => \method(_, "methodID", mPrmtrs, mExcpt, mImp) // do sumthing with return?
		//case \method(_, _, mPrmtrs, mExcpt) => \method(_, "methodID", mPrmtrs, mExcpt)
		case \constructor(_, cPara, cExcpt, cImpl) => \constructor("constructorID", cPara, cExcpt, cImpl)
		//case \variables()??
		//case \typeParameter(_, tPext) => \typeParameter("typeParameterID",tPext)
		case \annotationType(_, aBody) => \annotationType("annotationTypeID",aBody)
		//case \annotationTypeMember(_, _) => \annotationTypeMember(_, "annotationTypeMemberID")
		//case \annotationTypeMember(_, _, defB) => \annotationTypeMember(_, "annotationTypeMemberID", defB)
		//case \parameter(_, _, pExt) => \parameter(_, "parameterID", pExt)
		//case \vararg(_, _) => \vararg(_, "varargID")
		
		// Expression
		case \characterLiteral(_) => \characterLiteral("charID")
		case \fieldAccess(fAsup, _) => \fieldAccess(fAsup, "faID")
		case \methodCall(mCsup, _, mCarg) => \methodCall(mCsup, "methodCallID", mCarg)
		case \methodCall(mCsup, mCexpr, _, mCarg) => \methodCall(mCsup, mCexpr, "methodCallID", mCarg)
		case \number(_) => \number("numberID")
		case \booleanLiteral(_) => \booleanLiteral(true)
		case \stringLiteral(_) => \stringLiteral("stringID")
		case \variable(_,vExtD) => \variable("variableID",vExtD)
		case \variable(_,vExtD, vIni) => \variable("variableID",vExtD,vIni)
		case \simpleName(_) => \simpleName("simpleNameID")
		case \markerAnnotation(_) => \markerAnnotation("markerAnnotationID")
		case \normalAnnotation(_, nAmvp) => \normalAnnotation("normalAnnotationID", nAmvp)
		case \memberValuePair(_, mvpValue) => \memberValuePair("memberValuePairID", mvpValue)
		case \singleMemberAnnotation(_, smaValue) => \singleMemberAnnotation("singleMemberAnnotationID", smaValue)
		
		
		// Statement
		case \break(_) => \break("breakID")
		case \continue(_) => \continue("continueID")
		case \label(_, lBody) => \label("labelID", lBody)
		
		
		// Type
		//todo? something something
	}
}
