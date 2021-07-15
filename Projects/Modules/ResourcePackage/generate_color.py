import os, json
from posixpath import dirname

dirname = "Sources/ResourcePackage/Resources/Color.xcassets"
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
print(json.dumps(colorDict, sort_keys=False, indent=4))

f = open("Sources/ResourcePackage/ColorAsset.swift", 'w')
f.write("import Foundation\n")
f.write("import UIKit\n\n")

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

f = open("Tests/ResourcePackageTests/ColorAssetTests.swift", 'w')
f.write("import XCTest\n")
f.write("@testable import ResourcePackage\n")
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
