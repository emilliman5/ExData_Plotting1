#This is code to generate plot 3 of project 1 from the course EDA

#This script assumes that the data file is located in your current working directory.

data1<-read.table("household_power_consumption.txt", sep=";", header=TRUE, stringsAsFactor=FALSE)

dim(data)
colnames(data)
class(data$Date)
head(data)

#subset data based on dates needed for plotting.

dataSub<-data1[as.Date(data1$Date, format = "%d/%m/%Y")=="2007-02-01" | 
                 as.Date(data1$Date, format = "%d/%m/%Y")=="2007-02-02",]

##Check for missing/NA values coded as "?"

grep("\\?", dataSub)

#remove original dataset to free up memory
rm(data1)

#convert Date to Date/time class variables and other columns to numerics
dataSub$Date<-strptime(paste0(dataSub$Date, dataSub$Time), format = "%d/%m/%Y%H:%M:%S")

dataSub$Global_active_power<-as.numeric(dataSub$Global_active_power)
dataSub$Global_reactive_power<-as.numeric(dataSub$Global_reactive_power)
dataSub$Global_intensity<-as.numeric(dataSub$Global_intensity)
dataSub$Voltage<-as.numeric(dataSub$Voltage)
dataSub$Sub_metering_1<-as.numeric(dataSub$Sub_metering_1)
dataSub$Sub_metering_2<-as.numeric(dataSub$Sub_metering_2)

#quick peek at the data
summary(dataSub)
head(dataSub$Time)

png("plot3.png", width=480, height=480)
plot(dataSub$Date, dataSub$Sub_metering_1, ylab="Energy Sub Metering", xlab="", main="",type = "l")
lines(dataSub$Date, dataSub$Sub_metering_2, col="red")
lines(dataSub$Date, dataSub$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd=2 ,col=c("black","red","blue"))
dev.off()