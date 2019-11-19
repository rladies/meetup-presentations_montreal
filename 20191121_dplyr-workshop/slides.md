<style>
.reveal code {
    font-family: monospace;
    color: #A30664; 
    font-face: bold; 
}
.reveal h1, .reveal h2, .reveal h3, .reveal h4 {
  word-wrap: normal; 
  -moz-hyphens: none;
  font-size: 45px;
} 
</style>
<style>
.small-code pre code {
  font-size: 1em;
}
</style>
<style>
.footer {
    color: black;
    font-family: Montserrat; 
    font-size: 9px; 
    background: #E8E8E8;
    position: fixed;
    top: 100%;
    text-align:right;
    width:100%; }
</style>

R Ladies: Interactive dplyr workshop 
======================================================== 
author: Kathryn Morrison 
font-import: http://fonts.googleapis.com/css?family=Montserrat
font-family: 'Montserrat'
date: November 21, 2019  
autosize: true  

Today's Agenda 
========================================================
incremental: true   

<small> 
6:00PM - 6:15PM <br> 
**Snacks and Pizza!** 

6:15PM - 6:30PM <br> 
**Welcome, housekeeping**

6:30PM - 6:45PM  <br> 
**Brief introduction to dplry**

6:45PM - 8:00PM <br> 
**Interactive dplyr workshop**
</small>


Welcome & Housekeeping  
========================================================


_Any welcome/recap/admin stuff, ask about ideas for future speakers, etc_ 


Manipulating data with dplyr 
========================================================
incremental: true
<center> ![0.5](slides-figure/pipe.jpg) </center> 
<small> The "tidyverse" is a collection of libraries, like `dplyr` that follow some basic coding best practices

`dplyr` is a key tidyverse library that is great for data wrangling 

The pipe opperator **%>%** allows you to chain together operations in a sequence, avoiding unnecessary temporary tables, and using descriptive functions that are normal english verbs 

Tip: the keyboard shortcute for the `dplyr` pipe operator is Ctrl+Shift+M (Windows) or Cmd+Shift+M (OSX)
</small>

Manipulating data with dplyr 
========================================================
incremental: true
class: small-code

A `tibble` is the tidyverse's version of a data frame. It never changes an input's type (i.e. no conversion of characters to factors) and it allows you to specify variable names outside of the valid R naming rules.
  

```r
ds_df <- data.frame(`1 weird name` = 1:3, `is it a factor?` = letters[1:3])
str(ds_df)
```

```
'data.frame':	3 obs. of  2 variables:
 $ X1.weird.name  : int  1 2 3
 $ is.it.a.factor.: Factor w/ 3 levels "a","b","c": 1 2 3
```

```r
library(dplyr)
ds_tib <- tibble(`1 weird name` = 1:3, `is it a factor?` = letters[1:3])
str(ds_tib)
```

```
Classes 'tbl_df', 'tbl' and 'data.frame':	3 obs. of  2 variables:
 $ 1 weird name   : int  1 2 3
 $ is it a factor?: chr  "a" "b" "c"
```

Manipulating data with dplyr 
========================================================
incremental: true

<small> Tibbles differ from data frames in two main areas: printing and subsetting 
  * **Printing** a tibble will limit to the first 10 rows and as many columns as fill the console. Extra information on the dimensions, variable types and grouping variables is also included 
  * **Subsetting** rules are stricter than with data frames. Specifically, using the `[` will always return a tibble and never a vector as sometimes happens with a data frame
  
Note that a dataframe passed to a dplyr function will be returned as a tibble; this is usually fine, but not all functions from other packages accept tibbles! Sometimes you will need to transform a tibble back to a data frame with `as.data.frame()`. </small> 

Manipulating data with dplyr 
========================================================

<center> ![](slides-figure/pipe.jpg) </center> 

We will be learning: `select()`, `arrange()`, `filter()`, `mutate()`, `join()`,  `group_by()`, `melt()` 

Let's go through some examples - it's the easiest way to understand and learn 



Reviewing the data 
========================================================


```r
library(dplyr)
library(datasets)
ds <- esoph
str(ds)
```

```
'data.frame':	88 obs. of  5 variables:
 $ agegp    : Ord.factor w/ 6 levels "25-34"<"35-44"<..: 1 1 1 1 1 1 1 1 1 1 ...
 $ alcgp    : Ord.factor w/ 4 levels "0-39g/day"<"40-79"<..: 1 1 1 1 2 2 2 2 3 3 ...
 $ tobgp    : Ord.factor w/ 4 levels "0-9g/day"<"10-19"<..: 1 2 3 4 1 2 3 4 1 2 ...
 $ ncases   : num  0 0 0 0 0 0 0 0 0 0 ...
 $ ncontrols: num  40 10 6 5 27 7 4 7 2 1 ...
```


Reviewing the data 
========================================================
class: small-code


```r
summary(ds) 
```

