# Read in data
df <-read.csv("household_power_consumption.txt",stringsAsFactors=FALSE,sep=";")
keep <-as.Date(df$Date,"%d/%m/%Y") %in% c(as.Date("01/02/2007","%d/%m/%Y"),as.Date("02/02/2007","%d/%m/%Y"))
df <- df[keep,]

# Fix date and var class
df$Date <- strptime(paste(df$Date, df$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
df$Global_active_power <- as.numeric(df$Global_active_power)

# Construct plot 1
# options(device="RStudioGD")


# Write to file
png(filename = 'plot4.png', width = 480, height = 480, units = 'px')
par(mfrow=c(2,2)) 

# 1 
plot(df$Date, df$Global_active_power, type='l', ylab='Global Active Power (kilowatts)', xlab='')

#2
plot(df$Date, df$Voltage, type='l', ylab='Voltage', xlab='datetime')

# 3 
plot(y=as.numeric(df$Sub_metering_1), x=df$Date, ylab='Energy sub metering', type='l', col='black', xlab='')

par(new=T)

plot(as.numeric(df$Sub_metering_2),col='red', type='l', axes=FALSE, ylim=c(0,40), xlab='', ylab='') 

par(new=T)

plot(as.numeric(df$Sub_metering_3), col='blue', type='l', axes=FALSE, ylim=c(0,40), ylab='', xlab='')
box()


# Add a legend
legend(x = "topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"), )

# 4
plot(df$Date, df$Global_reactive_power, type='l', ylab='Global_reactive_power', xlab='datetime', ylim=c(0, 0.5))


dev.off()

