# This file downloads and loads the dataset
# referenced in the README of this project

# Sequence
# Step 1: If the file already exists, skip to Step 5
# Step 2: If the directory '/data' doesn't exist, create it
# Step 3: Download data
# Step 4: unzip data
# Step 5: load data appropriately

if (! file.exists("../data/household_power_consumption.txt"))
{
  
  #no text file...do we have the zipfile?
  if (! file.exists("../data/household_power_construction.zip"))
  {
    
    #we don't even have the zip file! IT DOWNLOADZ IT!!!!
    #but we can't download it into the directory we want if the directory
    #isn't there...is the directory there?
    if (! file.exists("../data/"))
    {
      
      #Shit, man! Create the damned directory! CREATE!
      dir.create("../data/")
    }
    
    #NOWITDOWNLOADZTHEFILEZ!!!!!
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url = fileUrl, destfile = "../data/household_power_consumption.zip", method = "wget")
  }
  
  #If we have the zip file, but not the text file, what do we do?
  #...
  #...?
  #*sigh* Unzip it. Good boy. Clean the drool off of your Chin.
  #
  #By the way, I love how you unzip shit in R. Unzip(shit, putshit). So simple && elegant.
  unzip(zipfile = "../data/household_power_consumption.zip", exdir = "../data/")
}

# So...you have a file. Isn't that special. If you looked at the file, you already know we 
# only need to load very specific rows - namely, Jul 1 2007 - Jul 2 2007. See how I wrote those
# dates? How very european of me.
powerData <- read.table(file="../data/household_power_consumption.txt", 
                        sep=";", header=F, na.strings = "?", nrows = 2880, skip = 66637)

#note we had no column names because headers = false. Ergo, name zee columns






