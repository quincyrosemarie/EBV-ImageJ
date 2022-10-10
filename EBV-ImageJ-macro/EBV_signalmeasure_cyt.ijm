//use nucmask or cytmask to measure pixel intensity in DAPI or farred raw image

#@ File (label = "Input directory", style = "directory") input
#@ File (label = "cyt mask directory", style = "directory") cytfolder
//#@ File (label = "EdU slice directory", style = "directory") EdUfolder
//#@ File (label = "p18 slice directory", style = "directory") p18folder
#@ File (label = "Output directory", style = "directory") output
#@ String (label = "File suffix", value = "DAPI.tif") suffix
#@ String (label = "cyt output file name", value = "20200814_testset.csv") cytfile
//Change the ratiofile output file name -- csv file name

processFolder(input)

function processFolder(input) {
		list = getFileList(input);
		list = Array.sort(list);
		run("Clear Results");
		row = 0;
		for (i = 0; i < list.length; i++) {
			if(File.isDirectory(input + File.separator + list[i]))
				processFolder(input + File.separator + list[i]);
			if(endsWith(list[i], suffix))
				processFile(input, output, list[i]);
		}
	}

//End of batch processing
	selectWindow("Results");
	saveAs("Results", output + File.separator + cytfile);
	print("Done.");
	selectWindow("Log");


function processFile(input, output, file) {
		// Do the processing here by adding your own code.
		//open DAPI image
		open(input + File.separator + list[i]);
		rawname = getTitle();
		//print(rawname);
		rename(replace(rawname, "_DAPI.tif", ""));
		rawname = getTitle();
		//print(rawname);
		print ("Processing... " + list[i]);
		
		//open cytmask + selection
		open(cytfolder + File.separator + rawname + "_cytmask.tif");
		cytmaskname = getTitle();
		selectWindow(cytmaskname);
		run("Select None");
		run("Create Selection");	

		//EdU (green) image cytoplasmic selection
		open(input + File.separator + rawname + "_GFP.tif");
		EdUname = getTitle();
		run("Select None"); // clears the selection
		run("Restore Selection");
		open(input + File.separator + rawname + "_FARRED.tif");
		p18name = getTitle();
		
		//signal measurement
		selectWindow(EdUname);
		setThreshold(50,65535);
		run("Set Measurements...", "area mean median modal min limit redirect=None decimal=2");
		cytarea = getValue("Area");
		EdUarea = getValue("Area limit");
		//EdUarea2 = getValue("Area limit");
		EdUmean = getValue("Mean limit");
		EdUmedian = getValue("Median limit");
		EdUmodal = getValue("Mode limit");
		EdUmin = getValue ("Min limit");

		selectWindow(p18name);
		run("Select None"); // clears the selection
		run("Restore Selection");
		setThreshold(50,65535);
		run("Set Measurements...", "area mean median modal min limit redirect=None decimal=2");
		p18area = getValue("Area limit");
		p18mean = getValue("Mean limit");
		p18median = getValue("Median limit");
		p18modal = getValue("Mode limit");
		p18min = getValue ("Min limit");

		

		
		//results table
		setResult("Filename", row, rawname);
		setResult("cyt area", row, cytarea);
		setResult("EdU area", row, EdUarea);
		setResult("EdU mean", row, EdUmean);
		setResult("EdU median", row, EdUmedian);
		setResult("EdU modal", row, EdUmodal);
		setResult("EdU min", row, EdUmin);
		
		setResult("p18 mean", row, p18mean);
		setResult("p18 median", row, p18median);
		setResult("p18 modal", row, p18modal);
		setResult("p18 min", row, p18min);
		updateResults();

		/*note that cyt area is selection area
		EdU area is area of thresholded EdU pixels within cytoplasmic area
		p18 area is area of thresholded p18 pixels within cytoplasmic area*/
		
		row++;
		selectWindow(rawname);
		close();
		selectWindow(cytmaskname);
		close();
		selectWindow(EdUname);
		close();
		selectWindow(p18name);
		close();
		
		


}	