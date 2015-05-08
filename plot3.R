# plot3.R
# Plots a Line Graph to plot3.png using the base plotting system. 
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
datetime <- strptime(paste(data[,1],data[,2]),format="%d/%m/%Y %H:%M:%S")

# Get device
png(file="plot3.png", width=480, height=480, units="px")

# Plot a line graph
plot(datetime, data[,7], xlab="", ylab="", type="l")

# Add a Line graph to existing plot
lines(datetime, data[,8], xlab="", ylab="", col="red")

# Add a Line graph to existing plot
lines(datetime, data[,9], xlab="", ylab="", col="blue")

# Add a title for the plot
title(ylab="Energy sub metering")

#Add Legend for the plot
legend("topright", legend=names(data)[7:9],lty=1, col=c("black","red","blue") )

# Tear down device
dev.off()
