# 2014-12-06 exploratory data analysis project 1, plot1
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

# plot1 global active power histogram, and save as png; use default resolution
plot1 <- function() {with(elect_df1, hist(Global_active_power, xlab = "Global Active Power (kilowatts)", col = "red", main = "Global Active Power"))}
plot1()

png("plot1.png", width=480, height=480)
plot1()
dev.off()
