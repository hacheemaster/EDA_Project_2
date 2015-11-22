#Question 3:
# Of the four types of sources indicated by the type (point, nonpoint, 
# onroad, nonroad) variable, which of these four sources have seen 
# decreases in emissions from 1999-2008 for Baltimore City? Which have 
# seen increases in emissions from 1999-2008? Use the ggplot2 plotting
# system to make a plot answer this question.

library(ggplot2)

#download file and unzip
url <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url=url,destfile="data.zip")
unzip("data.zip")

#read in datasets
NEI <- readRDS("summarySCC_PM25.rds")
NEI_baltimore <- subset(NEI,fips=="24510")
#SCC <- readRDS("Source_Classification_Code.rds")

pm25_yearly <- with (NEI_baltimore,
                     aggregate(list(total_emission=Emissions),
                         by=list(year=year, type=type),sum)) 

#create plot
png(file="plot3.png",width=400,height=400)
with(pm25_yearly,
    qplot(x=year, y=total_emission, col = type, geom="line",
          main = "Yearly total emission by type"))

dev.off()
