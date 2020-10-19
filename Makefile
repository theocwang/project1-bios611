.PHONY: clean
SHELL: /bin/bash

clean: 
	rm -f derivedData/*.csv
	rm -f figures/*.png
	rm -f project1.pdf

derivedData/finalData.csv:\
 sourceData/List_Of_Permitted_Animal_Facilities2019-11-06.xls\
 sourceData/2020_County_Health_Rankings_North_Carolina_Data_-_v1_0.xlsx\
 tidyData.R
	Rscript tidyData.R

figures/cafoHistogram.png:\
 derivedData/finalData.csv\
 cafoHisto.R
	Rscript cafoHisto.R
	
figures/cafoHistogramCounty.png:\
 derivedData/finalData.csv\
 cafoHistoCounty.R
	Rscript cafoHistoCounty.R

figures/mentalDaysScatter.png:\
 derivedData/finalData.csv\
 mentalDaysScatter.R
	Rscript mentalDaysScatter.R

figures/physicalDaysScatter.png:\
 derivedData/finalData.csv\
 physicalDaysScatter.R
	Rscript physicalDaysScatter.R

figures/poorFairScatter.png:\
 derivedData/finalData.csv\
 poorFairScatter.R
	Rscript poorFairScatter.R

figures/lifeExpectancyScatter.png:\
 derivedData/finalData.csv\
 lifeExpectancyScatter.R
	Rscript lifeExpectancyScatter.R

figures/percentMentalDistress.png:\
 derivedData/finalData.csv\
 percentMentalDistress.R
	Rscript percentMentalDistress.R

figures/percentPhysicalDistress.png:\
 derivedData/finalData.csv\
 percentPhysicalDistress.R
	Rscript percentPhysicalDistress.R

figures/airQualityScatter.png:\
 derivedData/finalData.csv\
 airQualityScatter.R
	Rscript airQualityScatter.R

figures/foodIndexScatter.png:\
 derivedData/finalData.csv\
 foodIndexScatter.R
	Rscript foodIndexScatter.R

project1.pdf:\
 project1.Rmd\
 derivedData/finalData.csv\
 figures/cafoHistogram.png\
 figures/cafoHistogramCounty.png\
 figures/mentalDaysScatter.png\
 figures/physicalDaysScatter.png\
 figures/poorFairScatter.png\
 figures/lifeExpectancyScatter.png\
 figures/percentMentalDistress.png\
 figures/percentPhysicalDistress.png\
 figures/airQualityScatter.png\
 figures/foodIndexScatter.png
	R -e "rmarkdown::render('project1.Rmd', output_format='pdf_document')"
