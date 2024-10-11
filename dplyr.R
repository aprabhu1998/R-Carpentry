library(dplyr)
# Download data from the internet
download.file(url = "https://raw.githubusercontent.com/swcarpentry/r-novice-gapminder/main/episodes/data/gapminder_data.csv", 
              destfile = "gapminder_Data.csv")

# Read the data
gapminder_data <- read.csv("gapminder_data.csv")

head (gapminder_data)
str(gapminder_data)
ncol(gapminder_data)
nrow(gapminder_data)
colnames(gapminder_data)
summary(gapminder_data)

# Dplyr makes appearance
# Seect some columns: year, country, gdpPercap

select(gapminder_data, year, country, gdpPercap)
select(gapminder_data, -lifeExp)

# this command
select(gapminder_data, year, country, gdpPercap)

# is this one with pipes
# Ctrl+ Shift+ M
gapminder_data %>% 
  select(year, country, gdpPercap) %>% 
  head()

gapminder_data %>% 
  select(-lifeExp)

# Filtering observations 
gap_EU <- gapminder_data %>% 
  filter(continent == "Europe")

head(gap_EU)

# check that there is only Europe
# in our new object

gap_EU %>% 
  distinct(continent)

#compare to original
gapminder_data %>% 
  distinct(continent)

head(gap_EU)

#Filter: continent is Europe and year is 2002
gap_EU %>% 
  filter(year == 2002)

# Another way would be\
gapminder_data %>% 
  filter(continent == "Europe",
         year == 2002)
gapminder_data %>% 
  filter(continent == "Europe",
         year == 2002)

gapminder_data %>% 
  filter(year == 2002 |
         year == 2007)

gapminder_data %>% 
  filter(year %in% c(1952, 1972, 1987)) %>% 
  distinct(year)

gapminder_data %>% 
  select(continent, year, lifeExp) %>% 
  filter(country == "Germany")

gapminder_data %>% 
  filter(country != "Germany") %>% 
  distinct(country)

# challlenge 1
gapminder_data %>% 
  filter(country == "Africa")

gapminder_data %>% 
  filter(country == "Africa")

gapminder_Africa <- gapminder_data %>% 
  filter(continent == "Africa") %>% 
  select(lifeExp, country, year) #for all rows

nrow(gapminder_Africa)

#Summarise

gapminder_data %>% 
  summarise(mean_gdp = mean(gdpPercap),
            median_gdp = median(gdpPercap),
            min_gdp = min(gdpPercap))

#Let's get better, group observations
summary_table <- gapminder_data %>% 
  group_by(continent) %>% 
  summarise(mean_gdp = mean(gdpPercap),
            median_gdp = median(gdpPercap),
            min_gdp = min(gdpPercap))

summary_table

Country_lifeexp <- gapminder_data %>% 
  group_by(country) %>% 
  summarise(mean_exp = mean(lifeExp)) %>% 
  filter(max_exp == max(mean_exp))

Country_lifeexp

gapminder_data %>% 
  summarise(max_exp = slice_max(lifeExp, order_by(lifeExp)),
            min_exp = slice_min(lifeExp), order_by(lifeExp))

Country_lifeexp %>% 
  slice_max(Country_lifeexp)

Country_lifeexp %>% 
  slice_max(order_by = mean_exp, n = 1)

# Goal: How many observations I have per year 

gapminder_data %>% 
  group_by(year, country) %>% 
  count()

# Goal: Add a new column
gapminder_data2 <- gapminder_data %>% 
  mutate(lifeExp_round = round(lifeExp)) %>% 
  head()

ncol(gapminder_data2)

# Exporting to csv

write.csv(gapminder_data2, "gapminder_Data.csv")





















