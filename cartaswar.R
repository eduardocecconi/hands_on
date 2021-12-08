deck2[c(13, 26, 39, 52), ]

deck2$value[c(13, 26, 39, 52)]

deck2$value[c(13, 26, 39, 52)] <- c(14, 14, 14, 14)

head(deck2, 13)

##ou (caso não saiba a posição dos valores 
##que serão substituídos)

deck2$face

deck2$face == "ace"

sum(deck2$face == "ace")

deck2$face == "ace"

deck2$value[deck2$face == "ace"]

deck2$value[deck2$face == "ace"] <- 14
