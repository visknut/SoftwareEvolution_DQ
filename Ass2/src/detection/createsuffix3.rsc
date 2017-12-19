module detection::createsuffix3

import IO;

import List;
import Set;
import Node;
import String;

import detection::sxtree2;

private lrel[int code, value location] hashedCode = [];

private int newNodeId;
private list[SXNODE] nodeList;
private int linkedNode;
private int newLinkedNode;

/*
	aP = activePoint
	aN = activeNode
	aE = activeEdge
	aL = activeLength
	aH = activeHash
*/
private tuple[int aN, int aE, int aL, int aH] aP;
private int remainder;

// Possible problem: should only look a current node for new edge.

private int s;

public list[SXNODE] createSuffixTree(lrel[int code, value location] code) {

	/* Set variables to zero for a new tree. */
	newNodeId = 0;
	remainder = 0;
	s = 1;
	
	/* Use test code if the input is empty */
	if (code == []) {
		hashedCode = [<1, |empty:///|> ,<2, |empty:///|>, <3, |empty:///|>, 
			<1, |empty:///|>, <2, |empty:///|>, <4, |empty:///|>,
			<1, |empty:///|>, <2, |empty:///|>, <3, |empty:///|>, <5, |empty:///|>, <-1, |empty:///|>];
	} else {
		hashedCode = code;
	}
	
	/* Initiate the tree. */
	nodeList = [sxNode(newNodeId, <0, 0>, {}, -1, |empty:///|, -1)];
	newNodeId += 1;
	tuple[int aN, int aE, int aL, int aH] startAp = <0, -1, 0, -1>;
	aP = startAp;
	
	/* The algorithm moves through the list from left to right. */
	for (i <- [0 .. size(hashedCode)]) {
		//println("<i> out of <size(hashedCode)>");
		/* Remainder is incremented every step and only decremented when the hash is inserted. */
		remainder += 1;
		/* Needed to check if a suffix link needs to be created. */
		linkedNode = 0;
		newLinkedNode = 0;
		step(i);
	}
	
	/* Finalize and show the tree. */
	nodeList = fillTree(size(hashedCode) - 1, nodeList);
	
	return nodeList;
}

private void step(int i) {
	setEdge(i);
	/* Print info about the step. */
	//println("STEP: <s>");
	//println("i: <i>");
	//println("Tree: <nodeList>");
	//println("Active node <aP.aN>");
	//println("Active edge <aP.aE>");
	//println("Active length <aP.aL>");
	//println("Active hash: <aP.aH>");
	//println("Remainder <remainder - 1>");
	//println("Link <linkedNode>");
	//println("");
	s += 1;
	
	if (aP.aE == -1) {
		//println("-----NodeEx");
		nodeExtension(i);
	} else {
		/* skip edge if needed. */
		if (aP.aL > getEdgeLength(i)) {
			//println("-----Skip");
			aP.aL -= getEdgeLength(i);
			aP.aN = aP.aE;
			aP.aE = -1;
		} else {
			/* Check if we need to follow the edge or create a new internal node. */
			if (hashedCode[aP.aL + nodeList[aP.aE].edge.left].code != hashedCode[i].code) {
				//println("-----EdgeEx");
				edgeExtension(i);
			} else {
				//println("------FollowEdge");
				updateAl(i);
			}
		}
	}
}

private void setEdge(int i) {
	if (aP.aL == 0) {
		aP.aE = findHash(nodeList, aP.aN, i, hashedCode);
		if (aP.aE == -1) {
			aP.aH = -1;
		} else {
			aP.aH = i;
		}
	} else {
		aP.aH = i - aP.aL;
		aP.aE = findHash(nodeList, aP.aN, aP.aH, hashedCode);
	}
}

private void updateAl(int i) {
	/* Check the length of the active edge. */
	int edgeLength = getEdgeLength(i);
	/* If the edge ends, we set the active point to search a new edge in the next step. */
	if (edgeLength < aP.aL + 1) {
		aP.aN = aP.aE;
		aP.aL = 0;
		aP.aE = -1;
		aP.aH = -1;
	} else {
		aP.aL += 1;
	}
	/* Remainder in not decremented, because we still need to add this hash to the tree. */
}

private int getEdgeLength(int i) {
	int edgeLength;
	tuple[int left, int right] e = nodeList[aP.aE].edge;
	if (e.right == 0) {
		edgeLength = i - e.left;
	} else {
		edgeLength = e.right - e.left;
	}
	return edgeLength;
}

private void nodeExtension(int i) {
	newNode = sxNode(newNodeId, <i, 0>, {}, -1, |empty:///|, -1);
	nodeList += newNode;
	nodeList[aP.aN].childeren += {newNode.id};
	newNodeId += 1;
	remainder -= 1;
}

private void edgeExtension(int i) {
	/* Create new node. */
	createInternalNode(i);
	
	rule2();
	
	if (aP.aN == 0) {
		rule1(i);
	} else {
		rule3();
	}
	remainder -= 1;
	/* Do this step again with a new activePoint. */
	step(i);
}

public void createInternalNode(int i) {
	/* Create and add the new internal node. */
	tuple[int left, int right] internalEdge = 
		<nodeList[aP.aE].edge.left, nodeList[aP.aE].edge.left + aP.aL - 1>;
	newInternalNode = sxNode(newNodeId, internalEdge, {newNodeId + 1, aP.aE}, -1, |empty:///|, -1);
	newNodeId += 1;
	nodeList += newInternalNode;
	
	/* Add new leaf node. */
	newNode = sxNode(newNodeId, <i, 0>, {}, -1, |empty:///|, -1);
	nodeList[aP.aE].edge.left += aP.aL;
	newNodeId += 1;
	nodeList += newNode;
	
	/* Remove old node from tree and at the new one. */
	nodeList[aP.aN].childeren -= {aP.aE};
	nodeList[aP.aN].childeren += {newInternalNode.id};
	
	/* Set newLinkedNode for suffix link. */
	newLinkedNode = newInternalNode.id;
}

private void rule1(int i) {
	aP.aE = -1;
	aP.aL -= 1;
	return;
}

private void rule2() {
	/* Check if a new suffix link has to made. */
	if (linkedNode != 0) {
		nodeList[linkedNode].link = newLinkedNode;
	}
	linkedNode = newLinkedNode;
}

private void rule3() {
	if (nodeList[aP.aN].link == -1) {
		aP.aN = 0;
	} else {
		aP.aN = nodeList[aP.aN].link;
	}
	aP.aE = -1;
}

public list[SXNODE] getLeafLocations(lrel[int code, value location] codeStructure, list[SXNODE] suffixTree) {
	list[SXNODE] filledSuffixTree = [];
	for (sxnode <- suffixTree) {
		if (sxnode.childeren == {}) {
			sxnode.leafLocation = getLocation(codeStructure, sxnode);
		}
		filledSuffixTree += sxnode;
	}
	return filledSuffixTree;
}

private value getLocation(lrel[int code, value location] codeStructure, SXNODE sxnode) {
	int locationId = sxnode.edge.left;
	println(sxnode);
	value ll = codeStructure[locationId].location;
	return ll;
}

public list[SXNODE] getLeafLength(list[SXNODE] suffixTree) {
	suffixTree[0].length = 0;
	for (child <- suffixTree[0].childeren) {
		suffixTree = setNodeLength(suffixTree, child, 0);
	}
	return suffixTree;
}

private list[SXNODE] setNodeLength(list[SXNODE] suffixTree, int nodeId, int prevLength) {
	if (suffixTree[nodeId].childeren == {}) {
		suffixTree[nodeId].length = prevLength;
	} else {
		tuple[int left, int right] edge = suffixTree[nodeId].edge;
		int edgeLength = edge.right - edge.left;
		suffixTree[nodeId].length = prevLength + edgeLength + 1;
		for (child <- suffixTree[nodeId].childeren) {
			suffixTree = setNodeLength(suffixTree, child, suffixTree[nodeId].length);
		}
	}
	return suffixTree;
}

public list[SXNODE] filterSuffix(list[SXNODE] suffixTree, int nodeId, int treshold) {
	list[SXNODE] filteredSuffix = [];
	for (child <- suffixTree[nodeId].childeren) {
		filteredSuffix += filterSuffix(suffixTree, child, treshold);
	}
	if (!(filteredSuffix == [] && suffixTree[nodeId].length < treshold)) {
		filteredSuffix += suffixTree[nodeId];
	}
	return filteredSuffix;
}

public list[SXNODE] fixIds(list[SXNODE] suffixTree) {
	list[SXNODE] newSuffixTree = suffixTree;
	for (i <- [0 .. size(suffixTree)]) {
		for (j <-  [0 .. size(suffixTree)]) {
			if (suffixTree[i].id in suffixTree[j].childeren) {
				newSuffixTree[j].childeren -= {suffixTree[i].id};
				newSuffixTree[j].childeren += {i};
			}
		}
		newSuffixTree[i].id = i;
	}
	return newSuffixTree;
}

public list[SXNODE] smoothOutEdges(list[SXNODE] suffix) {
	for (sxnode <- suffix) {
		if (size(sxnode.childeren) == 1) {
			int child = getOneFrom(sxnode.childeren);
			SXNODE childNode = suffix[child];
			sxnode.edge.right = childNode.edge.right;
			sxnode.length = childNode.length;
			sxnode.childeren = {};
			suffix = delete(suffix, child);
		}
	}
}
