#-----------------------------------------------------------------------
#                                            Prof. Dr. Walmes M. Zeviani
#                                leg.ufpr.br/~walmes · github.com/walmes
#                                        walmes@ufpr.br · @walmeszeviani
#                      Laboratory of Statistics and Geoinformation (LEG)
#                Department of Statistics · Federal University of Paraná
#                                       2020-ago-19 · Curitiba/PR/Brazil
#-----------------------------------------------------------------------

library(xtable)

#-----------------------------------------------------------------------
# Standard Normal.

dec <- seq(0, 3.9, by = 0.1)
cen <- seq(0.00, 0.09, by = 0.01)
prob <- outer(dec,
              cen,
              FUN = function(d, c) {
                  sprintf("$%0.6f$",
                          pnorm(d + c) - 0.5)
              })

rownames(prob) <- sprintf("$%0.2f$", dec)
colnames(prob) <- sprintf("$%0.2f$", cen)
prob

sink("table-standard-normal.tex")
print.xtable(xtable(prob, align = rep("r", ncol(prob) + 1)),
             floating = FALSE,
             sanitize.text.function = identity,
             sanitize.colnames.function = identity,
             sanitize.rownames.function = identity)
sink()

#-----------------------------------------------------------------------
# t-Student.

df <- c(seq(1, 30, by = 1), 40, 60, 120)
# alp <- c(0.4, 0.25, 0.10, 0.05, 0.025, 0.01, 0.005, 0.0025, 0.001, 0.0005)

alp <- c(
    0.40, 0.30, 0.25, 0.20, 0.15, 0.10, 0.09, 0.08, 0.07, 0.06,
    0.05, 0.04, 0.03, 0.025, 0.020, 0.010, 0.005, 0.0025, 0.0010,
    0.0005
)
length(alp)

alp <- c(
    0.20, 0.10, 0.05, 0.025, 0.010, 0.005, 0.0025, 0.0010
)
length(alp)

# a <- alp[1:10]
# a <- alp[11:20]
a <- alp

qtl <- outer(df,
             a,
             FUN = function(d, a) {
                 sprintf("$%0.4f$", qt(a, df = d, lower.tail = FALSE))
             })

rownames(qtl) <- sprintf("$%d$", df)
colnames(qtl) <- sprintf("$%s$", as.character(a))
qtl

sink("table-t-student.tex")
print.xtable(xtable(qtl, align = rep("r", ncol(qtl) + 1)),
             floating = FALSE,
             sanitize.text.function = identity,
             sanitize.colnames.function = identity,
             sanitize.rownames.function = identity)
sink()

#-----------------------------------------------------------------------
# \chi^2.

df <- c(seq(1, 30, by = 1), seq(40, 100, by = 10))
# alp <- c(0.1, 0.05, 0.025, 0.01, 0.005)
# alp <- c(1 - rev(alp), 0.5, alp)

alp <- c(
    0.995, 0.99, 0.98, 0.975, 0.97, 0.96, 0.95, 0.90, 0.85, 0.80,
    0.75, 0.50, 0.50, 0.25, 0.20, 0.15, 0.10, 0.05, 0.04, 0.03,
    0.025, 0.02, 0.01, 0.005
)

alp <- c(
    0.20, 0.10, 0.05, 0.025, 0.010, 0.005, 0.0025, 0.0010
)

qtl <- outer(df,
              alp,
              FUN = function(d, a) {
                  sprintf("$%0.3f$", qchisq(a, df = d, lower.tail = FALSE))
              })

rownames(qtl) <- sprintf("$%d$", df)
colnames(qtl) <- sprintf("$%s$", as.character(alp))
qtl

sink("table-chi-squared.tex")
print.xtable(xtable(qtl, align = rep("r", ncol(qtl) + 1)),
             floating = FALSE,
             sanitize.text.function = identity,
             sanitize.colnames.function = identity,
             sanitize.rownames.function = identity)
sink()

#-----------------------------------------------------------------------
# F de Snedecor.

# df1 <- c(seq(1, 10, by = 1), c(12, 15, 20, 24, 30, 40, 60, 120))
# df2 <- df1
df1 <- c(seq(1, 40, by = 1))
df2 <- 1:12
# alp <- c(0.10, 0.05, 0.01)
alp <- c(0.05)

