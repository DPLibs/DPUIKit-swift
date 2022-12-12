# DPUIKit
An unobtrusive set of extensions and classes for UIKit.

[![version](https://img.shields.io/badge/version-3.0.0-white.svg)](https://semver.org)

## Requirements
* IOS 11 or above
* Xcode 12.5 or above

## Features

- [x] MVVM module.
- [x] Coordinators.
- [ ] UITableView adapter 👨‍💻.
- [ ] UICollectionView adapter 👨‍💻.
- [ ] DPTextField 👨‍💻.

## Overview
[&#8594; MVVM](/Docs/MVVM_3.0.0.md)\
[&#8594; Coordinators](/Docs/Coordinators_3.0.0.md)\
[&#8594; Xcode templates](/Docs/XCode_templates_3.0.0.md)

[&#8595; Views](#Views)\
[&#8595; ConstraintWrapper](#ConstraintWrapper)\
[&#8595; StyleWrapper](#StyleWrapper)\
[&#8595; Demo](#Demo)\
[&#8595; Install](#Install)\
[&#8595; License](#License)\
[&#8595; Author](#MVAuthorVM)

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

## ConstraintWrapper
View extensions setting auto layout constraints. Example:

```swift
class ViewController: UIViewController {

    open override func viewDidLoad() {
        super.viewDidLoad()
        
        let myView = UIView()
        myView.addToSuperview(self.view, withConstraints: [ .edgesToSuperview() ])
    }
    
}
```

The example above is similar to writing:
```swift
class ViewController: UIViewController {

    open override func viewDidLoad() {
        super.viewDidLoad()
        
        let myView = UIView()
        myView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            myView.topAnchor.constraint(equalTo: self.view.topAnchor),
            myView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            myView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            myView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
}
```

## StyleWrapper
View extensions setting styles. Example:

```swift
class ViewController: UIViewController {

    open override func viewDidLoad() {
        super.viewDidLoad()
        
        let myView = UIView()
        myView.applyStyles(.backgroundColor(.white), .cornerRadius(16))
    }
    
}
```

The example above is similar to writing:
```swift
class ViewController: UIViewController {

    open override func viewDidLoad() {
        super.viewDidLoad()
        
        let myView = UIView()
        myView.backgroundColor = .white
        myView.layer.cornerRadius = 16
    }
    
}
```

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
