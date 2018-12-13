ang2rad <- function(x) {
    2 * pi * x/360
}
rad2ang <- function(x) {
    360 * x/(2 * pi)
}
seq_angle <- function(from, to, ...) {
    th0 <- ang2rad(from)
    th1 <- ang2rad(to)
    y_seq <- seq(from = sin(th0), to = sin(th1), ...)
    rad2ang(asin(y_seq))
}
tikz_cmd <- function(angle, text, anchor) {
    fmt <- "\\node at (%0.3f:27em) [anchor = %s] {%s};"
    sprintf(fmt, angle, anchor, text)
}
txt1 <- c(
    "Lógica e estruturas de programação",
    "Introdução ao \\textit{R} e \\textit{Python}",
    # "Programação funcional",
    "\\textit{Extract, transform and load (ETL)}",
    "Estatística descritiva",
    "Análise gráfica exploratória",
    "\\textit{pandas} e \\textit{tidyverse}",
    "\\textit{matplotlib} e \\textit{ggplot2}",
    "Gráficos interativos",
    # "\\textit{Dashboards}",
    "Comunicação e relatórios dinâmicos",
    "\\textit{Web scraping}")
txt2 <- c(
    # "Componentes de \\textit{hardware}",
    "Sistemas de alto desempenho",
    # "\\textit{Shell script}",
    "Linhas de comando",
    "Tarefas agendadas",
    "Redes e segurança",
    "Protocolos de conexão",
    "Processamento em paralelo",
    "Processamento distribuído")
txt3 <- c(
    "Cálculo diferencial e integral",
    "Álgebra linear",
    "Métodos de otimização",
    # "Probabilidade",
    "Teoria de probabilidade",
    # "Distribuições de probabilidade",
    "Modelos de distribuições",
    "Processos estocásticos",
    "Métodos de amostragem",
    "Procedimentos de inferência",
    "Testes de hipótese",
    "Estimação e previsão")
txt4 <- c(
    "Regressão linear",
    "Regressão não linear",
    "Splines e GAMs",
    "Modelos lineares generalizados",
    "Árvores de decisão",
    "Seleção de modelos",
    "Análise de sobrevivência",
    "Séries temporais",
    "Estatística espacial",
    "Análise fatorial",
    "Análise de variância")
txt5 <- c(
    # "Aprendizado supevisionado",
    "Tipos de aprendizado",
    "Algorítmos de classificação",
    "Algorítmos de regressão",
    # "\\textit{Support vector machines}",
    # "\\textit{Random forest}",
    # "Redes neurais",
    # "Aprendizado não supevisionado",
    "\\textit{Ensembles}",
    "\\textit{Deep learning}",
    "Análise de agrupamento",
    "Redução de dimensão",
    "Regras de associação",
    "Análise de sentimentos",
    "Modelagem de tópicos",
    "Redes Bayesianas")
txt6 <- c(
    "Sistemas de BD para \\textit{Big Data}",
    "Modelo relacional",
    "Modelagem de banco de dados",
    "\\textit{ETL} em \\textit{SQL}",
    "Banco de dados \\textit{NoSQL}",
    "\\textit{Data warehouse}",
    "\\textit{Data cleaning}",
    "Integração de dados",
    "Processamento em \\textit{MapReduce}",
    "\\textit{Hadoop} e \\textit{Spark}")
u1 <- tikz_cmd(angle = seq_angle(88, 25, length.out = length(txt1)), text = txt1, anchor = "west")
u2 <- tikz_cmd(angle = seq_angle(15, -15, length.out = length(txt2)), text = txt2, anchor = "west")
u3 <- tikz_cmd(angle = seq_angle(-25, -88, length.out = length(txt3)), text = txt3, anchor = "west")
# cat(c(u1, u2, u3), sep = "\n")
u4 <- tikz_cmd(angle = 180 - seq_angle(-145, -100, length.out = length(txt4)), text = rev(txt4), anchor = "east")
u5 <- tikz_cmd(angle = 180 - seq_angle(160, -160, length.out = length(txt5)), text = rev(txt5), anchor = "east")
u6 <- tikz_cmd(angle = 180 - seq_angle(100, 145, length.out = length(txt6)), text = rev(txt6), anchor = "east")
# cat(c(u4, u5, u6), sep = "\n")
cat(c(u1, u2, u3, u4, u5, u6), sep = "\n")
