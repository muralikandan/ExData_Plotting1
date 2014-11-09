## Reading the dataset:
ass3<-read.table("D:/Workspace/R-WD/data/Exploratory Data/Assignment1/household_power_consumption.txt",  sep=";", header=T, na.strings="?")
require(dplyr)
electric_dt<-tbl_df(ass3)
rm(ass3)
## Converting the date column to Date class:
electric_dt$Date<-as.Date(electric_dt$Date,"%d/%m/%Y")
## Fiter to only include the desired dates:
electric_dt<-filter(electric_dt,Date>="2007-02-01"& Date<="2007-02-02")

## Convert Date and Time columns to POSIXlt class:
electric_dt$Date <- as.POSIXlt(paste(electric_dt$Date, electric_dt$Time, sep=" "))


## Start a PNG device and plot all 3 submeterings vs. time
png("plot3.png", width=480, height=480)
par(mar=c(4.7, 4.7, 0.7, 0.7))

plot(electric_dt$Date, electric_dt$Sub_metering_1, type="n", lwd=1, 
     ylim=c(0, max(c(electric_dt$Sub_metering_1, electric_dt$Sub_metering_2, electric_dt$Sub_metering_3))),
     xlab="", ylab="Energy sub metering")

lines(electric_dt$Date, electric_dt$Sub_metering_1, col="black")
lines(electric_dt$Date, electric_dt$Sub_metering_2, col="red")
lines(electric_dt$Date, electric_dt$Sub_metering_3, col="blue")

legend("topright", lwd=1, 
       col=c("black", "red", "blue"), 
       legend=c("Sub metering 1", "Sub metering 2", "Sub metering 3"))
dev.off()