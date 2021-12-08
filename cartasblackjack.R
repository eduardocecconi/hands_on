deck5 <- deck

head(deck5, 13)

facecard <- deck5$face %in% c("king", "queen", "jack")

deck5[facecard, ]


deck5$value[deck5$face == "ace"] <- NA


