# Load data - Assumes that raw data file is in the directory above the working directory
data <- read.csv2("../household_power_consumption.txt", dec=".", na.strings="?")

# Adds the convertedDate and convertedDateTime fields and populates with appropriate information from the raw Date and Time fields
data$convertedDate <- as.Date(data$Date, format = "%d/%m/%Y")
data$convertedDateTime <- strptime(paste(data$convertedDate, data$Time), format = "%Y-%m-%d %H:%M:%S")

# Subsets only the date 2007-02-01 and 2007-02-02
plotdata <- data[data$convertedDate >= "2007-02-01" & data$convertedDate <= "2007-02-02", ]

png(file = "plot2.png")  ## Open PNG device; create 'plot2.png' in working directory; default size is 480x480

# plots a line graph of the Global Active Power (y axis) by datetime (x axis) using the convertedDateTime field
plot(plotdata$convertedDateTime, plotdata$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

dev.off()  ## close out PNG device and write to file