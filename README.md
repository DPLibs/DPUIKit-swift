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

### DPViewController
Deals with displaying views and navigating to other screens. 
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

### DPViewModel
Is the source of data and states for `DPViewController`.
* Stores an instance `DPViewModelOutput` for notice `DPViewController`.
* Сan store and monitor `Model`.

```swift
class DPViewModel {
    open weak var _ouput: DPViewModelOutput? 
}

```

### DPViewModelOutput
Interface for sending notifications from `DPViewModel`.

```swift
public protocol DPViewModelOutput: AnyObject {
    func modelDidError(_ model: DPViewModel?, error: Error)
    func modelBeginLoading(_ model: DPViewModel?)
    func modelFinishLoading(_ model: DPViewModel?, withError error: Error?)
    func modelUpdated(_ model: DPViewModel?)
    func modelReloaded(_ model: DPViewModel?)
}
```

### DPViewRouter
Provides navigation between `DPViewController`.
* Stores a link to `UIViewController` for its navigation.

```swift
open class DPViewRouter {
    open weak var viewController: UIViewController?

    open func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil)
    open func push(viewController: UIViewController, animated: Bool)
    open func dismiss(animated: Bool, completion: (() -> Void)? = nil)
    ...
}

```

### DPViewErrorHandler
Needed to process and display errors.
* Stores a link to `UIViewController` for show errors.

```swift
open class DPViewErrorHandler {
    open weak var viewController: UIViewController?
    
    open func handleError(_ error: Error?, completion: (() -> Void)? = nil)
}

```

An example of the interaction of all modules can be seen in more detail in the section [Demo](#Demo).

## Views

### DPViewProtocol
The library provides several custom views (`DPView`, `DPControl`, `DPSwitch` and others). They all implement a common protocol `DPViewProtocol`.

```swift
public protocol DPViewProtocol {
    func setupComponents()
    func updateComponents()
    func setHidden(_ hidden: Bool, animated: Bool)
}
```

### DPStackScrollView
Is a container inside which are arranged `UIScrollView` and `UIStackView`. And also some methods for managing the view.

```swift
open class DPStackScrollView: DPView {
    open lazy var scrollView: UIScrollView
    open lazy var stackView: UIStackView

    open var axis: NSLayoutConstraint.Axis
    open func addArrangedSubviews(_ views: [UIView]) -> DPStackScrollView
    open func removeAllArrangedSubviews() -> DPStackScrollView
    ...
}
```

### DPPageContainerViewController
View controller providing interactions with `UIPageViewController`.
* Stores an instance `DPPageContainerViewControllerDelegate` for event delegation.
* Stores an instance `UIPageViewController` to manage it.
* implements protocols `UIPageViewControllerDelegate` and `UIPageViewControllerDataSource`.

```swift
open class DPPageContainerViewController: DPViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    open weak var delegate: DPPageContainerViewControllerDelegate?
    open var pages: [UIViewController] = []
    open var pageViewController: UIPageViewController
    
    open func showPage(at index: Int, animated: Bool, completion: Completion? = nil)
    open func showPage(_ page: UIViewController?, animated: Bool, completion: Completion? = nil)
    open func setPages(_ pages: [UIViewController], animated: Bool, showPageAtIndex index: Int? = nil, completion: Completion? = nil)
    ...
}

public protocol DPPageContainerViewControllerDelegate: AnyObject {
    func didSelectPage(_ viewController: DPPageContainerViewController, at index: Int)
    func didSetPages(_ viewController: DPPageContainerViewController, pages: [UIViewController])
    func didPageLimitReached(_ viewController: DPPageContainerViewController, for direction: UIPageViewController.NavigationDirection, fromSwipe: Bool)
}
```
For more information about the use of various custom views, see the section [Demo](#Demo).

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
