
# Install the package "data.table" if you don't have it already by: 
# install.packages("data.table")

# Load the data.table package to facilitate reading the dataset
library(data.table)

# Read the dataset from 1/2/2007 00:00:00 to 3/2/2007 00:00:00
Data <- fread("household_power_consumption.txt", header = FALSE, sep = ";", 
              na.strings = "?", colClasses = c(rep("character", 2), rep("numeric", 7)), 
              skip = "1/2/2007", nrows = 2*24*60+1, col.names = c("Date", "Time", 
              "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity",
              "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Create datetime column as POSIXct 
Data$datetime <- as.POSIXct(paste(Data$Date, Data$Time), format = "%d/%m/%Y %H:%M:%S")

# Create plot on screen 
plot(Data$datetime, Data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
points(Data$datetime, Data$Sub_metering_2, type = "l", col = "red")
points(Data$datetime, Data$Sub_metering_3, type = "l", col = "blue")
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2", 
      "Sub_metering_3"), lty = 1, cex = 0.7)

# copy plot to png file (by default, it's 480x480 pixels)
dev.copy(png, file = "plot3.png")

# close png graphic device
dev.off()