#Question1:
# Have total emissions from PM2.5 decreased in the United States from 
# 1999 to 2008? Using the base plotting system, make a plot showing the 
# total PM2.5 emission from all sources for each of the years 1999, 2002, 
# 2005, and 2008.

#download file and unzip
url <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url=url,destfile="data.zip")
unzip("data.zip")

#read in datasets
NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

pm25_yearly <- aggregate(list(total_emission=NEI$Emissions),
                         by=list(year=NEI$year),sum)

#create plot
png(file="plot1.png",width=400,height=400)
with(pm25_yearly,
    plot(x=year,
         y=total_emission,
         xlab = "year",
         ylab = "Total Emission",
         main = "Total Emission by year"))
dev.off()
