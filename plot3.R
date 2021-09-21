# **Electric Power Consumption**
# **3. Base Plotting Example**
#########################
# This is "plot3.R"
#########################

## Install and load the libraries
install.packages("data.table")
install.packages("dplyr")
install.packages("tidyverse")
install.packages("stringr")    
library(data.table)
library(dplyr)
library(tidyverse)
library(stringr)

## Download the data (just bei the first plot)
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, dest="dataset.zip", mode="wb") 
unzip ("dataset.zip", exdir = "./dataset")
list.files("./dataset")

## Read the data
household_power_consumption <- data.table::fread("./dataset/household_power_consumption.txt", head=TRUE,
                                                 col.names=as.character(strsplit(names(household_power_consumption), "\\.")))
## Check the data
#names(household_power_consumption)  
#head(household_power_consumption)
#sapply(household_power_consumption, class)

## Preprocess the data
df <- household_power_consumption

## Formate the data
df$Date <- dmy(df$Date)

## Filter the data
df <- df[df$Date == as.Date("2007-02-01") | hpcdf$Date == as.Date("2007-02-02"),]

## Concatenate Date and Time together and get the Weekday
df <- mutate(df, Datetime=str_c(df$Date, ' ', df$Time))
df <- mutate(df, Weekday=format(df$Date, format = "%a"))

## Plot the data
### Plot3: Energy sub metering (3 sub meters) depending on Time (minutes)

x=ymd_hms(df$Datetime)
y1=as.numeric(df$Sub_metering_1)
y2=as.numeric(df$Sub_metering_2)
y3=as.numeric(df$Sub_metering_3)

# Plot the first data series using plot()
plot(x, y1, type="l", col="black", xlab="Time (minutes)", ylab="Energy sub metering (watt-hour)", main="Energy sub metering per Time")

# Add second data series to the same chart using lines()
lines(x, y2, type="l", col="red")

# Add third data series to the same chart using lines()
lines(x, y3, type="l", col="blue")

# Add a legend in top right corner of chart
legend("topright", col=c("black", "red", "blue"), lty = 1,
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Save it to a PNG file with a width of 480 pixels and a height of 480 pixels

dev.copy(png, file= "plot3.png")
dev.off()