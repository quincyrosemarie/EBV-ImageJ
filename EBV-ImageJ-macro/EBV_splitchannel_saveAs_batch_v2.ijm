//batch processing
//takes slice image (or stack) of 4 channels C1: DAPI, C2: GFP, C3: Red, C4: far red
//split channel, save each channel image in output folder

#@ File (label = "Input directory", style = "directory") input
#@ File (label = "Output directory", style = "directory") output
#@ String (label = "File suffix", value = ".tif") suffix

processFolder(input)

function processFolder(input) {
		list = getFileList(input);
		list = Array.sort(list);
		run("Clear Results");
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
		rawTitle = getTitle();
		run("Split Channels");
			DAPIname = "C1-" + rawTitle;
			GFPname = "C2-" + rawTitle;
			REDname = "C3-" + rawTitle;
			FARREDname = "C4-" + rawTitle;
			
			selectWindow(DAPIname);
			parentname = getTitle();
			rename(replace(parentname, ".tif", "_DAPI"));
			parentname = getTitle();
			rename(replace(parentname, "C1-", ""));
			parentname = getTitle();
			saveAs("tiff", output + File.separator + parentname);
			
			selectWindow(GFPname);
			parentname = getTitle();
			rename(replace(parentname, ".tif", "_GFP"));
			parentname = getTitle();
			rename(replace(parentname, "C2-", ""));
			parentname = getTitle();
			saveAs("tiff", output + File.separator + parentname);
			
			selectWindow(REDname);
			parentname = getTitle();
			rename(replace(parentname, ".tif", "_RED"));
			parentname = getTitle();
			rename(replace(parentname, "C3-", ""));
			parentname = getTitle();
			saveAs("tiff", output + File.separator + parentname);
			
			selectWindow(FARREDname);
			parentname = getTitle();
			rename(replace(parentname, ".tif", "_FARRED"));
			parentname = getTitle();
			rename(replace(parentname, "C4-", ""));
			parentname = getTitle();
			saveAs("tiff", output + File.separator + parentname);
			close();
			close();
			close();
			close();
			
			

}

