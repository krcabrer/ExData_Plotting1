################################################################################
# Exploratory Data Analysis
# Prof: Roger D. Peng, PhD, Jeff Leek, PhD, Brian Caffo, PhD
# Student: Kenneth Roy Cabrera Torres
# Course Project 1 (25% of final grade)
# plot3

################################################################################
# Calculate a rough estimate of how much memory the dataset will require.
# 2'075.256 rows, 9 columns, 8 bytes each
2075256 * 9 * 8 
# Convert to Gigabytes 1 GB = 2^30 bytes
(2075256 * 9 * 8)/(2^30)
# About ~140 MB, the whole dataset.

# Selecting only data form dates 2007-02-01 and 207-02-02
# Reading only the first column of the dataset to select those rows that
# are of the require data.
dates1<-read.table("household_power_consumption.txt",
                   sep = ";",
                   header = TRUE,
                   na.strings = c("?"),
                   colClasses = c("character",rep("NULL",8)))
dates1$Date <- as.Date(dates1$Date, format = "%d/%m/%Y")
IdxstartDate <- which.max(dates1$Date >= as.Date("2007-02-01"))
IdxendDate   <- which.max(dates1$Date >  as.Date("2007-02-02"))
rowsToRead <- IdxendDate-IdxstartDate  # Number of rows to read

housPowCons<-read.table("household_power_consumption.txt",
                        sep = ";",
                        header = FALSE,
                        na.strings = c("?"),
                        skip=(IdxstartDate),
                        nrows = rowsToRead)

headHousPowCons <- read.table("household_power_consumption.txt",
                     sep = ";",
                     header = TRUE,
                     na.strings = c("?"),
                     nrows=1)

names(housPowCons) <- names(headHousPowCons)
housPowCons$Date <- as.Date(housPowCons$Date, format = "%d/%m/%Y")
housPowCons$Time <- as.POSIXct(strptime(paste(housPowCons$Date,housPowCons$Time), 
                             format = "%Y-%m-%d %H:%M:%S"))



png("plot4.png", width = 480,height = 480)
par(mfrow = c(2,2))
with(housPowCons,plot(Global_active_power ~ Time, type= "l",
                      ylab = "Global Active Power",
                      xlab = ""))

with(housPowCons,plot(Voltage ~ Time, type= "l",
                      xlab = "datetime"))

with(housPowCons,plot(Sub_metering_1 ~ Time, type= "l",
                      ylab = "Energy sub metering",
                      xlab = ""))
with(housPowCons,lines(Time,Sub_metering_2, col = "red"))
with(housPowCons,lines(Time,Sub_metering_3, col = "blue"))
legend("topright",legend=names(housPowCons)[7:9],
       box.col="transparent",
       col=c("black","red","blue"),lty=1)
box()

with(housPowCons,plot(Global_reactive_power ~ Time, type= "l",
                      xlab = "datatime"))
dev.off()



