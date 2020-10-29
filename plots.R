##Load the dataset
power_con <- read.table("household_power_consumption.txt",skip=1,sep=";")
#view dataset
names(power_con)
power_con
#change names
names(power_con) <- c("date", "time", "global_active_power", "global_reactive_power",
                      "voltage", "global_intensity", "Sub_metering_1", "Sub_metering_2",
                      "Sub_metering_3")
subpower_con <- subset(power_con, power_con$date=="1/2/2007" | power_con$date =="2/2/2007")
#basic plot function
hist(as.numeric(as.character(subpower_con$global_active_power)),
     col="red", main="Global Active Power", xlab="Global Active Power (kw)")
# save plot 1
png("plot1.png", width=480, height=480)
dev.off()

#PLOT 2
#transform the date to numeric-character
subpower_con$Date <- as.Date(subpower_con$date, format="%d/%m/%Y")
subpower_con$Time <- strptime(subpower_con$time, format="%H:%M:%S")
subpower_con[1:1440,"Time"] <- format(subpower_con[1:1440,"Time"],"2007-02-01 %H:%M:%S")
subpower_con[1441:2880,"Time"] <- format(subpower_con[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

#basic plot function
plot(subpower_con$time,
     as.numeric(as.character(subpower_con$global_active_power)),
     type="l",xlab="", ylab="Global Active Power (kw)") 
#add title
title(main="Global Active Power Vs Time")

# save plot 2
png("plot2.png", width=480, height=480)
dev.off()


#PLOT 3
# plotting:
plot(subpower_con$time,subpower_con$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
with(subpower_con,lines(time,as.numeric(as.character(Sub_metering_1))))
with(subpower_con,lines(time,as.numeric(as.character(Sub_metering_2)),col="red"))
with(subpower_con,lines(time,as.numeric(as.character(Sub_metering_3)),col="blue"))
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# add title:
title(main="Energy sub-metering")

# save plot 3
png("plot3.png", width=480, height=480)
dev.off()


# PLOT 4

# starting the thing to make plots side by side:
par(mfrow=c(2,2))

# plotting, 1 function for each of the 4 graphs:
with(subpower_con,{
  plot(subpower_con$time,as.numeric(as.character(subpower_con$global_active_power)),type="l",  xlab="",ylab="Global Active Power")  
  plot(subpower_con$time,as.numeric(as.character(subpower_con$voltage)), type="l",xlab="date-time",ylab="Voltage")
  plot(subpower_con$time,subpower_con$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
  with(subpower_con,lines(time,as.numeric(as.character(Sub_metering_1))))
  with(subpower_con,lines(time,as.numeric(as.character(Sub_metering_2)),col="red"))
  with(subpower_con,lines(time,as.numeric(as.character(Sub_metering_3)),col="blue"))
  legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)
  plot(subpower_con$time,as.numeric(as.character(subpower_con$global_reactive_power)),type="l",xlab="datetime",ylab="Global_reactive_power")
})


