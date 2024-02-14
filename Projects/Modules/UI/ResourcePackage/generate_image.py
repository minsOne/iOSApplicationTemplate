import os, glob, json
from pprint import pprint

def set_leaf(tree, branches, leaf):
    """ Set a terminal element to *leaf* within nested dictionaries.              
    *branches* defines the path through dictionnaries.                            

    Example:                                                                      
    >>> t = {}                                                                    
    >>> set_leaf(t, ['b1','b2','b3'], 'new_leaf')                                 
    >>> print t                                                                   
    {'b1': {'b2': {'b3': 'new_leaf'}}}                                             
    """
    if len(branches) == 1:
        tree[branches[0]] = leaf
        return
    if not branches[0] in tree:
        tree[branches[0]] = {}
    set_leaf(tree[branches[0]], branches[1:], leaf)

startpath = "./Sources/ResourcePackage/Resources/Images.xcassets"
tree = {}
for root, dirs, files in os.walk(startpath):
    branches = [startpath]
    if root != startpath:
        branches.extend(os.path.relpath(root, startpath).split('/'))
    
    set_leaf(tree, branches, dict([(d,{}) for d in dirs]))

tree = tree['./Sources/ResourcePackage/Resources/Images.xcassets']


def clear_image_asset_dict(tree):
    for key in list(tree.keys()):
        if ".appiconset" in key: del tree[key]
    for key in list(tree.keys()):
        if ".imageset" in key: continue
        elif tree[key] == {}: del tree[key] 
        else: clear_image_asset_dict(tree[key])

clear_image_asset_dict(tree)
# print(json.dumps(tree, sort_keys=False, indent=4))


f = open("Sources/ResourcePackage/Assets/ImageAsset.swift", 'w')
f.write("import Foundation\n")
f.write("import UIKit\n")
f.write("\n")
f.write("extension R.Image {\n")

def print_image_group(tree, level):
    keyList = list(tree)
    keyList.sort()
    for key in keyList:
        if ".imageset" in key:
            imageName = key.split(".")[0]
            assetName = imageName
            if imageName[0].isdigit():
                assetName = "_" + imageName
            for i in range(level):
                f.write("    ")
            f.write("public static var " + assetName + ": UIImage { .R(#imageLiteral (resourceName: \"" + imageName + "\")) }\n")
        else:
            for i in range(level):
                f.write("    ")
            f.write("public struct " + key + " {\n")
            print_image_group(tree[key], level + 1)
            for i in range(level):
                f.write("    ")
            f.write("}\n")

print_image_group(tree, 1)

f.write("}\n")
f.close()


f = open("Tests/ResourcePackageTests/ImageAssetTests.swift", 'w')
f.write("import XCTest\n")
f.write("@testable import ResourcePackage\n")
f.write("\n")
f.write("final class ImageAssetTests: XCTestCase {\n")
f.write("    func test_image() {\n")

def print_assetNotNil_image(tree, group):
    keyList = list(tree)
    keyList.sort()
    for key in keyList:
        if ".imageset" in key:
            imageName = key.split(".")[0]
            assetName = imageName
            if imageName[0].isdigit():
                assetName = "_" + imageName
            f.write("        XCTAssertNotNil(" + group + "." + assetName + ".cgImage)\n")
        elif ".appiconset" in key:
            continue
        else:
            print_assetNotNil_image(tree[key], group + "." + key)

print_assetNotNil_image(tree, "R.Image")

f.write("    }\n")
f.write("}\n")
f.close()