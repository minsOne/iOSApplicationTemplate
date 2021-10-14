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

startpath = "./Sources/MOResourcePackage/Resources/Storyboard"
tree = {}
for root, dirs, files in os.walk(startpath):
    branches = [startpath]
    if root != startpath:
        branches.extend(os.path.relpath(root, startpath).split('/'))
    set_leaf(tree, branches, dict([(d,{}) for d in dirs]+ \
                                  [(f,None) for f in files]))


tree = tree['./Sources/MOResourcePackage/Resources/Storyboard']
# print(json.dumps(tree, sort_keys=False, indent=4))


def clear_xib_dict(tree):
    for key in list(tree.keys()):
        if ".xib" in key: del tree[key]
        elif ".DS_Store" in key: del tree[key]
        elif ".storyboard" in key: continue
        else: clear_xib_dict(tree[key])

def clear_empty_directory_dict(tree):
    for key in list(tree.keys()):
        if ".storyboard" in key: continue
        elif tree[key] == {}: del tree[key]
        else: clear_empty_directory_dict(tree[key])

clear_xib_dict(tree)
clear_empty_directory_dict(tree)
clear_empty_directory_dict(tree)
clear_empty_directory_dict(tree)

f = open("Sources/MOResourcePackage/Assets/StoryboardAsset.swift", 'w')

f.write("import Foundation\n")
f.write("import UIKit\n")
f.write("\n")
f.write("extension R.Storyboard {\n")

def print_storyboard_asset(tree, level, group):
    keyList = list(tree)
    keyList.sort()
    for key in keyList:
        if ".storyboard" in key:
            storyboardName = key.split(".")[0]
            propertyName = storyboardName
            for groupName in group.split("."):
                if groupName == propertyName: break
                else:
                    propertyName = propertyName.replace(groupName, '')
            for i in range(level):
                f.write("    ")
            f.write("public static var " + propertyName + ": R.Storyboard { .init(name: \"" + storyboardName + "\") }\n")
        else:
            for i in range(level):
                f.write("    ")
            f.write("public struct " + key + " {\n")

            print_storyboard_asset(tree[key], level + 1, group + "." + key)
            for i in range(level):
                f.write("    ")
            f.write("}\n")

print_storyboard_asset(tree, 1, "")

f.write("}\n")
f.close()


f = open("Tests/MOResourcePackageTests/StoryboardAssetTests.swift", 'w')
f.write("import XCTest\n")
f.write("@testable import MOResourcePackage\n")
f.write("\n")
f.write("final class StoryboardAssetTests: XCTestCase {\n")
f.write("    func test_storyboard() {\n")

def print_assert_storyboard_NotNil(tree, group):
    keyList = list(tree)
    keyList.sort()
    for key in keyList:
        if ".storyboard" in key:
            storyboardName = key.split(".")[0]
            propertyName = storyboardName
            for groupName in group.split("."):
                if groupName == propertyName: break
                elif groupName == "R": continue
                elif groupName == "Storyboard": continue
                else:
                    propertyName = propertyName.replace(groupName, '')
            f.write("        XCTAssertNotNil(storyboardResourcePath(" + group + "." + propertyName + "))\n")
        else:
            print_assert_storyboard_NotNil(tree[key], group + "." + key)

print_assert_storyboard_NotNil(tree, "R.Storyboard")

f.write("    }\n")
f.write("}\n")
f.close()
