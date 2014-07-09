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


# Line plot of Sub_metetering_{1,2,3} with black,red,and blue lines respective
# No dataSet-label or title, explicit y-label, and a legend using colored lines = to line color.
PlotIt_3 <- function(dataSet) 
{
  with(dataSet, 
{
  # Set up the canvas
  plot(datetime, Sub_metering_1, type = "n", xlab = "",
       ylab = "Energy sub metering")
  
  #set colors
  colors <- c("black", "red", "blue")
  
  # Set variables to Sub_metering_1, Sub..._2, ..._3; note paste0 is SOOOO much easier than paste()!
  variables <- paste0("Sub_metering_", 1:3)
  
  # Loop and draw the lines for each variable
  for (i in seq_along(variables)) 
  {
    var <- variables[i] ## Name of the variable we want as a string
    
    # REMINDER: Doublke-bracket access is by name, not index
    data <- dataSet[[var]]
    lines(datetime, data, col=colors[i])
  }
  
  legend("topright",
         legend = variables, ## Names of items in legend
         col = colors, ## Set colors explicitly
         lty = "solid" ## Draw solid lines next to each entry
  )
}) # end of with() block
}

dataSet <- LoadData("./household_power_consumption.txt")

png("plot3.png", width=480, height=480)
PlotIt_3(dataSet)
dev.off()