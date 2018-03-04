##reading and processing data
hpc<- read.table("household_power_consumption.txt",header=T,sep=";",na.strings="?")
hpc$Date<- as.Date(hpc$Date,"%d/%m/%Y")

hpc<- data.frame(hpc,Day=hpc$Date,Week=weekdays(hpc$Date))
hpc$Date<- unclass(hpc$Date)

hpc2<- subset(hpc,Date==13545|Date==13546)
x<- as.POSIXlt(as.Date("2007-02-01 23:59:30"))
Period<- paste(hpc2$Day,hpc2$Time)
Period<- strptime(Period,"%Y-%m-%d %H:%M:%S")-x
hpc2<- data.frame(hpc2,Period)
hpc2$Global_active_power<- as.numeric(hpc2$Global_active_power)

##creating graphic file and plot
png(filename="plot1.png",width=480,height=480,units="px")

hist(hpc2$Global_active_power,col="red",main="Global Active Power",ylab="Frequency",xlab="Global Active Power(kilowatts)")
dev.off()
