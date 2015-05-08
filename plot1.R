# plot1.R
# Plots a Histogram to plot1.png using the base plotting system. 
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

# Get/Setup PNG file Graphics device
png(file="plot1.png", width=480, height=480, units="px")

# Plot a histogram of Global Active Power
hist(data[,3], xlab="Global Active Power (kilowatts)", 
     main="Global Active Power", col="red")

# Tear down device
dev.off()

