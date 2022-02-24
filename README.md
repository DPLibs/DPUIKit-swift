# DPUIKit
An unobtrusive set of extensions and classes for UIKit.

## Requirements
IOS 11 or above
Xcode 12.5 or above

## Overview
[MVVM](#MVVM)\
[Views](#Views)\
[ConstraintWrapper](#ConstraintWrapper)\
[StyleWrapper](#StyleWrapper)\
[Extensions](#Extensions)\
[Demo](#Demo)\
[Install](#Install)
[License](#License)
[Author](#MVAuthorVM)

## MVVM
## Views
## ConstraintWrapper
## StyleWrapper
## Extensions
## Demo

## Install
Swift Package Manager(SPM) is Apple's dependency manager tool. It is now supported in Xcode 11. So it can be used in all appleOS types of projects. It can be used alongside other tools like CocoaPods and Carthage as well.

### Install package into your packages
Add a reference and a targeting release version in the dependencies section in Package.swift file:

```swift
import PackageDescription

let package = Package(
    name: "<your_project_name>",
    products: [],
    dependencies: [
        .package(url: "https://github.com/DPLibs/DPUIKit.git", from: "<current_version>")
    ]
)
```

### Install package via Xcode

Go to File -> Swift Packages -> Add Package Dependency...
Then search for <https://github.com/DPLibs/DPUIKit.git>
And choose the version you want

## License
Distributed under the MIT License.

## Author
Email: <dmitriyap11@gmail.com>
