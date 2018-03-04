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
png(filename="plot3.png",width=480,height=480,units="px")

with(hpc2,plot(Period,Sub_metering_1,type="l",ylab="Global Active Power(kilowatts)",xlab="",xaxt="n"))
points(hpc2$Period,hpc2$Sub_metering_2,type="l",col="red")
points(hpc2$Period,hpc2$Sub_metering_3 ,type="l",col="blue")

legend("topright",
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=1,col=c("black","red","blue"))
axis(1,at=c(min(Period),mean(Period),max(Period)),labels=c("Thu","Fri","Sat"))


dev.off()


