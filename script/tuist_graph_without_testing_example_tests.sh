tuist graph -t -f dot
sed -i '' '/Example/d; /Testing/d' graph.dot
dot -Tpng graph.dot -o Asset/graph.png
dot -Tpdf graph.dot -o Asset/graph.pdf
rm graph.dot
open Asset/graph.pdf