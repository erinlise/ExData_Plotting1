## Load household power consumption data into R, convert dates and times to R
## formats, and subset for data from Feb 1st and 2nd, 2007.
classes<-c("factor","factor","numeric","numeric","numeric",
           "numeric","numeric","numeric","numeric")
powerDF<-read.table("household_power_consumption.txt", sep = ";", header = TRUE,
                    na.strings = "?", colClasses = classes)
powerDF$Time<-strptime(paste(powerDF$Date, powerDF$Time), "%d/%m/%Y %H:%M:%S")
powerDF$Date<-strptime(powerDF$Date,"%d/%m/%Y")
powerSUB<-subset(powerDF, as.Date(powerDF$Time) == as.Date("2007-02-01") |
                         as.Date(powerDF$Time) == as.Date("2007-02-02"))

## Create and open .png device for plotting the chart
dev.off()
png(filename = "plot4.png")

## Set layout parameters.
par(mfcol=c(2,2), mar = c(5.1,4.1,4.1,2.1))

## Plot 1, Global active power
plot(powerSUB$Time, powerSUB[,3], type="n", xlab="",
     ylab="Global Active Power")
lines(powerSUB$Time, powerSUB[,3])

## Plot 2, Energy sub-metering
plot(powerSUB$Time, powerSUB[,7], type="n", xlab="",
     ylab="Energy sub metering")
lines(powerSUB$Time, powerSUB[,7])
lines(powerSUB$Time, powerSUB[,8], col = "red")
lines(powerSUB$Time, powerSUB[,9], col = "blue")
legend("topright", lwd=1, col=c("black","red","blue"), legend = 
               c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Plot 3, Voltage
plot(powerSUB$Time, powerSUB[,5], type="n", xlab="datetime",
     ylab="Voltage")
lines(powerSUB$Time, powerSUB[,5])

## Plot 4, Global
plot(powerSUB$Time, powerSUB[,4], type="n", xlab="datetime",
     ylab="Global_reactive_power")
lines(powerSUB$Time, powerSUB[,4])

## Close the .png device
dev.off()