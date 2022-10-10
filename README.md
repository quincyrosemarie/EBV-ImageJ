# ImageJ pipeline for measurements of EdU and p18 signals on EBV lytic cells

## General procedure
1. Crop BMRF1+ cells and isolate center slice
2. Use DAPI channel to demarcate nucleus
OR
Use p18 (far red) channel to demarcate cytoplasm
3. Measure EdU and p18 signals within demarcated nucleus/cytoplasm

## Create the following folders:
* Raw_field_images
* Crop_Stack
* ROIset
* Crop_stack_rename
* Crop_slice
* Crop_slice_channels
* NucMask
* CellMask

## Plug-in download and installation
1. Download the SplineSnake plug-in from: http://bigwww.epfl.ch/jacob/software/SplineSnake/
2. Install plug-in FIJI by moving the downloaded SplineSnake file into FIJI’s Plugin folder
3. If FIJI is open, restart the program.

## Single-cell stack and slice prep
1. Manually create ROI for each BMRF1+ cell.
    1. Draw a rectangle around cell of interest. Make sure the entire cell is captured.
    2. Ctrl + T to record ROI
    3. Record ROI for all BMRF1+ cells in field.
2. Execute macro: ‘EBV_batchcrop_v5.ijm’
    * Save in ‘Crop_Stack’ folder.
    * Move the generated ROI zip folder to ROIset folder.
3. Rename stack files using macro: ‘EBV_batchrename_saveas.ijm’
    * File name: name_#
    * Save in ‘Crop_stack_rename’ folder.
    * Manually rename 1-9 as 01-09.
    * Save ‘Results’ window as excel sheet ‘crop_stack_rename_log’
4. For each cell stack:
    1. Manually determine start slice and end slice for a cell stack.
    2. Determine the number of the center z slice:
(a+b)/2
with a: the number of the first slice containing signals from the cell of interest, and b: number of the last slice containing signals from the cell of interest.
    3. Open macro ‘EBV_substack_v2.ijm’ on macro editor and edit to specify output folder (on ‘output’ line) or run macro with manual output selector ‘#@ File (label = output directory’ line.
    4. Manually edit slice number in macro. ‘z=’ and ‘slices=’
    5. Run macro ‘EBV_substack_v2.ijm’ from the editor.
        * Note: this macro automatically opens the next image in the folder.
        * Alternative naming scheme (can be edited in the ‘substack_v2.ijm’ macro)
            * name_xxhr_y_#_z#
            * xxhr: hours post induction
            * y: field image #
            * \#: cell number (corresponding to ROI number)
            * z#: slice number

5. Split channel of slice image file
    * Open macro ‘EBV_splitchannel_saveAs_batch_v2.ijm’ on macro editor.
    * Run this macro from the macro editor.
    * Input folder: crop_slice
    * Output folder: crop_slice_channels

## Image processing and measurements
### General steps:
1. Demarcate nucleus – based on DAPI channel
2. Demarcate cytoplasm – based on p18 – where applicable.
3. Measure signals of EdU and p18 in their respective channels, within demarcation.
    * Also measure area of demarcation.

### Nucleus demarcation
1. Open DAPI image.
2. Plugins > Macros > Install…
    * ‘EBV_splinesnake_createmask.ijm’
3. Make nucleus mask using SplineSnake.
    1. Plugins > SplineSnake > splineSnake
    2. Using the bluepen icon, trace dots around the cell, connecting the final dot to the first dot to enclose the trace.
    3. Click the snake icon – spline will outline the nucleus.
    4. Click the microscope icon – to go back to ImageJ, with the spline outline on the nucleus.
    5. Create mask from the nucleus outline:
Edit > Selection > Create Mask
    6. Save Mask Window as nucleus mask file.
        * Press ‘s’ to activate splinesnake mask macro
        * Output file: nucmask

### Cytoplasm demarcation
1. Open p18 (far red) image.
2. Plugins > Macros > Install…
    * ‘EBV_splinesnake_createmask.ijm’
3. Make cytoplasm mask using SplineSnake.
    1. Plugins > SplineSnake > splineSnake
    2. Using the bluepen icon, trace dots around the cell, connecting the final dot to the first dot to enclose the trace.
    3. Click the snake icon – spline will outline the nucleus.
    4. Click the microscope icon – to go back to ImageJ, with the spline outline on the nucleus.
    5. Create mask from the nucleus outline:
        * Edit > Selection > Create Mask
    6. Save Mask Window as nucleus mask file.
        * Press ‘s’ to activate splinesnake mask macro
        * Output file: cytmask

### Signal measurements
* Use macro ‘EBV_signalmeasure_nuc.ijm’ for signal measurement with nucleus mask
* Use macro ‘EBV_signalmeasure_cyt.ijm’ for signal measurement with cytoplasmic mask

Note:  
For cell files that do not have cytoplasmic masks, process these cell files separately from those of cells that have both nucleus and cytoplasmic masks. That is, keep the files in separate folders. For these cell files, use nucleus mask for both EdU and p18 signal measurements.
