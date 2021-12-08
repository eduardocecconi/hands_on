library(tidyverse)

#SCATTERPOINT estrutura básica
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))

#SCATTERPOINT estrutura básica
ggplot(data = mpg) +
  geom_point(mapping = aes(x = cyl, y = hwy))

#SCATTERPOINT estrutura básica
ggplot(data = mpg) +
  geom_point(mapping = aes(x = class, y = drv))

#SCATTERPOINT estrutura básica com COLOR fora do aes()
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

#SCATTERPOINT - POSITION ADJUSTMENT JITTER para evitar sobreposição
ggplot(data = mpg) + geom_point(
  mapping = aes(x = displ, y = hwy),
  position = "jitter"
)

#3ª variável - aesthetic COLOR
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = class))

#3ª variável - aesthetic SIZE
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, size = class))

#3ª variável - aesthetic ALPHA (transparência)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))

#3ª variável - aesthetic SHAPE (apenas 6 elementos)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))

#SMOOTH - 3ª variável dividindo categorias por tipo de linha
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))

#3ª variável - FACET: divide em vários gráficos pelas categorias
# da mesma variável (visualização por duas linhas)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)

#3ª variável - FACET: divide em vários gráficos pelas categorias
#(visualização cruzando duas variáveis)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ cyl)

#3ª variável - FACET: divide em vários gráficos pelas categorias
#(visualização pelas categorias em linhas)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ .)

#3ª variável - FACET: divide em vários gráficos pelas categorias
#(visualização pelas categorias em colunas)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(. ~ cyl)

#sobreposição de 2 geom diferentes
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth()

#sobreposição de 2 geom diferentes com filtro por uma categoria
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth(
  data = filter(mpg, class == "subcompact"),
  se = FALSE 
  )

#Estatística descritiva - STAT SUMMARY (mais de 20 possibilidades de 
# estatísticas - rodar ?stat_bin para conhecer todas)
ggplot(data = diamonds) + 
  stat_summary(
  mapping = aes(x = cut, y = depth), 
  fun.ymin = min,
  fun.ymax = max,
  fun.y = median
)

#BAR - 2ª variável em cor no argumento FILL
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = cut))

#BAR - 3ª variável no argumento FILL (subdivide as barras)
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity))

#BAR - 3ª variável com POSITION ADJUSTMENT (FILL)
ggplot(data = diamonds) + geom_bar(
  mapping = aes(x = cut, fill = clarity),
  position = "fill"
)

#BAR - 3ª variável com POSITION ADJUSTMENT (DODGE) 
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity),
  position = "dodge"
)

#BOXPLOT vertical
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot()

#BOXPLOT horizontal (COORD_FLIP)
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot() +
  coord_flip()

#PIE CHART transformado com COORD_POLAR de um BAR CHART
bar <- ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut), show.legend = FALSE,
  width = 1)+
  theme(aspect.ratio = 1) + labs(x = NULL, y = NULL)
bar + coord_polar()



