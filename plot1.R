################################################################################
# Exploratory Data Analysis
# Prof: Roger D. Peng, PhD, Jeff Leek, PhD, Brian Caffo, PhD
# Student: Kenneth Roy Cabrera Torres
# Course Project 1 (25% of final grade)
# plot1
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

Sys.setlocale("LC_TIME" , "en_US.UTF-8")  
names(housPowCons) <- names(headHousPowCons)
housPowCons$Date <- as.Date(housPowCons$Date, format = "%d/%m/%Y")
housPowCons$Time <- as.POSIXct(strptime(paste(housPowCons$Date,housPowCons$Time), 
                             format = "%Y-%m-%d %H:%M:%S"))

################################################################################
# Plot1

png("plot1.png", width = 480,height = 480)
with(housPowCons,hist(Global_active_power,
                      col="red",
                      main="Global Active Power",
                      xlab="Global Active Power (kilowatts)"))
dev.off()



