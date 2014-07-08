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
if(!exists("data1", inherits=F)) {
  message("Reading data")
  header = read.table(xfile, nrows=1, sep=";", stringsAsFactors=F)
  data1 = read.table(xfile, header=T, sep=";", nrows=2880, skip=66636)
  colnames(data1) = unlist(header)
  row.names(data1) = 1:nrow(data1)
} else message("Data already read in to current environment")

# Plot data.
xlab = "Global Active Power (kilowatts)"
title = "Global Active Power"
hist(data1[,3], xlab=xlab, col="red", main=title)

# Copy plot to png.
dev.copy(png, filename="plot1.png")
dev.off()