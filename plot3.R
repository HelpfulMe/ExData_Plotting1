##LOAD DATA
##For this code to work please:
## - download the data zip file from 
##    https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
## - extract the data from the zip file
## - set your working directory to the location of the data
## - data file should be named "household_power_consumption.txt"

#_______________________________________________________________________

##READ DATA

#set the classes of the data we want to read in 
#to help save memory and increase speed
class <- c("character", "character", "numeric", "numeric", "numeric", 
           "numeric", "numeric", "numeric", "numeric")

##to read in the ENTIRE dataset and then subset the relevant dates:
##(commented out to allow reading in only the relevant records)
##I ran this code to learn the correct row numbers to import.  The uncommented code
##imports only the two dates we are working with

#data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", 
#                   na.strings = "?", colClasses = class, 
#                   stringsAsFactors = FALSE)

##subset data to only Feb 1, 2007 and Feb 2, 2007
#datesdata <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")

mydata <- read.table("household_power_consumption.txt", header = FALSE, sep = ";", 
                     skip = 66637, nrows = 2880, na.strings = "?", colClasses = class, 
                     stringsAsFactors = FALSE)
#data has meaningless column names (V1, V2, etc), give meaningful column names
mycolnames <- c("Date", "Time", "Global_active_power", "Global_reactive_power", 
                "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", 
                "Sub_metering_3")
names(mydata) <- mycolnames

#create a new column with date and time as POSIXct format
mydata$newdate <- with(mydata, as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"))

#_______________________________________________________________________

##CREATE EXPLORATORY CHART/ SAVE PLOT


png("plot3.png", width=480, height=480, units="px", res=72)
with(mydata, {
  plot(newdate, Sub_metering_1, type='l', xlab='', ylab="Energy sub metering")
  lines(newdate, Sub_metering_2, type='l', col='red')
  lines(newdate, Sub_metering_3, type='l', col='blue')
})
legend("topright", col=c("black", "red", "blue"), lty=c(1,1,1), lwd=c(1,1,1), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.8)
dev.off()

