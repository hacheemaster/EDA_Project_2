#Question2:
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
# (fips == "24510") from 1999 to 2008? Use the base plotting system to
# make a plot answering this question.

#download file and unzip
url <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url=url,destfile="data.zip")
unzip("data.zip")

#read in datasets
NEI <- readRDS("summarySCC_PM25.rds")
NEI_baltimore <- subset(NEI,fips=="24510")
#SCC <- readRDS("Source_Classification_Code.rds")

pm25_yearly <- aggregate(list(total_emission=NEI_baltimore$Emissions),
                         by=list(year=NEI_baltimore$year),sum)

#create plot
png(file="plot2.png",width=400,height=400)
with(pm25_yearly,
     plot(x=year,
          y=total_emission,
          xlab = "year",
          ylab = "Total Emission",
          main = "Total Emission by year for Baltimore, Maryland"))
dev.off()
