# plot2.R
# Plots a Line Graph to plot2.png using the base plotting system. 
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

# Get/Setup PNG graphics device
png(file="plot2.png", width=480, height=480, units="px", bg = "transparent")

# Plot a line graph of datetime vs Global Active Power
plot(datetime, data[,3], 
     ylab="Global Active Power (kilowatts)", 
     xlab="", 
     type="l")

# Tear down graphic device
dev.off()
