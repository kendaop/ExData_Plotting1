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
if(!exists("data2", inherits=F)) {
  message("Reading data")
  header = read.table(xfile, nrows=1, sep=";", stringsAsFactors=F)
  data2 = read.table(xfile, header=T, sep=";", nrows=2880, skip=66636)
  colnames(data2) = unlist(header)
  row.names(data2) = 1:nrow(data2)
  # Create datetime column by combining Date and Time columns, and coverting to POSIX.
  # Then, remove the old Date and Time columns.
  data2$datetime = strptime(paste(data2$Date, data2$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
  data2 = data2[,c(10, 3:9)]
} else message("Data already read in to current environment")

# Plot data.
ylab = "Global Active Power (kilowatts)"
with(data2, plot(datetime, Global_active_power, type="l", ylab=ylab, xlab=""))

# Copy plot to png.
dev.copy(png, filename="plot2.png")
dev.off()