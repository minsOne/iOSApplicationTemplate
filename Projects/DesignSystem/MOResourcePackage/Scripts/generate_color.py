import os, json
from posixpath import dirname

dirname = "Sources/MOResourcePackage/Resources/Color.xcassets"
colorDict = {}
colorLevel1 = []

for filename in os.listdir(dirname):
    if ".colorset" in filename:
        colorLevel1.append(filename.split(".")[0])
    else:
        subFolder = os.path.join(dirname, filename)
        if not os.path.isdir(subFolder):
            continue
        for _filename in os.listdir(subFolder):
            if ".colorset" in _filename:
                colorDict[filename] = colorDict.get(filename, []) + [_filename.split(".")[0]]

colorDict["level1"] = colorLevel1

f = open("Sources/MOResourcePackage/Assets/ColorNameAsset.swift", 'w')
f.write("import Foundation\n")
f.write("import UIKit\n")

if len(colorDict.keys()) > 1:
    f.write("public extension R.Color {\n")
    for key in colorDict.keys():
        if key == "level1": continue
        f.write("    struct " + key + " {}\n")
    f.write("}\n")


for key in colorDict.keys():
    if key == "level1":
        f.write("\npublic extension R.Color {\n")
    else:
        f.write("\npublic extension R.Color." + key + " {\n")
    list = colorDict[key]
    list.sort()
    for asset in list:
        f.write("    static var " + asset + ": UIColor { return UIColor(named: \"" + asset + "\", in: .module, compatibleWith: nil)! }\n")
    f.write("}\n")
f.close()

f = open("Tests/MOResourcePackageTests/ColorNameAssetTests.swift", 'w')
f.write("import XCTest\n")
f.write("@testable import MOResourcePackage\n")
f.write("\n")
f.write("final class ColorAssetTests: XCTestCase {\n")
f.write("    func testColor() {\n")
for key in colorDict.keys():
    list = colorDict[key]
    for asset in list:
        f.write("        _ = R.Color.")
        if key != "level1":
            f.write(key + ".")
        f.write(asset + "\n")
f.write("    }\n")
f.write("}\n")
f.close()