```
   agegp          alcgp         tobgp        ncases         ncontrols    
 25-34:15   0-39g/day:23   0-9g/day:24   Min.   : 0.000   Min.   : 1.00  
 35-44:15   40-79    :23   10-19   :24   1st Qu.: 0.000   1st Qu.: 3.00  
 45-54:16   80-119   :21   20-29   :20   Median : 1.000   Median : 6.00  
 55-64:16   120+     :21   30+     :20   Mean   : 2.273   Mean   :11.08  
 65-74:15                                3rd Qu.: 4.000   3rd Qu.:14.00  
 75+  :11                                Max.   :17.000   Max.   :60.00  
```

select() 
========================================================
class: small-code

Let's select just three columns: age group, number of cases, number of controls

```r
ds %>% select(agegp, ncases, ncontrols) %>% head()
```

```
  agegp ncases ncontrols
1 25-34      0        40
2 25-34      0        10
3 25-34      0         6
4 25-34      0         5
5 25-34      0        27
6 25-34      0         7
```

arrange() 
========================================================
class: small-code

Let's arrange in descending order of number of cases 

```r
ds %>% arrange(desc(ncases)) %>% head()
```

```
  agegp  alcgp    tobgp ncases ncontrols
1 65-74  40-79 0-9g/day     17        34
2 55-64  40-79 0-9g/day      9        40
3 55-64 80-119 0-9g/day      9        18
4 55-64 80-119    10-19      8        15
5 45-54  40-79 0-9g/day      6        38
6 45-54 80-119    10-19      6        14
```


filter() 
========================================================
class: small-code

Let's filter by those who are at least 65 years old.
If we want to save this filter, we can create a new dataframe. 

```r
ds_olderadults <- ds %>% filter(agegp >= '65-74') 
ds_olderadults %>% head(3)
```

```
  agegp     alcgp    tobgp ncases ncontrols
1 65-74 0-39g/day 0-9g/day      5        48
2 65-74 0-39g/day    10-19      4        14
3 65-74 0-39g/day    20-29      2         7
```

* Note the ordered factor allows for >= command on a character variable.

 
mutate() 
========================================================
class: small-code

Let's create a new variable that is the odds of the outcome per group. 

```r
ds_olderadults <- ds_olderadults %>% mutate(odds = ncases/ncontrols) 
```

To append a variable to the same data frame, assign it with the same name. 


group_by() 
========================================================
class: small-code

What if we wanted to know the average odds per age group? 

```r
ds_olderadults %>% group_by(agegp) %>% summarise(mean_odds = mean(odds)) %>% head(3)
```

```
# A tibble: 2 x 2
  agegp mean_odds
  <ord>     <dbl>
1 65-74     0.516
2 75+       0.587
```

Activity II: Manipulating data in using dplyr  
========================================================
class: small-code
type: section

Annual data on fertility in the US, between 2003-2018

Level of observation: state, level, and race category of the mother


```r
# Data source: https://wonder.cdc.gov/
births_2003_2006 <- readRDS("data/births_2003_2006.rds")
births_2007_2018 <- readRDS("data/births_2007_2018.rds")
names(births_2007_2018)
```

```
[1] "Notes"                       "State"                      
[3] "Year"                        "Mother.s.Bridged.Race"      
[5] "Births"                      "Birth.Rate"                 
[7] "Fertility.Rate"              "Average.Birth.Weight"       
[9] "Average.LMP.Gestational.Age"
```

Activity II: Instructions
========================================================
type: section
class: small-code

<small> Using dplyr and the above example datasets, complete the following exercises: <br> <br> 
(1) Bind the two data frames into a single data frame. What are the new dimensions of the data frame? <br> 
(2) Delete the first column of the data with the "Notes"<br>
(3) Remove all observations where Average.LMP.Gestational.Age has missing values <br>
(4) Calculate the average birth weight by state using mutate and summarise. How are the results different? <br>
(5) What were the the states with the 5 highest fertility rates in 2010 (tricky question!) <br> <br>
(6) For each year, compute the minimum and maximum for each numeric variable

A few useful functions: `bind_rows()`, `select()`, `filter()`, `mutate()`,<br> `summarise()`, `arrange()`, `top_n()` </small> 



Solution 1: 
========================================================
incremental: true
class: small-code

<small>Bind the two rows together, what are the new dimenions of the data frame? </small>


```r
df <- bind_rows(births_2003_2006, births_2007_2018)
dim(df)
```

```
[1] 3368    9
```

```r
#Alternatively
ncol(df)
```

```
[1] 9
```

```r
nrow(df)
```

```
[1] 3368
```


Solution 2: 
========================================================
incremental: true
class: small-code

<small> Delete the first column of the data with the "Notes" </small>


```r
df %>% select(-Notes) %>% head()
```

