/////////////////////////////////////////////////////////////////////////////
//This creates menu options and allows preferences to be temporarily saved.//
/////////////////////////////////////////////////////////////////////////////
	//Save settings for secondary channels to measure
greenstate = call("ij.Prefs.get", "greenbool.greenstate", false);
redstate = call("ij.Prefs.get", "redbool.redstate", false);
bluestate = call("ij.Prefs.get", "bluebool.bluestate", false);
graystate = call("ij.Prefs.get", "graybool.graystate", false);
cyanstate = call("ij.Prefs.get", "cyanbool.cyanstate", false);
magentastate = call("ij.Prefs.get", "magentabool.magentastate", false);
yellowstate = call("ij.Prefs.get", "yellowbool.yellowstate", false); 
	//Save settings for particle analysis settings
Minsize = parseFloat(call("ij.Prefs.get","Minsize.PAtool","0"));
Maxsize = parseFloat(call("ij.Prefs.get","Maxsize.PAtool","300"));
Circmin = parseFloat(call("ij.Prefs.get","Circmin.PAtool","0.00"));
Circmax = parseFloat(call("ij.Prefs.get","Circmax.PAtool","1.00"));
	//Additional Settings: Primary Channel Select, Process Check, and Threshold Settings
Mainchannel = call("ij.Prefs.get", "MainChannel.channelstate", "Green"); 
ProcessCheck = call("ij.Prefs.get", "Processbool.processstate", false);
Thresholdsave = call("ij.Prefs.get", "Threshold.save", "0");
Batchcheck = call("ij.Prefs.get", "Batch.save", false);

////////////////////////////////////////////////////////////////////////////////////
//This creates the menu with the included options:                               //
///////////////////////////////////////////////////////////////////////////////////

  title = "Untitled";
  width=700; height=512;
  Dialog.create("Overlap Intensity");
  Dialog.setInsets(0,110, 5);
  Dialog.addMessage("IMAGE PROCESSING");

  Channelchoice = newArray("Green", "Red", "Blue", "Gray", "Cyan", "Magenta", "Yellow");

  //Allows the user to select a different threshold option
  Thresholdchoice = "Default";
  
  Dialog.setInsets(0, 25, 0)
  Dialog.addChoice("ROI Identification Channel:", Channelchoice, Mainchannel);
  Dialog.setInsets(10, 0, 0)
  Dialog.addChoice("Thresholding Method:", newArray("MaxEntropy","Default", "Huang", "Huang2", "Intermodes","IsoData","Li","Mean","MinError(I)","Minimum","Moments","Otsu","RenyiEntropy","Shanbhag","Triangle","Yen"), Thresholdsave);

  //Allows the user to set size restrictions for particle analysis 
  Dialog.addMessage("--------------------------------------------------------------------------------");
  Dialog.setInsets(0, 110, 0);
  Dialog.addMessage("PARTICLE ANALYSIS");
  Dialog.setInsets(5, 100, 0);
  Dialog.addMessage("Size Restrictions (units^2)")
  Dialog.setInsets(5, 45, 10);
  Dialog.addNumber("Minimum Size:", Minsize);
  Dialog.setInsets(0, 45, 10);
  Dialog.addNumber("Maximum Size:", Maxsize);
  Dialog.setInsets(0, 105, 10);
  Dialog.addMessage("Circularity (0.00 to 1.00)");
  Dialog.setInsets(0, 45, 10);
  Dialog.addNumber("Minimum Size:", Circmin, 2, 1 ,"");
  Dialog.setInsets(0, 45, 0);
  Dialog.addNumber("Maximum Size:", Circmax, 2, 1 ,"");
  Dialog.addMessage("--------------------------------------------------------------------------------");
  
  //Select channels to measure overlap with primary channel
  Dialog.setInsets(0, 120, 0);
  Dialog.addMessage("QUANTIFICATION")
  Dialog.setInsets(0, 85, 0);
  Dialog.addMessage("Select Channel(s) to Measure:")
  Dialog.addCheckbox("Green", greenstate);
  Dialog.setInsets(-23, 110, 0);
  Dialog.addCheckbox("Red", redstate);
  Dialog.setInsets(-23, 190, 0);
  Dialog.addCheckbox("Blue", bluestate);
  Dialog.setInsets(-23, 275, 0);
  Dialog.addCheckbox("Gray", graystate);
  Dialog.addCheckbox("Cyan", cyanstate);
  Dialog.setInsets(-23, 110, 0);
  Dialog.addCheckbox("Magenta", magentastate);
  Dialog.setInsets(-23, 190, 0);
  Dialog.addCheckbox("Yellow", yellowstate);
  Dialog.setInsets(15, 90, 0);
  Dialog.addCheckbox("Set Measurement Settings", false); 
  Dialog.addMessage("--------------------------------------------------------------------------------");
  
  //Additional Settings
  Dialog.setInsets(0, 115, 0);
  Dialog.addMessage("Additional Settings: ");
  Dialog.addCheckbox("Check Processed Image Before Proceeding", ProcessCheck); //Checkbox for whether or not to keep processed image open
  Dialog.addCheckbox("Set Image Scale", false);
  Dialog.addCheckbox("Batch Process Images", Batchcheck);
  Dialog.show();
  
