module util::time

import IO;
import DateTime;

/* Print how long a step took */
public void printTimeStep(datetime startTime) {
	print("This step took: ");
	current = now();
	timeDiff = current-startTime;
	
	if (timeDiff.minutes > 0) {
		print(timeDiff.minutes);
		print("m");
	}
	print(timeDiff.seconds);
	print("s");
	print(timeDiff.milliseconds);
	println("ms.\n");
}