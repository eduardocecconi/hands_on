deal <- function(cards){
  cards[1, ]
}
deal(deck)

deck2 <- deck[1:52, ]

head(deck2)

deck3 <- deck[c(2, 1, 3:52), ]

random <- sample(1:52, size = 52)

deck4 <- deck[random, ]

head(deck4)

shuffle <- function(cards){
  random <- sample(1:52, size = 52)
  cards[random, ]
}
deck2 <- shuffle(deck)

deal(deck2)