qtl_list <-
    lapply(alp,
           FUN = function(a) {
               qtl <- outer(df1,
                            df2,
                            FUN = function(num, den) {
                                sprintf("$%0.3f$",
                                        qf(a,
                                           df1 = num,
                                           df2 = den,
                                           lower.tail = FALSE))
                            })
               colnames(qtl) <- sprintf("$%d$", df2)
               rownames(qtl) <- sprintf("$%d$", df1)
               u <- qtl[1,, drop = FALSE]
               u[1, ] <- ""
               u[1, 1] <- sprintf("$\\alpha = %s$", round(a, 4))
               colnames(u) <- colnames(qtl)
               rownames(u) <- NULL
               qtl <- rbind(u, qtl)
               qtl
           })

# qtl_list[[2]][1:5, 1:5]
#
# rbind(qtl_list[[1]], qtl_list[[1]], make.row.names = FALSE)
#
# help(rbind, h = "html")

qtl <- do.call(rbind, args = qtl_list)
rownames(qtl)

qtl <- cbind("$\\phantom{0}$" = rownames(qtl), as.data.frame(qtl))

sink("table-f-snedecor.tex")
print.xtable(xtable(qtl, align = rep("r", ncol(qtl) + 1)),
             floating = FALSE,
             include.rownames = FALSE,
             sanitize.text.function = identity,
             sanitize.colnames.function = identity,
             sanitize.rownames.function = identity)
sink()

#-----------------------------------------------------------------------
# Tukey.

nmeans <- seq(2, 15, by = 1)
# df <- c(seq(2, 40, by = 1), 60, 120)
df <- c(seq(2, 20, by = 1), 24, 30, 40, 60, 120)
alp <- c(0.10, 0.05, 0.01)
a <- 0.1

# Confere.
qtukey(0.95, df = 10, nmeans = 2)/sqrt(2)
qt(0.975, df = 10)

qtl_list <-
    lapply(alp,
           FUN = function(a) {
               qtl <- outer(nmeans,
                            df,
                            FUN = function(num, den) {
                                sprintf("$%0.3f$",
                                        qtukey(a,
                                               nmeans = num,
                                               df = den,
                                               lower.tail = FALSE))
                            }) |> t()
               colnames(qtl) <- sprintf("$%d$", nmeans)
               rownames(qtl) <- sprintf("$%d$", df)
               u <- qtl[1,, drop = FALSE]
               u[1, ] <- ""
               u[1, 1] <- sprintf("$\\alpha = %s$", round(a, 4))
               colnames(u) <- colnames(qtl)
               rownames(u) <- NULL
               qtl <- rbind(u, qtl)
               qtl
           })

# qtl_list[[1]]

qtl <- do.call(rbind, args = qtl_list)
rownames(qtl)

qtl <- cbind("$\\phantom{0}$" = rownames(qtl), as.data.frame(qtl))

sink("table-q-tukey.tex")
print.xtable(xtable(qtl, align = rep("r", ncol(qtl) + 1)),
             floating = FALSE,
             include.rownames = FALSE,
             sanitize.text.function = identity,
             sanitize.colnames.function = identity,
             sanitize.rownames.function = identity)
sink()

#-----------------------------------------------------------------------
# Teste de Duncan.

nmeans <- seq(2, 15, by = 1)
# df <- c(seq(2, 40, by = 1), 60, 120)
df <- c(seq(2, 20, by = 1), 24, 30, 40, 60, 120)
alp <- c(0.10, 0.05, 0.01)
a <- 0.1

qtl_list <-
    lapply(alp,
           FUN = function(a) {
               qtl <- outer(nmeans,
                            df,
                            FUN = function(num, den) {
                                sprintf("$%0.3f$",
                                        qtukey((1 - a)^(num - 1),
                                               nmeans = num,
                                               df = den,
                                               lower.tail = TRUE))
                            }) |> t()
               colnames(qtl) <- sprintf("$%d$", nmeans)
               rownames(qtl) <- sprintf("$%d$", df)
               u <- qtl[1,, drop = FALSE]
               u[1, ] <- ""
               u[1, 1] <- sprintf("$\\alpha = %s$", round(a, 4))
               colnames(u) <- colnames(qtl)
               rownames(u) <- NULL
               qtl <- rbind(u, qtl)
               qtl
           })

# qtl_list[[2]]

qtl <- do.call(rbind, args = qtl_list)
rownames(qtl)

qtl <- cbind("$\\phantom{0}$" = rownames(qtl), as.data.frame(qtl))

sink("table-z-duncan.tex")
print.xtable(xtable(qtl, align = rep("r", ncol(qtl) + 1)),
             floating = FALSE,
             include.rownames = FALSE,
             sanitize.text.function = identity,
             sanitize.colnames.function = identity,
             sanitize.rownames.function = identity)
sink()

#-----------------------------------------------------------------------
