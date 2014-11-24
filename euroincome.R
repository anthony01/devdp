# Load data

tab     <- read.csv("ilc_di01_1_Data.csv", stringsAsFactors = FALSE)
tab$GEO <- as.factor(sub("Germany (until 1990 former territory of the FRG)", "Germany", tab$GEO, fixed = TRUE))
load("scale.RData")     # auxilliary 'scale' and 'legend' arrays

# Preprocessing

tab1           <- merge(tab, legend, by = "QUANTILE", all.x = TRUE)
tab            <- tab1[(order(tab1$TIME, tab1$GEO, tab1$Value.y)), c(2, 3, 6, 8)]
row.names(tab) <- NULL
names(tab)     <- c("year", "country", "cutoff", "percentile")
tab$cutoff     <- suppressWarnings(as.integer(gsub(",", "", tab$cutoff)))
set.country    <- levels(tab$country)
set.period     <- levels(as.factor(as.character(tab$year)))
save(tab, set.country, set.period, file = "tab.RData")