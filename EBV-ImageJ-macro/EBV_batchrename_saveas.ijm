//function to scan folder for files with correct suffix
//then rename it all according to specified prefix + number
//Specify the new prefix name in the 'fileprefix' prompt.

#@ File (label = "Input directory", style = "directory") input
#@ File (label = "Output directory", style = "directory") output
#@ String (label = "File suffix", value = ".tif") suffix
#@ String (label = "New file prefix", value = "fixed20190920_I-noGCV_") fileprefix

processFolder(input)

// function to scan folders/subfolders/files to find files with correct suffix
	function processFolder(input) {
		list = getFileList(input);
		list = Array.sort(list);
		run("Clear Results");
		row=0;
		for (i = 0; i < list.length; i++) {
			if(File.isDirectory(input + File.separator + list[i]))
				processFolder(input + File.separator + list[i]);
			if(endsWith(list[i], suffix))
				processFile(input, output, list[i]);
		}
	}

//End of batch processing
	print("Done.");
	
	function processFile(input, output, file) {
		// Do the processing here by adding your own code.
		open(input + File.separator + list[i]);
		oldname = getTitle();
		print ("Processing... " + list[i]);
		imagenum = i+1;
		selectWindow(oldname);
		saveAs("tiff", output + File.separator + fileprefix + imagenum + ".tif");
		setResult ("oldname", row, oldname);
		setResult ("newname", row, fileprefix + imagenum);
		row++;
		close();
	}

