module detection::sxtree2

import List;
import IO;
import String;

data SXNODE = sxNode(int id, tuple[int left, int right] edge, set[int] childeren, int link, value leafLocation, int length);

public list[SXNODE] fillTree(int i, list[SXNODE] nodeList) {
	list[SXNODE] finalNodeList = [];
	for (x <- nodeList) {
		if (x.id != 0 && x.edge.right == 0) {
			x.edge.right = i;
		}
		finalNodeList += x;
	}
	return finalNodeList;
}

public int findHash(list[SXNODE] nodeList, int sxnode, int hash, lrel[int code, value location] serCode) {
	set[int] childSet = nodeList[sxnode].childeren;
	for (childId <- childSet) {
		child = nodeList[childId];
		if (serCode[child.edge.left].code == serCode[hash].code) {
			return child.id;
		}
	}
	return -1;
}

