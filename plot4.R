# 2014-12-06 exploratory data analysis project 1
library(dplyr)
library(lubridate)

# download and read data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="temp.zip", method="curl")
unzip("temp.zip")
elect <- read.table("household_power_consumption.txt", sep=";", na.strings="?", header=TRUE, stringsAsFactors=FALSE)
elect_df <- tbl_df(elect)

# convert date, time, and select subset for plotting
elect_df1 <- elect_df %>%
  mutate(Date, Date = dmy(Date)) %>%
  filter(Date %in% c(mdy("02-01-2007"), mdy("02-02-2007"))) %>%
  mutate(Time, Time = hms(Time))

# plot4 matrix of 4 plots, and to save as png
plot4 <- function(){
par(mfrow=c(2,2))
with(elect_df1, plot(Date + Time, Global_active_power, ylab = "Global Active Power", xlab = "", type="l"))
with(elect_df1, plot(Date + Time, Voltage, xlab = "datetime", type="l"))
with(elect_df1,  plot(Date + Time, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
with(elect_df1, lines(Date + Time, Sub_metering_2, col = "red"))
with(elect_df1, lines(Date + Time, Sub_metering_3, col = "blue"))
legend("topright", lwd = 1, bty = "n", cex=0.75, col=c("black", "red", "blue"), c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
with(elect_df1, plot(Date + Time, Global_reactive_power, type="l", xlab="datetime"))}

plot4()

png("plot4.png", width=480, height=480)
plot4()
dev.off()

