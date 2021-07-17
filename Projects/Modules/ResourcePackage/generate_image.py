import os, glob, json

dirname = "Sources/ResourcePackage/Resources/Images.xcassets"
imageDict = {}
imageLevel1 = []

for filename in os.listdir("Sources/ResourcePackage/Resources/Images.xcassets"):
    if ".imageset" in filename:
        imageLevel1.append(filename.split(".")[0])
    else:
        subFolder = os.path.join(dirname, filename)
        if not os.path.isdir(subFolder):
            continue
        for _filename in os.listdir(subFolder):
            if ".imageset" in _filename:
                imageDict[filename] = imageDict.get(filename, []) + [_filename.split(".")[0]]

imageDict["level1"] = imageLevel1
print(json.dumps(imageDict, sort_keys=False, indent=4))


keylist = list(imageDict)
old_index = keylist.index("level1")
keylist.insert(0, keylist.pop(old_index))


f = open("Sources/ResourcePackage/Assets/ImageAsset.swift", 'w')

f.write("import Foundation\n")
f.write("import UIKit\n")
f.write("\n")
f.write("public extension R.Image {\n")
for key in keylist:
    if key == "level1": continue
    f.write("    struct " + key + " {}\n")
f.write("}\n")

for key in keylist:
    if key == "level1": 
        f.write("\npublic extension R.Image {\n")
    else:
        f.write("\npublic extension R.Image." + key + " {\n")
    list = imageDict[key]
    list.sort()
    for asset in list:
        property_name = asset
        if asset[0].isdigit():
            property_name = "_" + asset
        f.write("    static var " + property_name + ": UIImage { .R(#imageLiteral (resourceName: \"" + asset + "\")) }\n")
    f.write("}\n")
f.close()

f = open("Tests/ResourcePackageTests/ImageAssetTests.swift", 'w')
f.write("import XCTest\n")
f.write("@testable import ResourcePackage\n")
f.write("\n")
f.write("final class ImageAssetTests: XCTestCase {\n")
f.write("    func testImage() {\n")
for key in keylist:
    list = imageDict[key]
    for asset in list:
        property_name = asset
        if asset[0].isdigit():
            property_name = "_" + asset
        f.write("        XCTAssertNotNil(R.Image.")
        if key != "level1": 
            f.write(key + ".")
        f.write(property_name + ".cgImage)\n")
f.write("    }\n")
f.write("}\n")
f.close()
