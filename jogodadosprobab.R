die <- c(1,2,3,4,5,6)

#criar data frame com cada combinação possível para
# o resultado de jogar 2 dados
rolls <- expand.grid(die, die)

#criar variável com a soma dos valores dos 2 dados
# em cada combinação
rolls$value <- rolls$Var1 + rolls$Var2

#atribuição de probabilidades para cada resultado
# no lançamento de 1 dado
prob<-c("1"=1/8,"2"=1/8,"3"=1/8,"4"=1/8,"5"=1/8,"6"=3/8)

#criar variável com as probabilidades para o dado 1
# no data frame
rolls$prob1 <- prob[rolls$Var1]

#criar variável com as probabilidades para o dado 2
# no data frame
rolls$prob2 <- prob[rolls$Var2]

#criar variável com probabilidade para cada combinação
# do lançamento dos 2 dados
rolls$prob <- rolls$prob1 * rolls$prob2

#cálculo do Valor Esperado para a soma dos 2 dados
# em infinitos lançamentos
sum(rolls$value * rolls$prob)
