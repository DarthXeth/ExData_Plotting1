# Data URL:
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

# Load and filter household power consumption dataset
LoadData <- function(file) 
{  
  # Just read the whole file and subset. remember to set the NA variable
  powerData <- read.table(file, sep = ";", header = T, na.strings = "?")
  
  # Create a new "datetime" column by combining the Date and Time columns
  powerData$datetime <- strptime(paste(powerData$Date, powerData$Time), "%d/%m/%Y %H:%M:%S")
  
  # Return only the subset of dates we are interested in as given
  # in the assignment description
  dates <- c(as.Date("2007-02-01"), as.Date("2007-02-02"))
  powerData[as.Date(powerData$datetime) %in% dates,]
}


# A more complicated four panel plot
PlotIt_4 <- function(x) {
  par(mfrow = c(2, 2))
  with(x, {
    ### Subplot 1 (top left)
    # This is basically plot 1, with label changes
    plot(datetime, Global_active_power, type = "l", xlab = "",
         ylab = "Global Active Power")
    
    ### Subplot 2, pretty straight-forward
    plot(datetime, Voltage, type = "l", xlab = "datetime", ylab="Voltage")
    
    ### Subplot 3
    plot(datetime, Sub_metering_1, type = "n", xlab = "",
         ylab = "Energy sub metering")
    
    colors <- c("black", "red", "blue")
    # Set variables to Sub_1, Sub..._2, etc
    variables <- paste0("Sub_metering_", 1:3)
    
    # Loop and draw lines
    for (i in seq_along(variables)) 
    {
      var <- variables[i] 
      # Use of double-brackets = by name, not index.
      data <- x[[var]]
      lines(datetime, data, col = colors[i])
    }
    
    legend("topright",
           bty = "n", ## No border around the legend
           legend = variables,
           col = colors, ## Set colors rather than rely on defaults
           lty = "solid" ## solid lines
    )
    
    ### Subplot 4 (bottom right)
    plot(datetime, Global_reactive_power, type = "l")
    
  }) # end of with() block
}

dataSet <- LoadData("./household_power_consumption.txt")

png("plot4.png", width = 480, height= 480)
PlotIt_4(dataSet)
dev.off()