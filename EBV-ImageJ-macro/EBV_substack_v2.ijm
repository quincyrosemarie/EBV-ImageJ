
#@ File (label = "Output directory", style = "directory") output

//output = "C:/Users/quinc/OneDrive - UW-Madison/Documents/UW-grad/SugdenLab/Projects/EBV ROC/GCV/GCV_Log/GCV_GFPH2B_2/GCV_GFPH2B_2_slice";

parentname = getTitle();
rename(replace(parentname, ".tif", ""));
parentname = getTitle();
z=29;
Stack.setPosition(1, z, 1);
Stack.getPosition(channel, slice, frame);
run("Make Substack...", "channels=1-4 slices=29");
//print(slice);
saveAs("tiff", output + File.separator + parentname + "_z" + z);
close();
selectWindow(parentname);
run("Open Next");
run("In [+]");
run("In [+]");