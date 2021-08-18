#!/bin/sh

cp -R script/XCConfig/Template XCConfig/$1
mv XCConfig/$1/Template-DEV.xcconfig XCConfig/$1/$1-DEV.xcconfig
mv XCConfig/$1/Template-TEST.xcconfig XCConfig/$1/$1-TEST.xcconfig
mv XCConfig/$1/Template-STAGE.xcconfig XCConfig/$1/$1-STAGE.xcconfig
mv XCConfig/$1/Template-PROD.xcconfig XCConfig/$1/$1-PROD.xcconfig

mkdir -p Projects/DataRepository/$1/Sources
touch Projects/DataRepository/$1/Sources/.gitkeep
touch Projects/DataRepository/$1/Sources/$1.swift

mkdir -p Projects/DataRepository/$1/Resources
touch Projects/DataRepository/$1/Resources/.gitkeep

mkdir -p Projects/DataRepository/$1/Tests
touch Projects/DataRepository/$1/Tests/Tests.swift

touch Projects/DataRepository/$1/Project.swift

cat  << EOF > Projects/DataRepository/$1/Project.swift
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .staticFramework(name: "$1",
               		 dependencies: [
               		 ])
EOF