////////////////////////////////////////////////////////////
//This section allows the settings to be temporarily saved//
////////////////////////////////////////////////////////////

//Saves Particle Analysis Size Settings
  Minsize = Dialog.getNumber();
   call("ij.Prefs.set", "Minsize.PAtool",toString(Minsize));
  Maxsize = Dialog.getNumber();
   call("ij.Prefs.set", "Maxsize.PAtool",toString(Maxsize));

//Saves Particle Analysis Circularity Settings
  Circmin = Dialog.getNumber();

//Makes sure the Circmin is not below 0.00. Resets the value to 0.00 if it is. 
if (Circmin < 0.00) {
		Circmin = 0.00;	
		//Error Message Box
		showMessage("Circularity must be within 0.00 to 1.00. Lower range reset to 0.00");
		}
	//Makes sure the Circmin does not exceed 1.00. Resets the value to 1.00 if it is.
	else if (Circmin > 1.00) {
		Circmin = 1.00;
		//Error Message Box
		showMessage("Circularity must be within 0.00 to 1.00. Lower range reset to 1.00");
		}
//Saves the Circmin value for later runs		
		call("ij.Prefs.set", "Circmin.PAtool",toString(Circmin));
		
   Circmax = Dialog.getNumber();
   
//Makes sure the Circmax does not exceed 1.00. Resets the value to 1.00 if it is.
if (Circmax > 1.00) {
		Circmax = 1.00;
		//Error Message Box
		showMessage("Circularity must be within 0.00 to 1.00. Upper range reset to 1.00");
		}
		
	//Makes sure the Circmax is not below 0.00. Resets the value to 0.00 if it is.
	else if (Circmax < 0.00) {
		Circmax = 0.00;
		//Error Message Box
		showMessage("Circularity must be within 0.00 to 1.00. Upper range reset to 0.00");
		}
		
//Saves the Circmax value for later runs
call("ij.Prefs.set", "Circmax.PAtool",toString(Circmax));
  
//Saves Mainchannel settings
MainChannel = Dialog.getChoice();
call("ij.Prefs.set", "MainChannel.channelstate",toString(MainChannel));

//Saves Threshold Choice Setting
Thresholdchoice = Dialog.getChoice();
call("ij.Prefs.set", "Threshold.save",toString(Thresholdchoice));
Thresholdformat = "method=" + Thresholdchoice +" white";

//This setting is used to later determine if a "Analysis Complete" message will appear for Batch Processing only
Batchstate = false;

//Saves Checkbox Settings
greenstate = Dialog.getCheckbox();
	call("ij.Prefs.set", "greenbool.greenstate",toString(greenstate));

redstate = Dialog.getCheckbox();
	call("ij.Prefs.set", "redbool.redstate",toString(redstate));

bluestate = Dialog.getCheckbox();
	call("ij.Prefs.set", "bluebool.bluestate",toString(bluestate));

graystate = Dialog.getCheckbox();
	call("ij.Prefs.set", "graybool.graystate",toString(graystate));

cyanstate = Dialog.getCheckbox();
 	call("ij.Prefs.set", "cyanbool.cyanstate",toString(cyanstate));
 	
magentastate = Dialog.getCheckbox();
  	call("ij.Prefs.set", "magentabool.magentastate",toString(magentastate));

