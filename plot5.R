# Question 5:
# How have emissions from motor vehicle sources changed from 1999-2008
# in Baltimore City?


library(ggplot2)

#download file and unzip
url <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url=url,destfile="data.zip")
unzip("data.zip")

#read in datasets
NEI <- readRDS("summarySCC_PM25.rds")
NEI_baltimore <- subset(NEI,fips=="24510" & type=="ON-ROAD")
#SCC <- readRDS("Source_Classification_Code.rds")

pm25_yearly <- with (NEI_baltimore,
                     aggregate(list(total_emission=Emissions),
                               by=list(year=year),sum)) 

#create plot
png(file="plot5.png",width=400,height=400)
with(pm25_yearly,
     qplot(x=year, y=total_emission, geom="line",
           main = "Yearly total emission for Baltimore from motor vehicles"))

dev.off()
