What is dplyr?
--------------

-   wrangling/cleaning/manipulation
-   human readable
-   best when paired with the piping operator %&gt;%

Install and load dplyr
----------------------

    #install.packages("dplyr")
    library(dplyr)

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

Example data
------------

-   We'll use a dataset on life expectancy for black and white Americans
    to practice using `dplyr`
-   Let's start by importing these data into R

<!-- -->

    # Read in the dataset
    BlackWhite_results <- read.csv("./BlackWhite_results.csv")

Take a peak
-----------

-   Let's use RStudio's viewer to look at these data.
-   Click the table icon next to BlackWhite\_results in the environment
    tab or run `View(BlackWhite_results)`
-   If you aren't using RStudio, you can use `head(BlackWhite_results)`
    to see the first six lines of data

<!-- -->

    dim(BlackWhite_results)

    ## [1] 3600   24

    names(BlackWhite_results)

    ##  [1] "X.2"               "X.1"               "X"                
    ##  [4] "stratum.id"        "LE_white_lcl"      "LE_white_med"     
    ##  [7] "LE_white_ucl"      "LE_white_mean"     "LE_black_lcl"     
    ## [10] "LE_black_med"      "LE_black_ucl"      "LE_black_mean"    
    ## [13] "LE_wbgap_lcl"      "LE_wbgap_med"      "LE_wbgap_ucl"     
    ## [16] "LE_wbgap_mean"     "state"             "year"             
    ## [19] "sex"               "Census_Region"     "Census_Division"  
    ## [22] "stabbrs"           "state.map.order"   "stabbrs.map.order"

So. many. variables.
--------------------

Let's only keep a subset for further use.

dplyr select() to keep or discard variables
-------------------------------------------

-   `select()` is used to select a subset of variables from an existing
    data frame.
-   You can explicitly select the variables you'd like to keep, or
    "negatively" `select()` (i.e, remove) variables you'd like
    to discard.

<!-- -->

    subset <- select(BlackWhite_results, 
                     LE_white_mean, LE_black_mean,
                     state, year, sex, stabbrs)

    names(subset)

    ## [1] "LE_white_mean" "LE_black_mean" "state"         "year"         
    ## [5] "sex"           "stabbrs"

    dim(subset)

    ## [1] 3600    6

dplyr select() to keep or discard variables (columns)
-----------------------------------------------------

Write this another way using the **piping** operator (%&gt;%)

    subset2 <- BlackWhite_results %>% 
      select(LE_white_mean, LE_black_mean,
             state, year, sex, stabbrs)

Confirm that `subset` and `subset2` are identical:

    identical(subset, subset2)

    ## [1] TRUE

    BlackWhite_results <- subset2

dplyr mutate() to add a new variable
------------------------------------

-   What if you wanted to calculate the difference (in years) between
    the life expectancy for blacks and whites?

<!-- -->

    BlackWhite_results <- BlackWhite_results %>% 
      mutate(diff = LE_white_mean - LE_black_mean)

dplyr mutate() to add a new variable
------------------------------------

-   Take a peak to see the calculated difference

<!-- -->

    head(BlackWhite_results)

    ##   LE_white_mean LE_black_mean   state year    sex stabbrs     diff
    ## 1      75.75853      67.96007 Alabama 1969 Female      AL 7.798463
    ## 2      66.60871      59.47522 Alabama 1969   Male      AL 7.133492
    ## 3      75.89518      68.24888 Alabama 1970 Female      AL 7.646296
    ## 4      66.74232      59.91964 Alabama 1970   Male      AL 6.822686
    ## 5      76.15512      68.91674 Alabama 1971 Female      AL 7.238381
    ## 6      66.89219      60.17679 Alabama 1971   Male      AL 6.715395

dplyr rename() to rename a variable
-----------------------------------

-   Let's rename the `sex` variable as `gender`

<!-- -->

    BlackWhite_results <- BlackWhite_results %>% 
      rename(gender = sex)

    names(BlackWhite_results)

    ## [1] "LE_white_mean" "LE_black_mean" "state"         "year"         
    ## [5] "gender"        "stabbrs"       "diff"

dplyr arrange() to sort the dataset based on one or several variables
---------------------------------------------------------------------

-   Try `arrange()`ing the dataset by the `diff` variable, and by
    `-diff`
-   Have a look at the results to compare

<!-- -->

    Results_sort1 <- BlackWhite_results %>% 
      arrange(diff)

    Results_sort2 <- BlackWhite_results %>% 
      arrange(-diff)

    head(Results_sort1)

    ##   LE_white_mean LE_black_mean         state year gender stabbrs       diff
    ## 1      82.06529      84.80365  Rhode Island 2013 Female      RI -2.7383614
    ## 2      82.04218      84.47348  Rhode Island 2012 Female      RI -2.4312951
    ## 3      81.98986      83.60224  Rhode Island 2011 Female      RI -1.6123805
    ## 4      82.71067      83.82573 Massachusetts 2013 Female      MA -1.1150616
    ## 5      82.02776      83.04855  Rhode Island 2010 Female      RI -1.0207902
    ## 6      76.64974      77.60831  Rhode Island 2013   Male      RI -0.9585714

    head(Results_sort2)

    ##   LE_white_mean LE_black_mean         state year gender stabbrs     diff
    ## 1      75.34786      58.69235 Washington DC 1996   Male      DC 16.65552
    ## 2      74.13105      57.66119 Washington DC 1995   Male      DC 16.46986
    ## 3      76.45846      60.57767 Washington DC 1997   Male      DC 15.88079
    ## 4      72.85688      56.98562 Washington DC 1993   Male      DC 15.87126
    ## 5      78.79576      62.98452 Washington DC 2002   Male      DC 15.81123
    ## 6      72.84949      57.08281 Washington DC 1994   Male      DC 15.76668

dplyr filter() to subset the data's rows based on a condition
-------------------------------------------------------------

-   Let's use `filter()` to create a new dataset `ny.women` that
    contains only women from New York.

<!-- -->

    ny.women <- BlackWhite_results %>% 
      filter(state == "New York", gender == "Female")

    dim(ny.women)

    ## [1] 45  7

dplyr summarise() to perform an aggregated calculation
------------------------------------------------------

-   Summarise can be used to calculate summary statistics
-   What variable does this code summarize over?

<!-- -->

    ny.women %>% 
      summarise(average.le.white = round(mean(LE_white_mean), 1),
                average.le.black = round(mean(LE_black_mean), 1))

    ##   average.le.white average.le.black
    ## 1             79.3             75.9

Stacking dplyr() functions using %&gt;%
---------------------------------------

-   What does this code do?

<!-- -->

     BlackWhite_results %>% 
      filter(state == "New York", gender == "Female", year > 2010) %>%
      summarise(average.le.white = round(mean(LE_white_mean), 1),
                average.le.black = round(mean(LE_black_mean), 1))

    ##   average.le.white average.le.black
    ## 1             82.9             82.5

dplyr group\_by() %&gt;% summarise()
------------------------------------

-   Pair together `group_by()` and `summarise()` to calculate summary
    statistics within groups

<!-- -->

    yearly.means <- BlackWhite_results %>% 
      group_by(year, gender) %>%
      summarise(ave.yr.gender = mean(diff))

dplyr cheat sheet
-----------------

-   <https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf>

Connect
-------

-   Mail: <corinne.riddell@mail.mcgill.ca>
-   Web: corinneriddell.com
-   GitHub: corinne-riddell
-   Twitter: @datavisitor
