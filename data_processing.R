# setwd("~/Documents/## Github Repo/Data-Product")
library(ggplot2)
library(reshape)

# unzip("rprog-data-ProgAssignment3-data.zip")
outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
outcome<-outcome[,c(1:11,17,23)]
outcome[,11:13]<-sapply(outcome[,11:13],as.numeric)
outcome<-data.table(outcome)
# Explore the data set
names<-names(outcome);names
table(sapply(outcome,class))

setnames(outcome, "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack", "Heart Attack")
setnames(outcome, "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure", "Heart Failure")
setnames(outcome, "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia", "Pneumonia")

# Exploratory data analysis
sum(is.na(outcome))
table(outcome$State) 
state <- sort(unique(outcome$State))

# Reshape data.table
outcome<-melt(outcome,id=1:10,measure=11:13)
outcome$value[outcome$value=="Not Available"]<-NA

outcome$variable<-as.character(outcome$variable)

# Aggregate result by State
groupByState <- function(dt, Index, state) {
  result <- dt %>% filter(variable %in% Index,
                          State %in% state) 
  return(result)
}
x<-groupByState(outcome,"Heart Attack","AL")