yellowstate = Dialog.getCheckbox();
  	call("ij.Prefs.set", "yellowbool.yellowstate",toString(yellowstate));

//Checks the measurment and scale setting options
  MSettings = Dialog.getCheckbox();  

//Saves process check setting
  ProcessCheck = Dialog.getCheckbox();
	call("ij.Prefs.set", "Processbool.processstate",toString(ProcessCheck));
 
  ScaleSettings = Dialog.getCheckbox();

//Batch Check Option. 
  Batchcheck = Dialog.getCheckbox();
  call("ij.Prefs.set", "Batch.save",toString(Batchcheck));

//Process Check option. Process either continues or is ended.
ProcessDecision = newArray("Continue", "End Process");

//Decides if the settings windows should be opened
if (MSettings == true) {
	run("Set Measurements...");
	}

//Checks if the user selected the batch process option. If not the single image process is used.
if (Batchcheck == false){

////////////////////////////////////////////////////////////////////////
////////////PRE-PROCESSING CHECKS FOR NON-BATCH PROCESS/////////////////
////////////////////////////////////////////////////////////////////////

//Checks if more than one image is open at a time. Provides an error message and closes all images. 
if (nImages > 1) {
	Dialog.create("ERROR!");
	Dialog.addMessage("Only one image can be open at a time for analysis!");
	Dialog.show();
	close("*");
	}

//If an image is not open a prompt allows the user to open an image.
if (nImages == 0){
  	//Opens File Browser
  	path = File.openDialog("Select a File");
  	//Saves File Location as dir
  	dir = File.getParent(path);
  	//Opens file
  	open(path);
 	}

//Scale settings 
if (ScaleSettings == true) {
	run("Set Scale...");
	}

//Checks the number of channels in an image. Checks if Image is a composite. This is needed for the Composite Process Code
getDimensions(width, height, channels, slices, frames);
CompositeCheck = is("composite");
 
//This will set the title of the image so that channels can be selected 
imageTitle=getTitle();
run("Split Channels");

//////////////////////////////////
//Composite Image Pre-Processing//
//////////////////////////////////
if (CompositeCheck == true){
	ChannelFinder = newArray("ChannelOne", "ChannelTwo", "ChannelThree", "ChannelFour", "ChannelFive", "ChannelSix", "ChannelSeven"); 

	//Each channel in the default 7 channels has a set foreground color allowing the channel color to be identified 
	//For reference here are the foreground colors: Green = 204, Red = 0, Blue = 255, Grey = 153, Magenta = 127, Cyan = 229, Yellow = 102 
	//This is needed because splitting composites results in channels named by number. The numbers do not necessarily correspond to the color. Example: "C3" could be blue or magenta depending on the colors present.
	
	for (z = 0; z < channels; z++) {

		//Changes the active channel
		selectWindow("C" + z+1 + "-" + imageTitle);
	
		//Saves foreground color as an indictor to the channel ID
		ChannelFinder[z] = getValue("color.foreground");	

		//Identifies the Green Composite Channel
		if (ChannelFinder[z] == 204){
				ChannelFinder[z] = "Green Channel";
				rename(imageTitle + " (green)");
			}
		
		//Identifies the Red Composite Channel
	 	if (ChannelFinder[z] == 0){
	 			ChannelFinder[z] = "Red Channel";
	 			rename(imageTitle + " (red)");
				}
				
		//Identifies the Blue Composite Channel
	 	if (ChannelFinder[z] == 255){
				ChannelFinder[z] = "Blue Channel";
				rename(imageTitle + " (blue)");
				}
		
		//Identifies the Grey Composite Channel
		if (ChannelFinder[z] == 153){
				ChannelFinder[z] = "Gray Channel";
				rename(imageTitle + " (gray)");
				}
		
		//Identifies the Cyan Composite Channel
		if (ChannelFinder[z] == 229){
				ChannelFinder[z] = "Cyan Channel";
				rename(imageTitle + " (cyan)");
				}
				
		//Identifies the Magenta Composite Channel
		if (ChannelFinder[z] == 127){
				ChannelFinder[z] = "Magenta Channel";
				rename(imageTitle + " (magenta)");
				}
				
		//Identifies the Yellow Composite Channel
		if (ChannelFinder[z] == 102){
				ChannelFinder[z] = "Yellow Channel";
				rename(imageTitle + " (yellow)");
}}}


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//AUTO-THRESHOLD CHANNEL SELECTOR: Based on which channel color was selected in the menu the proper channel will be selected for thresholding//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Lowercolors = newArray("green", "red", "blue", "gray", "cyan", "magenta", "yellow");
Uppercolors = newArray("Green", "Red", "Blue", "Gray", "Cyan", "Magenta", "Yellow");

for (i = 0; i < 7; i++) {

	if (MainChannel == Uppercolors[i]) {
						
		//Check if image is open. Ends process and provides an error message. 
		channelfind = isOpen(imageTitle + " (" + Lowercolors[i] +")" );
		
			if (channelfind == false) {
		
				close("*");
				//Error Message Box
				showMessage("ERROR: THIS IMAGE DOES NOT HAVE A " + toUpperCase(Uppercolors[i]) + " CHANNEL");
			}

	else {
		//Prepares image for thresholding:
		selectWindow(imageTitle+ " ("+Lowercolors[i]+")");
		run("Duplicate...", "title=Thresholded");
			
		//Threshold and Analyze Particles! Uses the selected threshold method.
   		run("Auto Threshold", Thresholdformat); 


		//Below checks to see if process check was selected. If so a prompt appears. Selecting "End Process" terminates the macro.
    	if (ProcessCheck == true) {
    		setLocation(900, 300);
    		//if and else if statement below scale large images for side-by-side comparison
			Image_Width = getWidth();
			if (Image_Width >= 1000) {
				run("Out [-]");
				run("Out [-]");
				run("Out [-]");
				}
			else if(Image_Width >= 700) {
				run("Out [-]");
				run("Out [-]");
				}
    		selectWindow(imageTitle+ " ("+Lowercolors[i]+")");
    		//if and else if statement below scale large images for side-by-side comparison
    		Image_Width = getWidth();
			if (Image_Width >= 1000) {
				run("Out [-]");
				run("Out [-]");
				run("Out [-]");
				}
			else if(Image_Width >= 700) {
				run("Out [-]");
				run("Out [-]");
				}
    		setLocation(350, 300);
    		selectImage("Thresholded");
   			Dialog.create("Post-Thresholding Image Check");
   			Dialog.addChoice("Continue Analysis?", ProcessDecision);
   			Dialog.setLocation(750,50);
   			Dialog.show();
   			Endprocess = Dialog.getChoice();

   				if (Endprocess == "End Process") { 
   					close("*"); 
   					exit;
   					}
   			
    		selectWindow("Thresholded");
    		rename(imageTitle);
    		run("Analyze Particles...", "size=Minsize-Maxsize circularity=Circmin-Circmax summarize add"); //The minimum and maximum particle size ranges are recalled to gate for size
    		Dialog.create("Post-Particle Analysis Check")
   			Dialog.addChoice("Continue Analysis?", ProcessDecision);
   			Dialog.setLocation(750,50);
   			Dialog.show();
   			Endprocess = Dialog.getChoice();

   				if (Endprocess == "End Process") { 
   					roiManager("Delete");
   					close("*"); 
   					exit;
   					}
   			else {
 				close();}
    	}
    	
   		else if (ProcessCheck == false) {
   		selectWindow("Thresholded");
    	rename(imageTitle);
   		run("Analyze Particles...", "size='Minsize'-'Maxsize' circularity=Circmin-Circmax summarize add"); //The minimum and maximum particle size ranges are recalled to gate for size
 		close();
    	}
	}}}

    
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//MEASUREMENT STEP: For each channel color selected the stored ROIs are overlaid and measured on the respective channel.//
//Data from each measurement appears in a data table that is renamed to the corresponding channel color.                //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//If no ROIs are detected an error message appears. No measurments will be taken if this happens.
roitotal = roiManager("count");
	if (roitotal == 0) {
		close("*");
		//Error Message Box
		Dialog.create("ERROR!");
		Dialog.addMessage("NO ROIS DETECTED DURING ANALYSIS!");
		Dialog.show();
	}

	else {

/////////////////////////////////
//Measurement of green channel://
/////////////////////////////////

if (greenstate==true) {

//This checks to see if the image has a Green channel! If it doesn't an error message appears before ending the analysis.
	greenopen = isOpen(imageTitle+" (green)");
	if (greenopen == false) {
		close("*");
		//Error Message Box
		showMessage("ERROR: THIS IMAGE DOES NOT HAVE A GREEN CHANNEL. EXCLUDED FROM ANALYSIS.")
}
	else {
  	
  	selectWindow(imageTitle+" (green)");
  	roiManager("measure");
    IJ.renameResults("Green");
  	}}
  	
////////////////////////////////
//Measurement of red channel://
///////////////////////////////
  
if (redstate==true) {

//This checks to see if the image has a Red channel! If it doesn't an error message appears before ending the analysis.
	redopen = isOpen(imageTitle+" (red)");
	if (redopen == false) {
		close("*");
		//Error Message Box:
		showMessage("ERROR: THIS IMAGE DOES NOT HAVE A RED CHANNEL. EXCLUDED FROM ANALYSIS.");
}
	else {
  	
  	selectWindow(imageTitle+" (red)");
  	roiManager("measure");
    IJ.renameResults("Red");
  	}}

////////////////////////////////
//Measurement of blue channel://
////////////////////////////////

if (bluestate==true) {

//This checks to see if the image has a Blue channel! If it doesn't an error message appears before ending the analysis.
	blueopen = isOpen(imageTitle+" (blue)");
	
	if (blueopen == false) {
		close("*");
		//Error Message Box:
		showMessage("ERROR: THIS IMAGE DOES NOT HAVE A BLUE CHANNEL. EXCLUDED FROM ANALYSIS.");
}
	else {
  	  	selectWindow(imageTitle+" (blue)");
  		roiManager("measure");
    	IJ.renameResults("Blue");
  		}}
  	
////////////////////////////////
//Measurement of gray channel://
////////////////////////////////

if (graystate==true) {

//This checks to see if the image has a Gray channel! If it doesn't an error message appears before ending the analysis.
	grayopen = isOpen(imageTitle+" (gray)");
	if (grayopen == false) {
		close("*");
		//Error Message Box:
		showMessage("ERROR: THIS IMAGE DOES NOT HAVE A GRAY CHANNEL. EXCLUDED FROM ANALYSIS.");
		}
	else {
  	
  		selectWindow(imageTitle+" (gray)");
  		roiManager("measure");
    	IJ.renameResults("Gray");
  		}}

////////////////////////////////
//Measurement of cyan channel://
////////////////////////////////

if (cyanstate==true) {

//This checks to see if the image has a Cyan channel! If it doesn't an error message appears before ending the analysis.
	cyanopen = isOpen(imageTitle+" (cyan)");
	
	if (cyanopen == false) {
		close("*");
		//Error Message Box:
		showMessage("ERROR: THIS IMAGE DOES NOT HAVE A CYAN CHANNEL. EXCLUDED FROM ANALYSIS.");
}
	else {
  		selectWindow(imageTitle+" (cyan)");
  		roiManager("measure");
    	IJ.renameResults("Cyan");
  		}}

///////////////////////////////////
//Measurement of magenta channel://
///////////////////////////////////

if (magentastate==true) {
  
	//This checks to see if the image has a Magenta channel! If it doesn't an error message appears before ending the analysis.
	magentaopen = isOpen(imageTitle+" (magenta)");
	
	if (magentaopen == false) {
		close("*");
		//Error Message Box:
		showMessage("ERROR: THIS IMAGE DOES NOT HAVE A MAGENTA CHANNEL. EXCLUDED FROM ANALYSIS.");
	
}
	else {
  	 	selectWindow(imageTitle+" (magenta)");
  		roiManager("measure");
    	IJ.renameResults("Magenta");
  		}}
  	
//////////////////////////////////
//Measurement of yellow channel://
//////////////////////////////////

if (yellowstate==true) {

//This checks to see if the image has a yellow channel! If it doesn't an error message appears before ending the analysis.
	yellowopen = isOpen(imageTitle+" (yellow)");
	if (yellowopen == false) {
		close("*");
		//Error Message Box:
		showMessage("ERROR: THIS IMAGE DOES NOT HAVE A YELLOW CHANNEL. EXCLUDED FROM ANALYSIS.");
}
	else {
  	  	selectWindow(imageTitle+" (yellow)");
  		roiManager("measure");
    	IJ.renameResults("Yellow");
  		}}
}


//This clears the ROI manager for the next image
	if (roitotal == 0) {
	}
	else {
		roiManager("Delete");
	}
	
	if ("Show Processed Image" == false); {
		//Closes ALL open images
		close("*");
	}
}

