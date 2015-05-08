# plot4.R
# Plots a Line Graph to plot4.png using the base plotting system. 
# This program uses the SQLDF library to reduce how much data is loaded by R

library(sqldf)

# Data file location
file <- "../data/household_power_consumption.txt"

# Use read.csv.sql from the SQLDF library to get only records with Dates 
# between 2007-02-01 and 2007-02-02. 
data<-read.csv.sql(file, header=T, sep=";", 
        sql="select * from file where Date = '1/2/2007' or Date = '2/2/2007'",
        colClasses=c("character","character","numeric","numeric","numeric",
                    "numeric","numeric","numeric","numeric"))

# Convert "?" to NAs
is.na(data)<-data == "?"

# Convert Date and time columns to DateTime types
date_time<-strptime(paste(data[,1],data[,2]),format="%d/%m/%Y %H:%M:%S")

# Get device
 png(file="plot4.png", width=480, height=480, units="px")

# Set plotting parameters for the layout to 2 rows x 2 columns
par(mfrow=c(2,2))

# plot location: 1,1
# plot a line graph - DateTime vs Global Active Power
plot(date_time, data[,3], ylab="Global Active Power", xlab="", type="l")

# plot location: 1,2
# plot a line graph - DateTime vs Voltage
plot(date_time, data[,5], ylab="Voltage", xlab="datetime", type="l")

# plot location: 2,1
# Plot a line graph - DateTime vs Energy sub metering
plot(date_time, data[,7], xlab="", ylab="", type="l")
lines(date_time, data[,8], xlab="", ylab="", col="red")
lines(date_time, data[,9], xlab="", ylab="", col="blue")

# Add title
title(ylab="Energy sub metering")

# Add Legend
legend("topright", legend=names(data)[7:9],lty=1, col=c("black","red","blue") )

# plot location: 2,2 
# Plot a line graph - DateTime vs Global reactive power
plot(date_time, data[,4], 
     ylab="Global_reactive_power", xlab="datetime", type="l")

# Tear down device
 dev.off()
