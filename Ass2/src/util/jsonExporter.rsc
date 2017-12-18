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

void exportResult(list[SXNODE] suffixTree, loc project, str projectName){
	loc outputLoc = toLocation("file:///tmp/software_evolution_DQ/<projectName>.json"); 
	str duplicateResult = "";
	str jsonResult = "";
	
	for(SXNODE suffixTreeNode <- suffixTree){
		duplicateResult += nodeToJson(suffixTreeNode);
		duplicateResult += ",";
	}
	duplicateResult = duplicateResult[1..-2];
	
	jsonResult = "{
		\"project\": { \n
			\"name\": \"<projectName>\",
			\"location\": \"<project>\"
		},
		\"suffixTree\": [<duplicateResult>}],
		\"mapping\": \"<project>\"
	}";
	
	writeFile(outputLoc, jsonResult);
	//println(resolveLocation(outputLoc));
}

str nodeToJson(SXNODE resultNode){
	return "		
			{
				\"id\": \"<resultNode[0]>\",
				\"edge\": \"<resultNode[1]>\",
				\"children\": \"<resultNode[2]>\"
			}";
}