# **Electric Power Consumption**
# **1. Base Plotting Example**
#########################
# This is "plot1.R"
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
### Plot1: Global Active Power Frequency

hist(as.numeric(df$Global_active_power), col="red", breaks=25, xlab="Global Active Power (kilowatts)", main="Global Active Power")
rug(as.numeric(df$Global_active_power))

## Save it to a PNG file with a width of 480 pixels and a height of 480 pixels

dev.copy(png, file= "plot1.png")
dev.off()