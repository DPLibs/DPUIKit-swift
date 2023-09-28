# AutoLayout

View extensions setting auto layout constraints

@Metadata {
    @Available(iOS, introduced: "11.0")
}

## Overview

Example:

```swift
class ViewController: UIViewController {

   open override func viewDidLoad() {
       super.viewDidLoad()
       
       let myView = UIView()
       myView.addToSuperview(self.view, withConstraints: [ .edges() ])
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

## Topics

### Constraints

- ``DPConstraint``
- ``DPCenterConstraint``
- ``DPEdgesConstraint``
- ``DPLayoutConstraint``
- ``DPSizeConstraint``

### Layout

- ``DPLayoutGuide``
- ``DPLayoutGuideAnchorType``
- ``DPLayoutGuideType``
- ``DPLayoutConstraint``
- ``DPLayoutRelation``

### Wrapper

- ``DPConstraintWrapper``
