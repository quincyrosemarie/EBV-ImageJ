

//print (roiManager("count"));

macro "Crop batch [c]" {
	parentfile = getTitle();
	rename(replace(parentfile, ".nd2", "_"));
	parentfile = getTitle();
	selectWindow(parentfile);
	run("Brightness/Contrast...");
	resetMinAndMax();
	filepath = getDirectory("Choose a Directory");
	for (i=0; i<roiManager("count"); ++i) {
		//print (i);
		roiManager("select", i);
		run("Duplicate...", "duplicate");
		resetMinAndMax();
		imagenum= i+1;
		saveAs ("Tiff", filepath + parentfile + imagenum + "_stack");
		//saveAs("Tiff", "C:\\Users\\QR\\OneDrive\\Documents\\UW-grad\\Cropped_saved\\" + parentfile +imagenum+ ".tif");
		close();
		selectImage(parentfile);
		roiManager("Show All");
		roiManager("select", newArray(0,i));
		roiManager("Save", filepath+ parentfile + "RoiSet.zip");
	}
}


