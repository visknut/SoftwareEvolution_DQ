module detection::createsuffix2

import IO;

import List;
import Set;
import Node;
import String;

import detection::sxtree2;

private lrel[int code, value location] hashedCode = [];

private int newNodeId;
private list[SXNODE sxnode] nodeList;
private int linkedNode;
private int newLinkedNode;
private SXNODE nullNode = sxNode(-1, <0, 0>, {}, -1);
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


public list[SXNODE] createSuffixTree(lrel[int code, value location] code) {

	/* Set variables to zero for a new tree. */
	newNodeId = 0;
	remainder = 0;
	
	/* Use test code if the input is empty */
	if (code == []) {
		hashedCode = [<1, |empty:///|> ,<2, |empty:///|>, <3, |empty:///|>, <1, |empty:///|>, <2, |empty:///|>, <4, |empty:///|>, <1, |empty:///|> ,<2, |empty:///|>, <3, |empty:///|>, <5, |empty:///|>, <-1, |empty:///|>];
	} else {
		hashedCode = code + [<-1, |empty:///|>];
	}
	
	/* Initiate the tree. */
	nodeList = [sxNode(newNodeId, <0, 0>, {}, -1)];
	newNodeId += 1;
	tuple[int aN, int aE, int aL, int aH] startAp = <0, -1, 0, -1>;
	aP = startAp;
	
	/* The algorithm moves through the list from left to right. */
	for (i <- [0 .. size(hashedCode)]) {
		/* Remainder is incremented every step and only decremented when the hash is inserted. */
		remainder += 1;
		/* Needed to check if a suffix link needs to be created. */
		linkedNode = 0;
		newLinkedNode = 0;
		step(i);
	}
	
	/* Finalize and show the tree. */
	nodeList = fillTree(size(hashedCode) - 1, nodeList);
	//println(root);
	
	return nodeList;
}

private void step(int i) {
	/* Print info about the step. */
	println("Tree: <nodeList>");
	println("Active node <aP.aN>");
	println("Active edge <aP.aE>");
	println("Active length <aP.aL>");
	println("Active hash: <aP.aH>");
	println("Remainder <remainder - 1>");
	println("Link <linkedNode>");
	println("");
	
	if (aP.aN == 0) {
		if (aP.aL == 0) {
			rootExtension(i);
		} else {
			activeEdgeExtension(i);
		}
	} else {
		if (aP.aL == 0) {
			internalNodeExtension(i);
		} else {
			activeEdgeExtension(i);
		}

	}
}

/* Check if hash can be found one of the edges leaving the root node. */
/* If not, create a new edge for that hash. If so, follow that edge until it stops matching. */
private void rootExtension(int i) {
	/* Search for the hash on leaving edges. */
	int matchingEdge = findHash(nodeList, 0, i, hashedCode);
	/* hash was not found, new edge created. */
	if (matchingEdge == -1) {
		newNode = sxNode(newNodeId, <i, 0>, {}, -1);
		nodeList += newNode;
		nodeList[0].childeren += {newNode.id};
		newNodeId += 1;
		remainder -= 1;
		
	/* hash found, store this edge to follow it in the next step. */
	} else {
		aP = <0, matchingEdge, 1, i>;
		/* Remainder in not decremented, because we still need to add this hash to the tree. */
	}
}
		
/* Check if the current hash can be found on the activeEdge. */
/* If so, we keep following this edge. If not, we create an internal node. */
private void activeEdgeExtension(int i) {
	/* Check if current hash matches with the next on the activeEdge. */
	if (hashedCode[aP.aL + nodeList[aP.aE].edge.left].code == hashedCode[i].code) {
		/* Check the length of the active edge. */
		int edgeLength;
		tuple[int left, int right] e = nodeList[aP.aE].edge;
		if (e.right == 0) {
			edgeLength = i - e.left;
		} else {
			edgeLength = e.right - e.left;
		}
		/* If the edge ends, we set the active point to search a new edge in the next step. */
		if (edgeLength < aP.aL + 1) {
			aP.aN = aP.aE;
			aP.aE = -1;
			aP.aL = 0;
			aP.aH = -1;
		} else {
			aP.aL += 1;
		}
		/* Remainder in not decremented, because we still need to add this hash to the tree. */
	} else {
		createInternalNodeFromActiveEdge(i);
	}
}

private void createInternalNodeFromActiveEdge(int i){
	createInternalNode(i);
	
	/* Check if a new suffix link has to made. */
	if (linkedNode != 0) {
		nodeList[linkedNode].link = newLinkedNode;
	}
	linkedNode = newLinkedNode;
	
	/* Rule 3 */
	if (aP.aN != 0) {
		if (nodeList[aP.aN].link == -1) {
			aP.aN = 0;
		} else {
			aP.aN = nodeList[aP.aN].link;
		}
		aP.aE = findHash(nodeList, aP.aN, aP.aH, hashedCode);
	} else {
		aP.aL -= 1;
		aP.aH += 1;
		aP.aE = findHash(nodeList, aP.aN, aP.aH, hashedCode);
	}
	
	remainder -= 1;
	/* Do this step again with a new activePoint. */
	step(i);
}

private void internalNodeExtension(int i) {
	/* Search for the hash on leaving edges. */
	int matchingEdge = findHash(nodeList, aP.aN, i, hashedCode);
	/* hash was not found, new edge created. */
	if (matchingEdge == -1) {
		newNode = sxNode(newNodeId, <i, 0>, {}, -1);
		nodeList[aP.aN].childeren += {newNodeId};
		nodeList += newNode;
		newNodeId += 1;
		
		if (nodeList[aP.aN].link == -1) {
			aP.aN = 0;
		} else {
			aP.aN = nodeList[aP.aN].link;
		}
		aP.aE = -1;
		remainder -= 1;
		
	/* hash found, store this edge to follow it in the next step. */
	} else {
		aP.aE = matchingEdge;
		aP.aL += 1;
		aP.aH = i;
		/* Remainder in not decremented, because we still need to add this hash to the tree. */
	}
}

/*
After splitting an edge from an active_node that is not the root node, 
we follow the suffix link going out of that node, if there is any, 
and reset the active_node to the node it points to. If there is no suffix link, 
we set the active_node to the root. active_edge and active_length remain unchanged. 
*/
public void createInternalNode(int i) {
	/* Create and add the new internal node. */
	tuple[int left, int right] internalEdge = 
		<nodeList[aP.aE].edge.left, nodeList[aP.aE].edge.left + aP.aL - 1>;
	newInternalNode = sxNode(newNodeId, internalEdge, {newNodeId + 1, aP.aE}, -1);
	newNodeId += 1;
	nodeList += newInternalNode;
	
	/* Add new leaf node. */
	newNode = sxNode(newNodeId, <i, 0>, {}, -1);
	nodeList[aP.aE].edge.left += aP.aL;
	newNodeId += 1;
	nodeList += newNode;
	
	/* Remove old node from tree and at the new one. */
	nodeList[aP.aN].childeren -= {aP.aE};
	nodeList[aP.aN].childeren += {newInternalNode.id};
	
	/* Set newLinkedNode for suffix link. */
	newLinkedNode = newInternalNode.id;
}
    

   
