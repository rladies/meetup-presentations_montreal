<style>
.reveal code {
    font-family: monospace;
    color: green; 
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

R Ladies: Introductory dplyr workshop 
======================================================== 
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
**Welcome, housekeeping, future topics** <br>

6:30PM - 6:45PM <br> 
**Introduction to the dplyr package: Tutorial by Roger Peng**

6:45PM - 8:00PM <br> 
**Interactive dplyr exercises**
</small>


Introduction & Housekeeping 
========================================================
incremental: true   

Welcome to R Ladies Montreal! How may first-time attendees? 

We will skip the December meetup and resume January 16, 2020. 

As we line up the speakers and topics for next year, we would like your input! 



Future topics
========================================================
incremental: true   

Please take a few minutes now to fill out this survey: 

https://forms.gle/JvKpQe1a7TJL9o1a6



Introduction to the dplyr package: Tutorial by Roger Peng
========================================================

Roger Peng, PhD <br> 
Professor, Department of Biostatistics, Johns Hopkins 

Author of "Art of Data Science" textbook, 2016 

https://www.youtube.com/watch?v=aywFompr1F4



Where to learn more 
========================================================

<b> Data analysis and modelling </b> <br>
R for Data Science by Hadley Wickham & Garrett Grolemund <br>
https://r4ds.had.co.nz/

<b> The inner workings of R     </b> <br>
Advanced R by Hadley Wicham: Free e-book!  <br>
http://adv-r.had.co.nz/

'Data-transformation with dplyr' cheat sheet in your repo


Activity: Manipulating data in using dplyr  
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

Activity I: Instructions
========================================================
type: section
class: small-code

<small> Using dplyr and the example data, complete the following exercises: <br> <br> 
(1) Bind the two data frames into a single data frame. What are the new dimensions of the data frame? <br> 
(2) Delete the first column of the data with the "Notes"<br>
(3) Remove all observations where Average.LMP.Gestational.Age has missing values <br>
(4) Calculate the average birth weight by state using mutate and summarise. How are the results different? <br>
(5) What were the the states with the 5 highest fertility rates in 2010 (tricky question!) <br> <br>

Useful functions: `bind_rows()`, `select()`, `filter()`, `mutate()`,<br> `summarise()`, `arrange()`, `top_n()` </small> 



<!-- put this in the last slide -- use jquery to append page # to all sections -->

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>

for(i=0;i<$("section").length;i++) {
if(i==0) continue
$("section").eq(i).append("<p style='font-size:20px;position:fixed;right:75px;bottom:40px;'>" + i + "</p>")
}

</script>
