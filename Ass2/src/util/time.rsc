module util::time

import IO;
import DateTime;

/* Print how long a step took */
public void printTimeStep(datetime startTime) {
	print("This step took: ");
	current = now();
	difference = current-startTime;
	
	if (difference.minutes > 0) {
		print(difference.minutes);
		print("m");
	}
	print(difference.seconds);
	print("s");
	print(difference.milliseconds);
	println("ms.\n");
}