module duplication

import lang::java::jdt::m3::Core;
import analysis::m3::Core;
import List;
import String;
import IO;
import Set;

import cleantext;

/* Take every method and compare to all the other methods once. */
int printDuplication(M3 model) {
	/* Remove empty lines and comments. */
	fileList = mapper(toList(methods(model)), cleanText);
	/* Remove any files that are to small to be relevant. */
	fileList = [ x | x <- fileList, size(x) > 6];
	/* Remove lines with only a bracket, because they cause the scan to find unrelevant duplications. */
	fileList = mapper(fileList, removeBrackets);
	
	duplicateLines = 0;
	
	for (list[str] file <- fileList) {
		duplicateLines += checkDuplactesFile(file, fileList);
	}
	
	return duplicateLines;
}

/* Compare a file with all the other files except itself. */
int checkDuplactesFile(list[str] file, list[list[str]] fileList) {
	print(".");
	duplicateLines = 0;	
	for (list[str] comparedFile <- fileList) {
		duplicateLines += compareFiles(file, comparedFile);
	}
	//if (duplicateLines > 0) {println(duplicateLines);}
	return duplicateLines;
}

/* Compare two files to see if they have matching code. */
int compareFiles(list[str] file, list[str] comparedFile) {
	duplicateLines = 0;
	sameFile = (file == comparedFile);
	i = 0;
	while (i < size(comparedFile)) {
	
		for(int j <- [0 .. size(file)]) {
			
			if(file[j] == comparedFile[i]) {
				if (sameFile && i == j) {
					break;
				}
				sameLines = checkLines(file, j, comparedFile, i);
				if (sameLines > 6) {
					duplicateLines += sameLines;
				}
				i += sameLines - 1;
				break;
			}
		}
		i += 1;
	}
	
	return duplicateLines;
}

/* Compare two subseuqent sets of lines until they don't match */
int checkLines(list[str] method, int i, list[str] comparedMethod, int j) {
	lines = 0;
	line = "";
	comparedLine = "";
	do {
		lines += 1;
		i += 1;
		j += 1;
		
		if (i < size(comparedMethod)) {
			comparedLine = comparedMethod[i];
		} else {
			break;
		}
		
		if (j < size(method)) {
			line = method[j];
		} else {
			break;
		}
	} while (line == comparedLine);
	
	return lines;
}

/* Remove lines with only a bracket. */
list[str] removeBrackets(list[str] file) {
	return [x | x <- file, (x != "}") && (x != "{")];
}

