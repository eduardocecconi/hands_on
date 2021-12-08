library(tidyverse)
library(nycflights13)

flights <- (nycflights13::flights)

View(flights)

#FILTER - exercícios páginas 49/50
delay_twoormore <- filter(flights, flights$arr_delay >= 2)

houston <- filter(flights, flights$dest == "IAH" | flights$dest == "HOU")

companhia <- filter(flights, flights$carrier == "UA" 
                    | flights$carrier == "AA" | flights$carrier == "DL")

verao <- filter(flights, flights$month == 7 | flights$month == 8 
                | flights$month == 9)

atraso_chegada <- filter(flights, flights$dep_delay <= 0 
                         & flights$arr_delay >= 2)

recuperou_ar <- filter(flights, flights$dep_delay >= 1 &
         flights$arr_delay < flights$dep_delay)


na_partida <- filter(flights, is.na(flights$dep_time))

#ARRANGE - exercícios página 51

na_acima <- arrange(flights, desc(is.na(flights)))

mais_atrasados <- arrange(flights, desc(flights$arr_delay), flights$dep_delay)

rapidos <- arrange(flights, flights$air_time)

longos <- arrange(flights, desc(flights$distance))

curtos <- arrange(flights, flights$distance)

#SELECT - exercícios página 51
select(flights, dep_time:arr_delay, -c(sched_dep_time, sched_arr_time))

?one_of

select(flights, contains("TIME"))

?select




