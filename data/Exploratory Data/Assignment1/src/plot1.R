## Reading the dataset:
ass3<-read.table("D:/Workspace/R-WD/data/Exploratory Data/Assignment1/household_power_consumption.txt",  sep=";", header=T, na.strings="?")
require(dplyr)
electric_dt<-tbl_df(ass3)
rm(ass3)
## Converting the date column to Date class:
electric_dt$Date<-as.Date(electric_dt$Date,"%d/%m/%Y")
## Fiter to only include the desired dates:
electric_dt<-filter(electric_dt,Date>="2007-02-01"& Date<="2007-02-02")
## Start a PNG device and plot GAP vs. time:
png("plot1.png", width=480, height=480)
options(warn=-1)
hist(as.numeric(electric_dt$Global_active_power),col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
options(warn=0)
dev.off()