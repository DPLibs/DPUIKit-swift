# StyleWrapper

View extensions setting styles

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

## Topics

- ``Stylable``