/////////////////////////////////////////////////////////////////////////////////////////
//BATCH LOOP!////////////////////////////////////////////////////////////////////////////
//If the Batch Process Option was selected then the following process is carried out. ///
/////////////////////////////////////////////////////////////////////////////////////////

else {
	
	//Closes all open images
	close("*");

	dir = getDirectory("Choose a Directory ");
    list = getFileList(dir);

setBatchMode(true);
Batchstate = true;	
wait(5);
	 	
		//Batch Loop!
	 	for (i=0; i<list.length; i++) {
        	path = dir+list[i];
        	showProgress(i, list.length);
        		
        		if (!endsWith(path,"/")) open(path);
        		if (nImages>=1) {

					if (ProcessCheck == true) { setBatchMode(false);}
        			
        			getDimensions(width, height, channels, slices, frames);
					CompositeCheck = is("composite");
					imageTitle=getTitle();
        			run("Split Channels");



				if (i == 0) {
					if (ScaleSettings == true) {
					run("Set Scale...");
					}
				}


//Composite Image Check and Processer//

if (CompositeCheck == true){

	ChannelFinder = newArray("ChannelOne", "ChannelTwo", "ChannelThree", "ChannelFour", "ChannelFive", "ChannelSix", "ChannelSeven"); 

	//Each channel in the default 7 channels has a set foreground color allowing the color to be identified 
	//For reference the foreground colors are: Green = 204, Red = 0, Blue = 255, Grey = 153, Magenta = 127, Cyan = 229, Yellow = 102 
	for (z = 0; z < channels; z++) {

		//Changes the active channel
		selectWindow("C" + z+1 + "-" + imageTitle);
	
		//Saves foreground color as an indictor to the channel ID
		ChannelFinder[z] = getValue("color.foreground");	

		//Identifies the Green Composite Channel
		if (ChannelFinder[z] == 204){
			ChannelFinder[z] = "Green Channel";
			rename(imageTitle + " (green)");
		}
		//Identifies the Red Composite Channel
	 	if (ChannelFinder[z] == 0){
	 		ChannelFinder[z] = "Red Channel";
	 		rename(imageTitle + " (red)");
		}
		//Identifies the Blue Composite Channel
	 	if (ChannelFinder[z] == 255){
			ChannelFinder[z] = "Blue Channel";
			rename(imageTitle + " (blue)");
		}
		//Identifies the Grey Composite Channel
		if (ChannelFinder[z] == 153){
			ChannelFinder[z] = "Gray Channel";
			rename(imageTitle + " (gray)");
		}
		//Identifies the Cyan Composite Channel
		if (ChannelFinder[z] == 229){
			ChannelFinder[z] = "Cyan Channel";
			rename(imageTitle + " (cyan)");
		}
		//Identifies the Magenta Composite Channel
		if (ChannelFinder[z] == 127){
			ChannelFinder[z] = "Magenta Channel";
			rename(imageTitle + " (magenta)");
		}
		//Identifies the Yellow Composite Channel
		if (ChannelFinder[z] == 102){
			ChannelFinder[z] = "Yellow Channel";
			rename(imageTitle + " (yellow)");
		}}}

//Image processing loop: Auto-threshold + Particle Analysis
Lowercolors = newArray("green", "red", "blue", "gray", "cyan", "magenta", "yellow");
Uppercolors = newArray("Green", "Red", "Blue", "Gray", "Cyan", "Magenta", "Yellow");

for (j = 0; j < 7; j++) {

	if (MainChannel == Uppercolors[j]) {
						
	//Check if image is open. Ends process and provides an error message. 
	channelfind = isOpen(imageTitle + " (" + Lowercolors[j] +")" );
		if (channelfind == false) {
		
			close("*");
			//Error Message Box
			showMessage("ERROR: THIS IMAGE DOES NOT HAVE A " + toUpperCase(Uppercolors[j]) + " CHANNEL");
}

	else {
		//Prepares image for thresholding:
		selectWindow(imageTitle+ " ("+Lowercolors[j]+")");
		run("Duplicate...", "title=Thresholded");
			
		//Threshold and Analyze Particles!
   		run("Auto Threshold", Thresholdformat); 

		//Below checks to see if process check was selected. If so a prompt appears. Selecting "End Process" terminates the macro.
    	if (ProcessCheck == true) {
    		setLocation(900, 300);
    		//selectImage(OrignalImage);
    		selectWindow(imageTitle+ " ("+Lowercolors[j]+")");
    		setLocation(350, 300);
    		//if and else if statement below scale large images for side-by-side comparison
			Image_Width = getWidth();
			if (Image_Width >= 1000) {
				run("Out [-]");
				run("Out [-]");
				run("Out [-]");
				}
			else if(Image_Width >= 700) {
				run("Out [-]");
				run("Out [-]");
				}
    		selectImage("Thresholded");
    		//if and else if statement below scale large images for side-by-side comparison
			Image_Width = getWidth();
			if (Image_Width >= 1000) {
				run("Out [-]");
				run("Out [-]");
				run("Out [-]");
				}
			else if(Image_Width >= 700) {
				run("Out [-]");
				run("Out [-]");
				}
			setBatchMode(false); //BatchMode set to false so images can be viewed during process check
   			Dialog.create("Post-Thresholding Image Check")
   			Dialog.setLocation(750,50);
   			Dialog.addChoice("Continue Analysis?", ProcessDecision);
   			Dialog.show();
   			Endprocess = Dialog.getChoice();

   				if (Endprocess == "End Process") { 
   					close("*"); 
   					print("Process ended on: " + imageTitle);
   					exit;
   					}
   			
    		selectWindow("Thresholded");
    		rename(imageTitle); //Resets image name. This makes the name accurate rather than "thresholded" in the Summary
    		run("Analyze Particles...", "size=Minsize-Maxsize circularity=Circmin-Circmax summarize add"); //The minimum and maximum particle size ranges are recalled to gate for size
    		Dialog.create("Post-Particle Analysis Check")
   			Dialog.addChoice("Continue Analysis?", ProcessDecision);
   			setBatchMode(true);
   			Dialog.setLocation(750,50);
   			Dialog.show();
   			Endprocess = Dialog.getChoice();

   				if (Endprocess == "End Process") { 
   					roiManager("Delete");
   					close("*"); 
   					print("Process ended on: " + imageTitle);
   					exit;
   					}
   			else {
 				close();}
    	}
    	
   		else if (ProcessCheck == false) {
   			selectWindow("Thresholded");
    		rename(imageTitle);
   			run("Analyze Particles...", "size=Minsize-Maxsize circularity=Circmin-Circmax summarize add"); //The minimum and maximum particle size ranges are recalled to gate for size
 			close();
    		}
		}}}
        		}

 
//MEASUREMENT STEP: For each channel color selected the stored ROIs are overlaid and measured on the respective channel.
//Data from each measurement appears in a data table that is renamed to the corresponding channel color.                


//If no ROIs are detected an error message appears. No measurments will be taken if this happens.
roitotal = roiManager("count");
	if (roitotal == 0) {
		close("*");
		//Error Message Box
		print("No ROIs detected during analysis of " + imageTitle); 
		}

	else {

/////////////////////////////////
//Measurement of green channel://
/////////////////////////////////

if (greenstate==true) {
wait(3);
//This checks to see if the image has a Green channel! If it doesn't an error message appears before ending the analysis.
	greenopen = isOpen(imageTitle+" (green)");
	if (greenopen == false) {
		close("*");
		//Error Message Box
		print("ERROR: " + imageTitle +  " does not have a GREEN channel. Excluded from analysis.");
}
	else {
		if (i>0) {
			selectWindow("Green Results");
			Table.rename("Green Results","Results");
		}
  	
  		selectWindow(imageTitle+" (green)");
  		roiManager("measure");
    	IJ.renameResults("Green Results");
  	}}
  	
////////////////////////////////
//Measurement of red channel://
///////////////////////////////
  
if (redstate==true) {
wait(3);
//This checks to see if the image has a Red channel! If it doesn't an error message appears before ending the analysis.
	redopen = isOpen(imageTitle+" (red)");
	if (redopen == false) {
		close("*");
		//Error Message Box:
		print("ERROR: " + imageTitle +  " does not have a RED channel. Excluded from analysis.");
}
	else {
  		if (i>0) {
			selectWindow("Red Results");
			Table.rename("Red Results","Results");
		}
  	selectWindow(imageTitle+" (red)");
  	roiManager("measure");
    IJ.renameResults("Red Results");
  	}}

////////////////////////////////
//Measurement of blue channel://
////////////////////////////////

if (bluestate==true) {
wait(3);
//This checks to see if the image has a Blue channel! If it doesn't an error message appears before ending the analysis.
	blueopen = isOpen(imageTitle+" (blue)");
	if (blueopen == false) {
		close("*");
		//Error Message Box:
		print("ERROR: " + imageTitle +  " does not have a  BLUE channel. Excluded from analysis.");
}
	else {
  		if (i>0) {
			selectWindow("Blue Results");
			Table.rename("Blue Results","Results");
		}
  	selectWindow(imageTitle+" (blue)");
  	roiManager("measure");
    IJ.renameResults("Blue Results");
  	}}
  	
////////////////////////////////
//Measurement of gray channel://
////////////////////////////////

if (graystate==true) {
wait(3);
//This checks to see if the image has a Gray channel! If it doesn't an error message appears before ending the analysis.
	grayopen = isOpen(imageTitle+" (gray)");
	if (grayopen == false) {
		close("*");
		//Error Message Box:
		print("ERROR: " + imageTitle +  " does not have a GRAY channel. Excluded from analysis.");
}
	else {
  	  if (i>0) {
			selectWindow("Gray Results");
			Table.rename("Gray Results","Results");
		}
  	selectWindow(imageTitle+" (gray)");
  	roiManager("measure");
    IJ.renameResults("Gray Results");
  	}}

////////////////////////////////
//Measurement of cyan channel://
////////////////////////////////

if (cyanstate==true) {
wait(3);
//This checks to see if the image has a Cyan channel! If it doesn't an error message appears before ending the analysis.
	cyanopen = isOpen(imageTitle+" (cyan)");
	if (cyanopen == false) {
		close("*");
		//Error Message Box:
		print("ERROR: " + imageTitle +  " does not have a CYAN channel. Excluded during analysis.");
}
	else {
  	  if (i>0) {
			selectWindow("Cyan Results");
			Table.rename("Cyan Results","Results");
		}
  	selectWindow(imageTitle+" (cyan)");
  	roiManager("measure");
    IJ.renameResults("Cyan Results");
  	}}

///////////////////////////////////
//Measurement of magenta channel://
///////////////////////////////////

if (magentastate==true) {
wait(3);
	//This checks to see if the image has a Magenta channel! If it doesn't an error message appears before ending the analysis.
	magentaopen = isOpen(imageTitle+" (magenta)");
	if (magentaopen == false) {
		close("*");
		//Error Message Box:
		print("ERROR: " + imageTitle +  " does not have a MAGENTA channel. Excluded from analysis.");
	
}
	else {
  	  if (i>0) {
			selectWindow("Magenta Results");
			Table.rename("Magenta Results","Results");
		}
  	selectWindow(imageTitle+" (magenta)");
  	roiManager("measure");
    IJ.renameResults("Magenta Results");
  	}}
  	
//////////////////////////////////
//Measurement of yellow channel://
//////////////////////////////////

if (yellowstate==true) {
wait(3);
//This checks to see if the image has a yellow channel! If it doesn't an error message appears before ending the analysis.
	yellowopen = isOpen(imageTitle+" (yellow)");
	if (yellowopen == false) {
		close("*");
		//Error Message Box:
		print("ERROR: " + imageTitle +  " does not have a YELLOW channel. Excluded from analysis.");
}
	else {
  	 if (i>0) {
			selectWindow("Yellow Results");
			Table.rename("Yellow Results","Results");
		}
  	selectWindow(imageTitle+" (yellow)");
  	roiManager("measure");
    IJ.renameResults("Yellow Results");
  	}}
}


//This clears the ROI manager for the next image
	if (roitotal == 0) {

	}
	else {
		roiManager("Delete");
	}
	
	if ("Show Processed Image" == false); {
		
		//Closes ALL open images
		close("*");
	}
}}

if (Batchstate == true) {
Dialog.create("COMPLETE");
Dialog.addMessage("Batch Analysis Complete!");
Dialog.show();}
//End of batch loop










