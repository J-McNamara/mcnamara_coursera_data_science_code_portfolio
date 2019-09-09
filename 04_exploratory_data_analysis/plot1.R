# Read in data
df <-read.csv('household_power_consumption.txt',stringsAsFactors=FALSE,sep=';')
keep <-as.Date(df$Date,'%d/%m/%Y') %in% c(as.Date('01/02/2007','%d/%m/%Y'),as.Date('02/02/2007','%d/%m/%Y'))
df <- df[keep,]

# Construct plot 1
# options(device="RStudioGD")

# Write to file
png(filename = 'plot1.png', width = 480, height = 480, units = 'px')

plt1 <- hist(x = as.numeric(df$Global_active_power), col='red', xlab="Global Active Power (kilowatts)", main= 'Global Active Power', ylim = c(1,1200)) 

dev.off()
