#!/bin/sh

cp -R script/Dummy XCConfig/$1
mv XCConfig/$1/Dummy-DEV.xcconfig XCConfig/$1/$1-DEV.xcconfig
mv XCConfig/$1/Dummy-TEST.xcconfig XCConfig/$1/$1-TEST.xcconfig
mv XCConfig/$1/Dummy-STAGE.xcconfig XCConfig/$1/$1-STAGE.xcconfig
mv XCConfig/$1/Dummy-PROD.xcconfig XCConfig/$1/$1-PROD.xcconfig

mkdir -p Projects/Modules/$1/Sources
mkdir -p Projects/Modules/$1/Resources
mkdir -p Projects/Modules/$1/Tests

cat  << EOF
EOF

