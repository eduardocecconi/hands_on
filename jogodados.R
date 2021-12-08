##jogo de 2 dados retornando os 2 valores
die <- 1:6
roll <- function(){
  dice <- sample(die, size = 2, replace = TRUE)
  show(dice)
}

roll()

##jogo de 2 dados retornando a soma dos valores (com histograma)
roll2 <- function(){
  dice <- sample(die, size = 2, replace = TRUE)
  sum(dice)
}

roll2()

library(ggplot2)
rolls <- replicate(10000, roll2()) 
qplot(rolls, binwidth = 1)

##Jogo de dados "batizado" com probabilidade maior para o '6'

roll3 <- function() {
  die <- 1:6
  dice <- sample(die, size = 2, replace = TRUE,
    prob = c(1/8, 1/8, 1/8, 1/8, 1/8, 3/8))
  sum(dice)
}

roll3()

rolls2 <- replicate(10000, roll3()) 
qplot(rolls2, binwidth = 1)

