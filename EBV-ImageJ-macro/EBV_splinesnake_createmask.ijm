macro "spline snake mask [s]" {
	maskdir = getDirectory("Choose nucmask output Directory");
	parentname = getTitle();
	rename(replace(parentname, "DAPI.tif", ""));
	parentname = getTitle();
	selectWindow(parentname);
	run("Create Mask");
	selectWindow("Mask");
	run("Create Selection");
	saveAs("tiff", maskdir + File.separator + parentname + "nucmask");
	close();
	selectWindow(parentname);
	run("Open Next");
	run("Open Next");
	run("Open Next");
	run("Open Next");
}
