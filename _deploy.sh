#!/bin/sh

cd site/
hugo

# Tree of the directories.
echo "------------------------------------------------------------------------"
echo "Directory tree.\n"
tree -h -F public/ -L 1
# tree -h -F _site/slides
# tree -h -F _site/scripts
# tree -h -F _site/tutorials

# Upload.
echo "------------------------------------------------------------------------"
echo "Uploading files to server.\n"
rsync -avzp \
      ./public/ \
      --progress \
      --rsh="ssh -p$PATAXOP" "$PATAXO:~/public_html/Tikz/"

# Vist the homepage.
echo "------------------------------------------------------------------------"
echo "Visiting the webpage.\n"
firefox http://leg.ufpr.br/~walmes/Tikz
