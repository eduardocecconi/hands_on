deck3$value <- 0

head(deck3, 13)

deck3$value[deck3$suit == "hearts"] <- 1

deck3$value[deck3$suit == "hearts"]

queenOfSpades <- deck3$face == "queen" & deck3$suit == "spades"

deck3[queenOfSpades, ]

deck3$value[queenOfSpades]

deck3$value[queenOfSpades] <- 13

deck3[queenOfSpades, ]