get_symbols <- function() {
  wheel <- c("DD", "7", "BBB", "BB", "B", "C", "0") 
  sample(wheel, size = 3, replace = TRUE,
  prob = c(0.03, 0.03, 0.06, 0.1, 0.25, 0.01, 0.52))
}

get_symbols()

score <- function (symbols) {
# identify case
same <- symbols[1] == symbols[2] && symbols[2] == symbols[3] 
bars <- symbols %in% c("B", "BB", "BBB")

# get prize
if (same) {
  payouts <- c("DD" = 100, "7" = 80, "BBB" = 40, "BB" = 25,
               "B"=10,"C"=10,"0"=0) 
  prize <- unname(payouts[symbols[1]])
} else if (all(bars)) { 
  prize <- 5
}else{
  cherries <- sum(symbols == "C") 
  prize <- c(0, 2, 5)[cherries + 1]
}

# adjust for diamonds
diamonds <- sum(symbols == "DD")
prize * 2 ^ diamonds

}


play <- function() { 
  symbols <- get_symbols() 
  structure(score(symbols), symbols = symbols, class = "slots")
}

one_play <- play()

slot_display <- function(prize){
  # extract symbols
  symbols <- attr(prize, "symbols")
  # collapse symbols into single string
  symbols <- paste(symbols, collapse = " ")
  # combine symbol with prize as a regular expression
  # \n is regular expression for new line (i.e. return 
  # or enter)
  string <- paste(symbols, prize, sep = "\n$")
  # display regular expression in console without quotes
  cat(string)
}
  
slot_display(play())

class(one_play) <- "slots"

print.slots <- function(x, ...) { 
  slot_display(x)
}

one_play

play()

# cálculo de probabilidades com atribuição de valores
wheel <- c("DD", "7", "BBB", "BB", "B", "C", "0")
combos <- expand.grid(wheel, wheel, wheel, stringsAsFactors = FALSE)
prob <- c("DD" = 0.03, "7" = 0.03, "BBB" = 0.06, "BB" = 0.1, 
          "B" = 0.25, "C" = 0.01, "0" = 0.52)

combos$prob1 <- prob[combos$Var1]

combos$prob2 <- prob[combos$Var2]

combos$prob3 <- prob[combos$Var3]

combos$prob <- (combos$prob1 * combos$prob2 * combos$prob3)

head(combos, 3)

sum(combos$prob)

combos$prize <- NA

head(combos, 3)

for (i in 1:nrow(combos)){
  symbols <- c(combos[i, 1], combos[i, 2], combos[i, 3])
  combos$prize[i] <- score(symbols)
}

head(combos)

#Expected Value
sum(combos$prize * combos$prob)

## FUNÇÃO SCORE REESCRITA PARA CALIBRAR A INFLUÊNCIA
## DOS DIAMANTES COMO "WILD CARD"

score <- function(symbols) { 
  diamonds <- sum(symbols == "DD")
  cherries <- sum(symbols == "C")
# identify case
# since diamonds are wild, only nondiamonds # matter for three of a kind and all bars 
slots <- symbols[symbols != "DD"]
same <- length(unique(slots)) == 1
bars <- slots %in% c("B", "BB", "BBB")
# assign prize
if (diamonds == 3) { prize <- 100
} else if (same) {
  payouts <- c("7" = 80, "BBB" = 40, "BB" = 25,
               "B"=10,"C"=10,"0"=0) 
  prize <- unname(payouts[slots[1]])
} else if (all(bars)) { 
  prize <- 5
} else if (cherries > 0) {
  # diamonds count as cherries
  # so long as there is one real cherry
  prize <- c(0, 2, 5)[cherries + diamonds + 1]
}else{ prize <- 0
}
# double for each diamond
prize * 2^diamonds
}

for (i in 1:nrow(combos)){
  symbols <- c(combos[i, 1], combos[i, 2], combos[i, 3])
  combos$prize[i] <- score(symbols)
}

head(combos)

#Expected Value
sum(combos$prize * combos$prob)
