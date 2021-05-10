#!/bin/sh

cp -R script/XCConfig/Template XCConfig/$1
mv XCConfig/$1/Template-DEV.xcconfig XCConfig/$1/$1-DEV.xcconfig
mv XCConfig/$1/Template-TEST.xcconfig XCConfig/$1/$1-TEST.xcconfig
mv XCConfig/$1/Template-STAGE.xcconfig XCConfig/$1/$1-STAGE.xcconfig
mv XCConfig/$1/Template-PROD.xcconfig XCConfig/$1/$1-PROD.xcconfig

mkdir -p Projects/Modules/$1/Sources
mkdir -p Projects/Modules/$1/Resources
mkdir -p Projects/Modules/$1/Tests

touch Projects/Modules/$1/Project.swift

cat  << EOF > Projects/Modules/$1/Project.swift
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project
    .framework(name: "$1",
               dependencies: [
               ])
EOF

