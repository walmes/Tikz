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
print.xtable(xtable(prob, align = rep("r", ncol(qtl) + 1)),
             floating = FALSE,
             sanitize.text.function = identity,
             sanitize.colnames.function = identity,
             sanitize.rownames.function = identity)
sink()

#-----------------------------------------------------------------------
# t-Student.

df <- c(seq(1, 30, by = 1), 40, 60, 120)
alp <- c(0.4, 0.25, 0.10, 0.05, 0.025, 0.01, 0.005, 0.0025, 0.001, 0.0005)
qtl <- outer(df,
              alp,
              FUN = function(d, a) {
                  sprintf("$%0.4f$", qt(a, df = d, lower.tail = FALSE))
              })

rownames(qtl) <- sprintf("$%d$", df)
colnames(qtl) <- sprintf("$%s$", as.character(alp))
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
alp <- c(0.1, 0.05, 0.025, 0.01, 0.005)
alp <- c(1 - rev(alp), 0.5, alp)
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

df1 <- c(seq(1, 10, by = 1), c(12, 15, 20, 24, 30, 40, 60, 120))
df2 <- df1
alp <- c(0.05)
qtl <- outer(df1,
             df2,
             FUN = function(num, den) {
                 sprintf("$%0.3f$",
                         qf(alp, df1 = num, df2 = den, lower.tail = FALSE))
             })

rownames(qtl) <- sprintf("$%d$", df1)
colnames(qtl) <- sprintf("$%d$", df2)
qtl

sink("table-f-snedecor.tex")
print.xtable(xtable(qtl, align = rep("r", ncol(qtl) + 1)),
             floating = FALSE,
             sanitize.text.function = identity,
             sanitize.colnames.function = identity,
             sanitize.rownames.function = identity)
sink()

#-----------------------------------------------------------------------
