plot4 <- function() {
    
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
    png(filename="plot4.png",width=480,height=480,units="px")
    
    # Set the rows and cols in the screen
    par(mfrow=c(2,2))
    
    # First plot
    plot(dh$Date.Time,as.numeric(as.character(dh$Global_active_power)),ylab="Global Active Power",type="l",xlab="")
        
    # Second plot
    plot(dh$Date.Time,as.numeric(as.character(dh$Voltage)),ylab="Voltage",type="l",xlab="datetime")
    
    # Third plot
    plot(dh$Date.Time,as.numeric(as.character(dh$Sub_metering_1)),ylab="Energy sub metering",type="l",xlab="")
    lines(dh$Date.Time,as.numeric(as.character(dh$Sub_metering_2)),col="red")
    lines(dh$Date.Time,as.numeric(as.character(dh$Sub_metering_3)),col="blue")
    legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1),col=c("black","red","blue"))
    
    # Fourth plot
    plot(dh$Date.Time,as.numeric(as.character(dh$Global_reactive_power)),ylab="Global_reactive_power",type="l",xlab="datetime")
    
    # Close device
    dev.off()
    
}