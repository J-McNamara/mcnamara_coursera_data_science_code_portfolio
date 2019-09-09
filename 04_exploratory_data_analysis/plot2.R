# Read in data
df <-read.csv('household_power_consumption.txt',stringsAsFactors=FALSE,sep=';')
keep <-as.Date(df$Date,'%d/%m/%Y') %in% c(as.Date('01/02/2007','%d/%m/%Y'),as.Date('02/02/2007','%d/%m/%Y'))
df <- df[keep,]

# Fix classes
df$Date <- strptime(paste(df$Date, df$Time, sep=' '), '%d/%m/%Y %H:%M:%S')
df$Global_active_power <- as.numeric(df$Global_active_power)

# Construct plot 1
options(device='RStudioGD')

# Write to file
png(filename = 'plot2.png', width = 480, height = 480, units = 'px')

plot(df$Date, df$Global_active_power, type='l', ylab='Global Active Power (kilowatts)', xlab='')
# axis(1, at = c(0,1500,2900),labels = c('Thu','Fri','Sat'))
# axis(2,at=c(0,2,4,6))
box()

dev.off()
