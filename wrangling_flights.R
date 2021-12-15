library(tidyverse)
library(nycflights13)

flights <- (nycflights13::flights)

View(flights)

#FILTER - exercícios páginas 49/50
#seleciona observações pelo valor através de argumentos lógicos

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
#reordena as linhas

na_acima <- arrange(flights, desc(is.na(flights)))

mais_atrasados <- arrange(flights, desc(flights$arr_delay), flights$dep_delay)

rapidos <- arrange(flights, flights$air_time)

longos <- arrange(flights, desc(flights$distance))

curtos <- arrange(flights, flights$distance)

#SELECT - exercícios página 51
#seleciona variáveis pelo nome

select(flights, dep_time:arr_delay, -c(sched_dep_time, sched_arr_time))

select(flights, contains("TIME"))

#MUTATE - exercícios página 58
#cria variáveis com funções aplicadas em variáveis que estão no dataframe

flights_sml <- select(flights, 
               year:day, ends_with("delay"), 
               distance, air_time
) 

mutate(flights_sml,
      gain = arr_delay - dep_delay,
      speed = distance / air_time * 60
)

mutate(flights_sml,
       gain = arr_delay - dep_delay, 
       hours = air_time / 60, 
       gain_per_hour = gain / hours
)

transmute(flights,
          gain = arr_delay - dep_delay, 
          hours = air_time / 60, 
          gain_per_hour = gain / hours
)

transmute(flights, dep_time,
          hour = dep_time %/% 100, 
          minute = dep_time %% 100
)

transmute(flights, sched_dep_time,
          hour = sched_dep_time %/% 100, 
          minute = sched_dep_time %% 100
)

all_of <- mutate(flights, voo = arr_time - dep_time)

voo2 <- select(voo, air_time, voo)

voo3 <- flights %>% mutate(hour_dep = dep_time %/% 100, 
                      minute_dep = dep_time %% 100) %>%
                    mutate(hour_arr = arr_time %/% 100, 
                      minute_arr = arr_time %% 100) %>%
                    mutate(air_hour = hour_arr - hour_dep) %>%
                    mutate(minute = minute_arr - minute_dep) %>%
                    select(air_hour, minute, air_time, everything())

#SUMMARIZE e GROUP_BY - exemplos e exercícios da página 72/73 
#Summarize quebra um dataframe em uma única linha;
#quando combinado com Group_by, analisa grupos do dataframe

#exemplo com uso do pipe:
#1 Group flights by destination.
#2 Summarize to compute distance, average delay, and 
#number of flights.
#3 Filter to remove noisy points and Honolulu airport

delays <- flights %>% 
  group_by(dest) %>% 
  summarize(
  count = n(), 
  dist = mean(distance, na.rm = TRUE),
  delay = mean(arr_delay, na.rm = TRUE) 
  ) %>%
  filter(count > 20, dest != "HNL")

ggplot(data = delays, mapping = aes(x = dist, y = delay)) +
  geom_point(aes(size = count), alpha = 1/3) +
  geom_smooth(se = FALSE)
##

#exemplo2
not_cancelled <- flights %>% 
  filter(!is.na(dep_delay), !is.na(arr_delay))

not_cancelled %>%
  group_by(year, month, day) %>% 
  summarize(mean = mean(dep_delay))

delays <- not_cancelled %>% 
  group_by(tailnum) %>% 
  summarize(
  delay = mean(arr_delay, na.rm = TRUE),
  n=n() 
)

delays %>%
  filter(n > 25) %>%
  ggplot(mapping = aes(x = n, y = delay)) +
    geom_point(alpha = 1/10)

##
# exemplo 3

not_cancelled %>% group_by(year, month, day) %>% summarize(
  # average delay:
  avg_delay1 = mean(arr_delay),
  # average positive delay:
  avg_delay2 = mean(arr_delay[arr_delay > 0])
)

##MEDIDAS DE DISPERSÃO E POSIÇÃO

not_cancelled %>%
  group_by(dest) %>%
  summarize(distance_sd = sd(distance)) %>% 
  arrange(desc(distance_sd)
  )

not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarize(
    first = min(dep_time),
    last = max(dep_time) 
  )

not_cancelled %>% 
  group_by(year, month, day) %>% 
  summarize(
    first_dep = first(dep_time),
    last_dep = last(dep_time) 
  )

not_cancelled %>%
  group_by(year, month, day) %>%
  mutate(r = min_rank(desc(dep_time))) %>% 
  filter(r %in% range(r)
  )

#COUNT simples por variável
not_cancelled %>% 
  count(dest)

#COUNT com variável de peso (weight)
not_cancelled %>% 
  count(tailnum, wt = distance)

#COUNT e MÉDIA de valores lógicos
not_cancelled %>%
  group_by(year, month, day) %>%
  summarize(n_early = sum(dep_time < 500)
  )

not_cancelled %>%
  group_by(year, month, day) %>%
  summarize(hour_perc = mean(arr_delay > 60)
  )

daily <- group_by(flights, year, month, day) 
(per_day <-summarize(daily,flights=n()))
(per_month <- summarize(per_day, flights = sum(flights)))
(per_year <- summarize(per_month, flights = sum(flights)))

#UNGROUP
daily %>%
  ungroup() %>%
  summarize(flights = n())

#GROUP BY COMBINADO COM MUTATE E FILTER
flights_sml %>%
  group_by(year, month, day) %>% 
  filter(rank(desc(arr_delay)) < 10)

popular_dests <- flights %>% 
  group_by(dest) %>% 
  filter(n() > 365)

popular_dests %>%
  filter(arr_delay > 0) %>%
  mutate(prop_delay = arr_delay / sum(arr_delay)) %>% 
  select(year:day, dest, arr_delay, prop_delay)

vignette("window-functions")

#EXERCÍCIOS PÁGINAS 72/73 - **PENDENTE**

#EXERCÍCIOS PÁGINAS 75/76 - **PENDENTE**




  
