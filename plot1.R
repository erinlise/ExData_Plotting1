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
png(filename = "plot1.png")

## Create the plot
hist(powerSUB[,3], col = "red", xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")

## Close the .png device
dev.off()