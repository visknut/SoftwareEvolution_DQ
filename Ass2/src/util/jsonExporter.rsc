module util::jsonExporter

import Set;
import List;
import String;
import IO;
import ValueIO;

private int nodeId;
private SXNODE root;
private int linkedNode;
private int newLinkedNode;
private SXNODE nullNode = sxNode(-1, <0, 0>, [], -1);

private tuple[SXNODE aN, SXNODE aE, int aL, int aH] aP;
private int remainder;

data SXNODE = sxNode(int id, tuple[int left, int right] edge, list[SXNODE] childeren, int link); 

void exportResult(SXNODE suffixTree){
	loc outputLoc = toLocation("file:///tmp/software_evolution_DQ/library.txt"); 
	//str result = "";
	//
	//result = suffixTreeToJson(suffixTree);
	writeFile(outputLoc, suffixTree);
	
	println(resolveLocation(outputLoc));
}

str suffixTreeToJson(SXNODE result){
	// Need to know tree depth to export as json
	return "";
}