echo "Example, Testing이 없는 의존성 그래프를 만듭니다."
tuist graph -t -f dot
sed -i '' '/Example/d; /Testing/d' graph.dot
dot -Tpng graph.dot -o Asset/graph.png
dot -Tpdf graph.dot -o Asset/graph.pdf
rm graph.dot

echo "Example, Testing, 3rd Party Library가 없는 의존성 그래프를 만듭니다."
tuist graph -d -t -f dot
sed -i '' '/Example/d; /Testing/d' graph.dot
dot -Tpng graph.dot -o Asset/graph_without_external.png
dot -Tpdf graph.dot -o Asset/graph_without_external.pdf
rm graph.dot

open Asset/graph_without_external.pdf
