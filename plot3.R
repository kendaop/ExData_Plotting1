# Set parameters.
par(cex=0.75)

# Set up variables.
url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfile = paste(getwd(), "/epc.zip", sep="")
xfile = "household_power_consumption.txt"

# Download the zip file, if it doesn't exist in the working directory.
if(!file.exists(zipfile)) {
  download.file(url, zipfile)
} else message("File already downloaded")

# Unzip the zip file, if it hasn't been extracted yet.
if(!any(list.files(getwd()) == xfile)) {
  message("Unzipping")
  unzip(zipfile)
} else message("File already unzipped")

# Read in the data and format the data frame accordingly.
if(!exists("data3", inherits=F)) {
  message("Reading data")
  header = read.table(xfile, nrows=1, sep=";", stringsAsFactors=F)
  data3 = read.table(xfile, header=T, sep=";", nrows=2880, skip=66636)
  colnames(data3) = unlist(header)
  row.names(data3) = 1:nrow(data3)
  # Create datetime column by combining Date and Time columns, and coverting to POSIX.
  # Then, remove the old Date and Time columns.
  data3$datetime = strptime(paste(data3$Date, data3$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
  data3 = data3[,c(10, 3:9)]
} else message("Data already read in to current environment")

# Plot data.
ylab = "Energy sub metering"
with(data3, plot(datetime, Sub_metering_1, type="l", ylab=ylab, xlab=""))
with(data3, lines(datetime, Sub_metering_2, type="l", col="Red"))
with(data3, lines(datetime, Sub_metering_3, type="l", col="Blue"))
legend("topright", names(data3)[6:8], lwd=rep(1.5, 3), col=c("Black", "Red", "Blue"))

# Copy plot to png.
dev.copy(png, filename="plot3.png")
dev.off()