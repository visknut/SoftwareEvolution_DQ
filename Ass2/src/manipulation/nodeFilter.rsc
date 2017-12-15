module manipulation::nodeFilter

import IO;
import List;
import Set;
import Node;
import lang::java::m3::Core;
import lang::java::jdt::m3::Core;
import lang::java::m3::AST;
import util::ValueUI;

/* main dataTypes */
alias nodeStructure = tuple[node n, loc nLoc];

list[nodeStructure] filterNodes(set[Declaration] declarations, int nodeSizeThresshold) {
	/* Filters nodes who are too small and put the correct ones in a list */
	list[nodeStructure] filteredNodes = [];
	
	for(decl <- declarations) {
		list[node] nList = [];
		
		/* Puts all nodes into a list */
		visit (decl) {
			case node n: {
				nList += n;
			}
		}
		
		/* Filters every node on size threshold into list of node, size an location tuple */
		for(nListNode <- nList) {
			int nSizeCounter = 0;
			loc nLoc = |empty:///|;
				
			visit (nListNode) {
				case node n: {
					nSizeCounter += 1;
					nLoc = nodeLoc(n);
				}
			}
			if(nSizeCounter >= nodeSizeThresshold && nLoc != |empty:///|) filteredNodes += <unsetRec(nListNode), nLoc>;
		}
	}
	
	return filteredNodes;
}


loc nodeLoc(node n) {
	switch(n) {
		case \Declaration x: return x.src;
		case \Expression y: return y.src;
		case \Statement z: return z.src;
		default: return |empty:///|;  
	}
}