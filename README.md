# DPUIKit
An unobtrusive set of extensions and classes for UIKit.

[![version](https://img.shields.io/badge/version-2.0.0-white.svg)](https://semver.org)

## Requirements
* IOS 11 or above
* Xcode 12.5 or above

## Overview
[MVVM](#MVVM)\
[Views](#Views)\
[ConstraintWrapper](#ConstraintWrapper)\
[StyleWrapper](#StyleWrapper)\
[Extensions](#Extensions)\
[Demo](#Demo)\
[Install](#Install)\
[License](#License)\
[Author](#MVAuthorVM)

## MVVM
A screen or part of a screen is described as follows:

#### DPViewController
`DPViewController` deals with displaying views and navigating to other screens. 
* Stores an instance `DPViewModel`. And implements a protocol `DPViewModelOutput` for processing signals from `DPViewModel`.
* Stores an instance `DPViewRouter` to implement navigation.
* Stores an instance `DPViewErrorHandler` for handling and displaying errors.

```swift
open class DPViewController: UIViewController, DPViewProtocol, DPViewModelOutput {
    open var _model: DPViewModel?
    open var _router: DPViewRouter?
    open var _errorHandler: DPViewErrorHandler?
}
```


```swift
class DPViewModel {
    open weak var _ouput: DPViewModelOutput? 
}

```

```swift
public protocol DPViewModelOutput: AnyObject {
    func modelDidError(_ model: DPViewModel?, error: Error)
    func modelBeginLoading(_ model: DPViewModel?)
    func modelFinishLoading(_ model: DPViewModel?, withError error: Error?)
    func modelUpdated(_ model: DPViewModel?)
    func modelReloaded(_ model: DPViewModel?)
}
```

```swift
open class DPViewRouter {
    open weak var viewController: UIViewController?

    open func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil)
    open func push(viewController: UIViewController, animated: Bool)
    open func dismiss(animated: Bool, completion: (() -> Void)? = nil)
    ...
}

```

```swift
open class DPViewErrorHandler {
    open weak var viewController: UIViewController?
    
    open func handleError(_ error: Error?, completion: (() -> Void)? = nil)
}

```

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

1. Go to File -> Swift Packages -> Add Package Dependency...
2. Then search for <https://github.com/DPLibs/DPUIKit.git>
3. And choose the version you want

## License
Distributed under the MIT License.

## Author
Email: <dmitriyap11@gmail.com>
