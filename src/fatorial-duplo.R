library(xtable)
library(MASS)

tb <- expand.grid(A = gl(3, 1), B = gl(2, 1))

X <- cbind(model.matrix(~1, tb),
           model.matrix(~0 + A, tb),
           model.matrix(~0 + B, tb),
           model.matrix(~0 + A:B, tb))
X

print.table(X, zero.print = ".")
print.xtable(xtable(X, digits = 0), only.contents = TRUE)

X <- model.matrix(~A * B, tb)
X

# 1 & 1 & . & . & 1 & . & 1 & . & . & . & . & . \\
# 1 & . & 1 & . & 1 & . & . & 1 & . & . & . & . \\
# 1 & . & . & 1 & 1 & . & . & . & 1 & . & . & . \\
# 1 & 1 & . & . & . & 1 & . & . & . & 1 & . & . \\
# 1 & . & 1 & . & . & 1 & . & . & . & . & 1 & . \\
# 1 & . & . & 1 & . & 1 & . & . & . & . & . & 1 \\

print.table(X, zero.print = ".")
print.xtable(xtable(X, digits = 0), only.contents = TRUE)

X <- model.matrix(~A * B, tb,
                  contrasts.arg = list(A = contr.sum,
                                       B = contr.sum))
X

print.table(X, zero.print = ".")
print.xtable(xtable(X, digits = 0), only.contents = TRUE, include.rownames = FALSE)

X <- model.matrix(~A * B, tb,
                  contrasts.arg = list(A = contr.helmert,
                                       B = contr.helmert))
X

solve(cbind(1, attr(X, "contrasts")$A))

print.table(X, zero.print = ".")
print.xtable(xtable(X, digits = 0), only.contents = TRUE, include.rownames = FALSE)

    # 1 & -1 & -1 & -1 & 1 & 1 \\
    # 1 & 1 & -1 & -1 & -1 & 1 \\
    # 1 & . & 2 & -1 & . & -2 \\
    # 1 & -1 & -1 & 1 & -1 & -1 \\
    # 1 & 1 & -1 & 1 & 1 & -1 \\
    # 1 & . & 2 & 1 & . & 2 \\

#-----------------------------------------------------------------------

a <- attr(X, "assign")
# X <- rbind(X, X, X)

proj <- function(X) {
    X %*% solve(crossprod(X), t(X))
}


H <- fractions(proj(X[, a <= 0]))
H
print.xtable(xtable(as.character(H)),
             only.contents = TRUE,
             include.rownames = FALSE)

H <- fractions(proj(X[, a <= 1]))
H
print.xtable(xtable(as.character(H)),
             only.contents = TRUE,
             include.rownames = FALSE)

H <- fractions(proj(X[, a <= 2]))
H
print.xtable(xtable(as.character(H)),
             only.contents = TRUE,
             include.rownames = FALSE)

#-----------------------------------------------------------------------
