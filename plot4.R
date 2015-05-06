## Read the column names
c.names <- read.table("household_power_consumption.txt", sep = ";", nrows = 1,
                      colClasses = "character")

## Read the data from just the dates 2007-02-01 and 2007-02-02
power <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", 
                    col.names = c.names, skip = 66636, nrows = 2880)

## Verify that the data starts with 1/2/2007 00:00:00 
head(power)
## Verify that the data ends with 2/2/2007 23:59:00 
tail(power)

## Convert the Date and Time variables to Date/Time classes in R
DateTime <- strptime(paste(as.character(power$Date), as.character(power$Time)),
                     format="%d/%m/%Y %H:%M:%S")

## Open PNG file device and create "plot4.png" with aspect ratio 480x480
png(filename = "plot4.png", width = 480, height = 480)

## Create 2x2 multiple base plots
par(mfcol = c(2,2))

## Create plots and send to PNG file device
plot(DateTime, power$Global_active_power, type = "l", 
     xlab = "", ylab = "Global Active Power (kilowatts)")

plot(DateTime, power$Sub_metering_1, type = "l", 
     xlab = "", ylab = "Energy sub metering")
lines(DateTime, power$Sub_metering_2, type = "l", col = "red")
lines(DateTime, power$Sub_metering_3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1,1,1), col = c("black", "red", "blue"), bty = "n")
       
plot(DateTime, power$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")

plot(DateTime, power$Global_reactive_power, type = "l", xlab = "datetime", 
     ylab = "Global_reactive_power")

## Close the PNG file device
dev.off()
