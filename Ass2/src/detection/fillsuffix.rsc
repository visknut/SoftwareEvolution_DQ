module detection::fillsuffix

import List;
import Set;
import IO;

import detection::sxtree2;

private int NEWID;
private int TRESHOLD;
private bool CHANGED;

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

public list[SXNODE] filterSuffix(list[SXNODE] oldSuffix, int treshold) {
	list[SXNODE] newSuffix = oldSuffix;
	CHANGED = true;
	while (CHANGED) {
		CHANGED = false;
		oldSuffix = newSuffix;
		newSuffix = filterSuffix1(newSuffix, treshold);
	}
	return newSuffix;
}

public list[SXNODE] filterSuffix1(list[SXNODE] oldSuffix, int treshold) {
	TRESHOLD = treshold;
	list[SXNODE] newSuffix = [oldSuffix[0]];
	newSuffix[0].id = 0;
	NEWID = 1;
	newSuffix[0].childeren = {};
	for (child <- oldSuffix[0].childeren) {
		newSuffix = filterSuffix2(oldSuffix, newSuffix, 0, child);
	}
	return newSuffix;
}

public list[SXNODE] filterSuffix2(list[SXNODE] oldSuffix, list[SXNODE] newSuffix, int newParent, int oldChild) {
	SXNODE newChild;
	if (oldSuffix[oldChild].childeren == {} && oldSuffix[oldChild].length < TRESHOLD) {
		CHANGED = true;
		return newSuffix;
	} else {
		newChild = oldSuffix[oldChild];
		newChild.id = NEWID;
		NEWID += 1;
		newChild.childeren = {};
		newSuffix[newParent].childeren += {newChild.id};
		newSuffix += newChild;
		for (child <- oldSuffix[oldChild].childeren) {
			newSuffix = filterSuffix2(oldSuffix, newSuffix, newChild.id, child);
		}
	}
	return newSuffix;
}