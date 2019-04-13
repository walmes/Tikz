#!/usr/bin/Rscript

#-----------------------------------------------------------------------
# Clone the theme.

if (!dir.exists("site/themes/hugrid")) {
    cat("Cloning the theme:\n")
    system("git clone https://github.com/aerohub/hugrid.git site/themes/hugrid")
} else {
    cat("Theme already present.\n")
}

#-----------------------------------------------------------------------

fls <- dir(path = "src",
           pattern = "\\.png$",
           full.names = FALSE)

item_content <- function(file) {
    filename <- sub("\\.png$", "", file)
    proto <- paste0(c(
        '[[items]]',
        'title = "%s"',
        'image = "https://github.com/walmes/Tikz/raw/master/src/%s.png"',
        'thumb = "https://github.com/walmes/Tikz/raw/master/src/%s.png"',
        'alt = "%s"',
        'description = "github.com/walmes/Tikz"',
        'url = "https://github.com/walmes/Tikz/blob/master/src/%s.pgf"\n'),
        collapse = "\n")
    string <- do.call(sprintf,
                      c(list(fmt = proto),
                        replicate(n = 5,
                                  expr = filename,
                                  simplify = "list")))
    cat(string, "\n",
        file = "site/data/items.toml",
        append = TRUE)
}

invisible(file.remove("site/data/items.toml"))
cat("Creating/updating the `site/data/items.toml` file.\n")
invisible(sapply(fls, item_content))

cat("Run `hugo server` in the `site/` directory to see the results.\n")
cat("Run `sh _deploy` to upload site to server.\n")

#-----------------------------------------------------------------------
