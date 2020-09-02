#!/usr/bin/Rscript

#-----------------------------------------------------------------------

pgf <- dir(path = "src", pattern = "\\.pgf$", full.names = FALSE)
png <- dir(path = "src", pattern = "\\.png$", full.names = FALSE)

fls <- setdiff(sub("\\.pgf$", "", pgf),
               sub("\\.png$", "", png))
if (length(fls)) {
    fls <- paste0(fls, ".pgf")
    cat("Arquivos PGF sem o correspondente PNG:", sep = "\n")
    cat(fls, sep = "\n")
} else {
    cat("Nenhum arquivo está sem par.", sep = "\n")
}


#-----------------------------------------------------------------------
