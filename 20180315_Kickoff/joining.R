# template for joining slides

install.packages('pacman')
library(pacman)

pacman::p_load(data.table, dplyr, tinytex, knitr, xtable)

# Scenario 1 
day1 =  data.table(ID=LETTERS[1:12],
                   IQ=round(rnorm(12, 100, 15),2))

day2 =  data.table(ID=LETTERS[6:17],
                   IQ=round(rnorm(12, 100, 20),2))

day1
day2

left = left_join(day1, day2, by = 'ID')
right = right_join(day1, day2 , by = 'ID')
inner= inner_join(day1, day2, by = 'ID')
full = full_join(day1, day2, by = 'ID')
semi = semi_join(day1, day2, by = 'ID')
anti = anti_join(day1, day2, by = 'ID')
inter = dplyr::intersect(day1, day2, by = 'ID')
united = union(day1, day2, by = 'ID')
setdif = setdiff(day1, day2, by = 'ID')

xtable(day1)
mutate.list
       
left
right
inner
full
semi
anti
inter
united
setdif 

inter2 = dplyr::intersect(day1, day2)
inter2





