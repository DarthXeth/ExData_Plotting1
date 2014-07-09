# Data URL:
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip


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


# This time we make a line plot of global active power with no x-label or title, 
# set y explicitly, no legend
PlotIt_2 <- function(dataset) 
{
  with(dataset, 
  {
    plot(datetime, Global_active_power, type = "l", xlab = "",
         ylab = "Global Active Power (kilowatts)")
  })
}

dataset <- LoadData("./household_power_consumption.txt")

png("plot2.png", width=480, height=480)
PlotIt_2(dataset)
dev.off()