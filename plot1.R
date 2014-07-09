# Data URL:
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# This script attempts to recreate the plot1.png sourced at:
# https://github.com/rdpeng/ExData_Plotting1/raw/master/figure/unnamed-chunk-2.png

# Load and filter household power consumption dataset
LoadData <- function(file) 
{  
  # Just read the whole file and subset. remember to set the NA variable
  powerData <- read.table(file, sep=";", header=T, na.strings="?")
  
  # Create a new "datetime" column by combining the Date and Time columns
  powerData$datetime <- strptime(paste(powerData$Date, powerData$Time), "%d/%m/%Y %H:%M:%S")
  
  # Return only the subset of dates we are interested in as given
  # in the assignment description
  dates <- c(as.Date("2007-02-01"), as.Date("2007-02-02"))
  powerData[as.Date(powerData$datetime) %in% dates,]
}


# Red histogram of global active power with modified x-axis label and title, default y-label, no legend
plotIt <- function(dataset) 
{
  hist(dataset$Global_active_power, 
       col = "red",
       main = "Global Active Power",
       xlab = "Global Active Power (kilowatts)")
  
}

powerData <- LoadData("./household_power_consumption.txt")

png("plot1.png", width=480, height=480)
plotIt(powerData)

dev.off()