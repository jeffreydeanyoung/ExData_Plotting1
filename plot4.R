# Exploratory Data Analysis - Assignment 1 - Plot 4
# Student: Jeffrey D. Young
# Date: November 7, 2015

# raw data located in subdirectory call "data"
# loading full table takes about 17 seconds (file located on network drive)
alldat <- read.table("data/household_power_consumption.txt",header=TRUE,sep=";",
                     colClasses = c("character","character","numeric","numeric",
                                    "numeric","numeric","numeric","numeric","numeric"),
                     na.strings="?")

# convert dates and times
alldat$datetime <- strptime(paste(alldat$Date,alldat$Time),"%d/%m/%Y %H:%M:%S")
alldat$Date <- strptime(alldat$Date,"%d/%m/%Y")

# subset data for dates Feb 1, 2007 an Feb 2, 2007 (2880 obs left)
subdata <- alldat[alldat$Date %in% c(as.POSIXlt("2007-02-01"),as.POSIXlt("2007-02-02")),]

# direct plotting to PNG file
png(filename="plot4.png",width=480,height=480)

# plot 4 - various
par(mfcol=c(2,2))

# subplot 1 - line plot of Global Active Power (kilowatts) over time
plot(subdata$datetime,subdata$Global_active_power,
     type="l",
     xlab=" ",
     ylab="Global Active Power"
)

# subplot 2 - line plots of Energy sub metering (overlayed)
plot(subdata$datetime,subdata$Sub_metering_1,
     type="l",
     xlab=" ",
     ylab="Energy sub metering"
)
lines(subdata$datetime,subdata$Sub_metering_2,col="red")
lines(subdata$datetime,subdata$Sub_metering_3,col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"),
       lty=1,
       bty="n"
)

# subplot 3 - voltage over time
plot(subdata$datetime,subdata$Voltage,
     xlab="datetime",
     ylab="Voltage",
     type="l")

# subplot 4 - Global Reactive Power over time
plot(subdata$datetime,subdata$Global_reactive_power,
     xlab="datetime",
     ylab="Global_reactive_power",
     type="l")

# close plot file
dev.off()



