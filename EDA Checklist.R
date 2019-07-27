#Source: Chapter 4 from Peng R (2010) Exploratory data analysis with R. https://bookdown.org/rdpeng/exdata/exploratory-data-analysis-checklist.html

##Step 1: Formulate question
#Which counties in the US have the highest ozone pollution?

##Steps 2: Read in the data

#Load required packages
if(!require(readr)){
  install.packages("readr")
}
library(readr)

if(!require(dplyr)){
  install.packages("dplyr")
}
library(dplyr)

if(!require(tidyr)){
  install.packages("tidyr")
}
library(tidyr)

if(!require(magrittr)){
  install.packages("magrittr")
}
library(magrittr)


#Read the csv data file and indicating that it has column names
ozone <- read_csv("ozone.csv", col_names = TRUE)

#Format the column names to remove spaces
names(ozone) <- make.names(names(ozone))

##Step 3: Checking the packaging

#Print number of rows and columns in the dataframe
nrow(ozone)
ncol(ozone)

##Step 4: Run str()
#Print the structure of the data frame including the data type of the columns
str(ozone)

##Step 5: Look at the top and the bottom of your data

#Prints the first few rows of the dataframe
head(ozone)
#Prints the last few rows and displays only columns 6,7 and 10 of the dataframe
tail(ozone[, c(6:7, 10)])

##Step 6: Check your “n”s

#Check the hours when measurements are taken.
#table(ozone$Time.Local)

#Check which measurements were measures at 00:01
# filter(ozone, Time.Local == "13:14") %>% 
#   select(State.Name, County.Name, Date.Local, Time.Local, Sample.Measurement)

#Check measurements pulled in NY on Sep 30 2014
# filter(ozone, State.Code == "36" & County.Code == "033" & Date.Local == "2014-09-30") %>%
#   select(Date.Local, Time.Local, Sample.Measurement) %>% 
#   as.data.frame

#Check how many states are represented
select(ozone, State.Name) %>% unique %>% nrow

#Check if there is data for all 50 states
unique(ozone$State.Name)

#There are state codes larger than 50. Print some info for State code = 80 and 78
filter(ozone, ozone$State.Code %in% c(78,80)) %>% 
  select(State.Code, State.Name, County.Name, City.Name, Observation.Count) %>% as.data.frame

#Check the different parameters
table(ozone$Parameter.Name)

#There are several parameters and we will subset the data related to ozone 
onlyozone <- ozone[ozone$Parameter.Name == "Ozone",]

#Print the number and names of unique states represented in the ozone only dataframe
#There are more than fifty states. U.S Territories and Mexico are included in the data.
select(onlyozone, State.Name) %>% unique %>% nrow
unique(onlyozone$State.Name)

##Step 7: Validate with at least one external data source

#The data from the summary below can be compared to regulated measurements
#summary(ozone$Sample.Measurement)
#quantile(ozone$Sample.Measurement, seq(0, 1, 0.1))
summary(onlyozone$Observation.Count)
mean(onlyozone$Observation.Count)

#Deciles of the observation count
quantile(onlyozone$Observation.Count, seq(0, 1, 0.1))

## Step 8: Try the easy solution first

#Find the mean of observation count for all counties in the dataset and rank them in descending order.
ranking <- onlyozone %>% group_by(State.Name, County.Name) %>% 
  summarise(ozone = mean(Observation.Count)) %>% 
  as.data.frame %>% 
  arrange(desc(ozone))

#List the top ten states in this group
head(ranking, 10)

#List the lowest ten states in this group
tail(ranking, 10)

#Washington county in Arkansas has the highest count with 8 counts.
filter(onlyozone, State.Name == "Arkansas" & County.Name == "Washington") %>% nrow

#ozone <- mutate(ozone, Date.Local = as.Date(Date.Local))
#filter(ozone, State.Name == "California" & County.Name == "Mariposa") %>% 
#mutate(month = factor(months(Date.Local), levels = month.name)) %>%
#group_by(month) %>%
#summarize(ozone = mean(Sample.Measurement))

#Puerto Rico has the lowest count with 106 counts
filter(ozone, State.Name == "Puerto Rico" & County.Name == "Bayamon") %>% nrow

#If month data was available, the month-wise observation count data in the Bayamon Puerto Rico county can be examined.
# filter(ozone, State.Name == "Oklahoma" & County.Name == "Caddo") %>% 
#   mutate(month = factor(months(Date.Local), levels = month.name)) %>% 
#   group_by(month) %>% 
#   summarize(ozone = mean(Sample.Measurement))

#Step 9: Challenge your solution

#It is better to not accept the solution that we easily arrived at. The dataset is reexamined by setting it with a bootstrap sampling method.
set.seed(10234)
N <- nrow(onlyozone)
idx <- sample(N, N, replace = TRUE)
ozone2 <- onlyozone[idx, ]

#The rankings are recalculated on the resampled data.
ranking2 <- group_by(ozone2, State.Name, County.Name) %>% 
  summarize(ozone = mean(Observation.Count)) %>% 
  as.data.frame %>% 
  arrange(desc(ozone))

#Printing the top ten rankings of the two ranking dataframes
cbind(head(ranking, 10), head(ranking2, 10))

#The rankings are not very similar in the old dataset and the resamples one. 

#Printing the bottom ten rankings of the two ranking dataframes
cbind(tail(ranking, 10), tail(ranking2, 10))

#The orderings are not the same but some of the same counties exist in both the lists.
#There is not much stability in the rankings.