```
    State Year            Mother.s.Bridged.Race Births Birth.Rate
1 Alabama 2003 American Indian or Alaska Native    146       5.20
2 Alabama 2003        Asian or Pacific Islander    607      13.98
3 Alabama 2003        Black or African American  17931      15.07
4 Alabama 2003                            White  40868      12.61
5 Alabama 2004 American Indian or Alaska Native    179       6.18
6 Alabama 2004        Asian or Pacific Islander    763      16.32
  Fertility.Rate Average.Birth.Weight Average.LMP.Gestational.Age
1          22.12              3236.81                       38.18
2          52.69              3219.63                       38.61
3          62.76              3039.20                       37.88
4          63.09              3283.50                       38.43
5          26.48              3161.90                       37.99
6          61.86              3154.78                       38.56
```


Solution 3: 
========================================================
incremental: true
class: small-code

<small> Remove all observations where Average.LMP.Gestational.Age has missing values </small>


```r
df %>% filter(!is.na(Average.LMP.Gestational.Age)) %>% head()
```

```
  Notes   State Year            Mother.s.Bridged.Race Births Birth.Rate
1       Alabama 2003 American Indian or Alaska Native    146       5.20
2       Alabama 2003        Asian or Pacific Islander    607      13.98
3       Alabama 2003        Black or African American  17931      15.07
4       Alabama 2003                            White  40868      12.61
5       Alabama 2004 American Indian or Alaska Native    179       6.18
6       Alabama 2004        Asian or Pacific Islander    763      16.32
  Fertility.Rate Average.Birth.Weight Average.LMP.Gestational.Age
1          22.12              3236.81                       38.18
2          52.69              3219.63                       38.61
3          62.76              3039.20                       37.88
4          63.09              3283.50                       38.43
5          26.48              3161.90                       37.99
6          61.86              3154.78                       38.56
```


Solution 4: 
========================================================
incremental: true
class: small-code

<small> Calculate the average birth weight by state </small>


```r
df %>% group_by(State) %>% 
  mutate(avg_bw = mean(Average.Birth.Weight, na.rm = T)) %>% 
  head(2)
```

```
# A tibble: 2 x 10
# Groups:   State [1]
  Notes State  Year Mother.s.Bridge… Births Birth.Rate Fertility.Rate
  <chr> <chr> <int> <chr>             <dbl>      <dbl>          <dbl>
1 ""    Alab…  2003 American Indian…    146        5.2           22.1
2 ""    Alab…  2003 Asian or Pacifi…    607       14.0           52.7
# … with 3 more variables: Average.Birth.Weight <dbl>,
#   Average.LMP.Gestational.Age <dbl>, avg_bw <dbl>
```

```r
df %>% group_by(State) %>% 
  summarise(avg_bw = mean(Average.Birth.Weight)) %>% 
  head(2)
```

```
# A tibble: 2 x 2
  State   avg_bw
  <chr>    <dbl>
1 ""         NA 
2 Alabama  3168.
```

Solution 5: 
========================================================
incremental: true
class: small-code

<small> What were the the states with the 5 highest fertility rates in 2010? </small> 


```r
 df %>% filter(Year == 2010) %>% # restrict to 2010
  group_by(State) %>% # collapse over racial groups
  summarise(avg_fertility = mean(Fertility.Rate)) %>% #calculate new state-level average
  arrange(desc(avg_fertility)) %>% #sort average fertility rates in ascdending order
  top_n(5) %>% #select highest values
  head(5) 
```

```
# A tibble: 5 x 2
  State        avg_fertility
  <chr>                <dbl>
1 South Dakota          89.2
2 North Dakota          88.5
3 Alaska                86.9
4 Nebraska              83.2
5 Minnesota             82.2
```


Solution 6: Solution
========================================================
incremental: true
class: small-code

<small> For each year, compute the minimum and maximum for each numeric variable </small>


```r
df %>% group_by(Year) %>% 
  summarise_if(., is.numeric, funs(min, max(.))) %>% 
  head(3)
```

```
# A tibble: 3 x 11
   Year Births_min Birth.Rate_min Fertility.Rate_… Average.Birth.W…
  <int>      <dbl>          <dbl>            <dbl>            <dbl>
1  2003         25           4.31             17.4            3007.
2  2004         12           4                17.8            3014.
3  2005         13           4.04             16.4            2918.
# … with 6 more variables: Average.LMP.Gestational.Age_min <dbl>,
#   Births_max <dbl>, Birth.Rate_max <dbl>, Fertility.Rate_max <dbl>,
#   Average.Birth.Weight_max <dbl>, Average.LMP.Gestational.Age_max <dbl>
```



R and the tidyverse resources:
========================================================
class: small-code


Data analysis and modelling <br> 
R for Data Science by Hadley Wickham & Garrett Grolemund
https://r4ds.had.co.nz/

Interactive tutorial: Swirl <br>
http://swirlstats.com/scn/

RStudio "Cheat sheets" are very useful summaries: <br>
https://rstudio.com/resources/cheatsheets/

https://www.tidyverse.org/learn/

<!-- put this in the last slide -- use jquery to append page # to all sections -->

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>

for(i=0;i<$("section").length;i++) {
if(i==0) continue
$("section").eq(i).append("<p style='font-size:20px;position:fixed;right:75px;bottom:10px;'>" + i + "</p>")
}

</script>
