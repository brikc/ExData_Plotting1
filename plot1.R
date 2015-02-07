plot1 <- function() {
    
    # First check to see if the file has already been downloaded and
    # is in the working directory
    
    if (!file.exists("household_power_consumption.txt")) {
        
        # If not, download and unzip the file
        filename<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(filename,destfile="household_power_consumption.zip",method="curl")
        unzip("household_power_consumption.zip")
            
    }
        
    # Read in the file, delimited by semi-colon, header=TRUE
    d <- read.table("household_power_consumption.txt", sep=";", header=TRUE)
    
    # Convert Date column to dates
    d$Date <- as.Date(d$Date, "%d/%m/%Y")
    
    # Convert Time column to times
    d$Time <- strptime(d$Time, "%H:%M:%S")
    
    # Subset for the two days that we are examining for this assignmnet
    dh<-subset(d,subset=(d$Date==as.Date("2007-02-01")|d$Date==as.Date("2007-02-02")))
    
    # Open device
    png(filename="plot1.png",width=480,height=480,units="px")
    
    # Create plot:
    hist(as.numeric(as.character(dh$Global_active_power)),col="red",xlab="Global Active Power (kilowatts)",ylab="Frequency", main="Global Active Power", breaks=12)
    
    # Close device
    dev.off()
    
}