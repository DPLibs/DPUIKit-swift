# DPUIKit

An unobtrusive set of extensions and classes for UIKit.

[![version](https://img.shields.io/badge/version-5.0.0-white.svg)](https://semver.org)

## Requirements

* IOS 11 or above
* Xcode 12.5 or above

## Features

- [x] MVVM
- [x] Coordinators
- [x] UITableView adapter
- [x] UICollectionView adapter
- [x] Docc
- [x] UITableView adapter Docc tutorial
- [ ] DPLabel 👨‍💻
- [ ] DPTextField 👨‍💻
- [ ] SelfSizing views 👨‍💻
- [ ] Static layout 👨‍💻
- [ ] MVVM Docc tutorial 👨‍💻
- [ ] Coordinators Docc tutorial 👨‍💻
- [ ] UICollectionView adapter Docc tutorial 👨‍💻

## Documentaion

[See documentaion](https://dplibs.github.io/DPUIKit-swift/documentation/dpuikit/)

## Demo
A [small project](/Demo) demonstrating the interaction of MVVM modules in an application.

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

1. Go to `File` -> `Swift Packages` -> `Add Package Dependency...`
2. Then search for <https://github.com/DPLibs/DPUIKit.git>
3. And choose the version you want

## License
Distributed under the MIT License.

## Author
Email: <dmitriyap11@gmail.com>
