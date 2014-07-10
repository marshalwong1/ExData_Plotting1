# Load data - Assumes that raw data file is in the directory above the working directory
data <- read.csv2("../household_power_consumption.txt", dec=".", na.strings="?")

# Adds the convertedDate and convertedDateTime fields and populates with appropriate information from the raw Date and Time fields
data$convertedDate <- as.Date(data$Date, format = "%d/%m/%Y")
data$convertedDateTime <- strptime(paste(data$convertedDate, data$Time), format = "%Y-%m-%d %H:%M:%S")

# Subsets only the date 2007-02-01 and 2007-02-02
plotdata <- data[data$convertedDate >= "2007-02-01" & data$convertedDate <= "2007-02-02", ]

png(file = "plot4.png")  ## Open PNG device; create 'plot4.png' in working directory; default size is 480x480

# Sets 2x2 graphing grid area
par(mfrow = c(2, 2))

# Top Left plot
# plots a line graph of the Global Active Power (y axis) by datetime (x axis) using the convertedDateTime field
plot(plotdata$convertedDateTime, plotdata$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")

# Top Right plot
# plots a line graph of the Voltage (y axis) by datetime (x axis) using the convertedDateTime field
plot(plotdata$convertedDateTime, plotdata$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")

# Bottom Left plot
# plots a line graph of the Sub_metering_1, 2, 3 (y axis) by datetime (x axis) using the convertedDateTime field with legend in top right
# Sub_metering_1 is black, Sub_metering_2 is red, Sub_metering_3 is blue
plot(plotdata$convertedDateTime, plotdata$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(plotdata$convertedDateTime, plotdata$Sub_metering_2, col = "red")
lines(plotdata$convertedDateTime, plotdata$Sub_metering_3, col = "blue")
legend("topright", lty = "solid", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")

# Bottom Right plot
# plots a line graph of the Global_reactive_power (y axis) by datetime (x axis) using the convertedDateTime field
plot(plotdata$convertedDateTime, plotdata$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")

dev.off()  ## close out PNG device and write to file