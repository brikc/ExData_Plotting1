plot2 <- function() {
    
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
    
    # Convert Date and Time columns to single Date.Time
    d$Date.Time <- strptime(paste(d$Date, d$Time),  format = "%d/%m/%Y %H:%M:%S")
    
    # Convert Date column to actual date
    d$Date <- as.Date(d$Date, "%d/%m/%Y")
    
    # Convert Time column to times
    #d$Time <- strptime(d$Time, "%H:%M:%S")
    
    # Subset for the two days that we are examining for this assignmnet
    dh<-subset(d,subset=(d$Date==as.Date("2007-02-01")|d$Date==as.Date("2007-02-02")))
    
    # Open device
    png(filename="plot2.png",width=480,height=480,units="px")
    
    # Create plot:
    plot(dh$Date.Time,as.numeric(as.character(dh$Global_active_power)),ylab="Global Active Power (kilowatts)",type="l",xlab="")
  
    
    # Close device
    dev.off()
    
}