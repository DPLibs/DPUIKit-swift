# MVVM (3.0.0)
A screen or part of a screen is described as follows:

### DPViewController
Deals with displaying views and navigating to other screens. 
* Stores an instance `DPViewModel`. And implements a protocol `DPViewModelOutput` for processing signals from `DPViewModel`.
* Stores an instance `DPViewErrorHandler` for handling and displaying errors.

```swift
open class DPViewController: UIViewController, DPViewProtocol, DPViewModelOutput {
    open var _model: DPViewModel?
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
    func modelBeginReloading(_ model: DPViewModel?)
    func modelBeginLoading(_ model: DPViewModel?)
    func modelFinishLoading(_ model: DPViewModel?, withError error: Error?)
    func modelUpdated(_ model: DPViewModel?)
    func modelReloaded(_ model: DPViewModel?)
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

The main concept is to implement an approach of simple scalability, flexibility and component unobtrusiveness. Therefore, MVVM does not always have to be built entirely on a legacy implementation. Those. initially there can only be a `ViewController`. For example: 

```swift
class TestViewController: DPViewController {}
```

If the controller needs to receive some data from the network or LDB, then add a `TestViewModel` to it: 

```swift
class TestViewModel: DPViewModel {
   var testData: String?

   func loadTestData() {
      ...
   }
}

class TestViewController: DPViewController {
   override init() {
      super.init()
      self.model = TestViewModel()
   }
   ...

   private var model: TestViewModel? {
     get { self._model as? TestViewModel }
     set { self._model = newValue }
   }
}
```

If the controller has unique error display, then also add `TestViewErrorHanlder` respectively:

```swift
class TestViewModel: DPViewModel {
   var testData: String?

   func loadTestData() {
      ...
   }
}

class TestViewErrorHandler: DPViewErrorHandler {
   func handleErrorUnique(_ error: Error) {
      ...
   }
}

class TestViewController: DPViewController {
   override init() {
      super.init()
      
      self.model = TestViewModel()
      self.errorHandlder = TestViewErrorHandler()
   }
   ...

   private var model: TestViewModel? {
     get { self._model as? TestViewModel }
     set { self._model = newValue }
   }

   private var errorHandlder: TestViewErrorHandler? { ... }
}
```

The `private` modifier for `model` and `errorHanlder` is not accidental. This makes inheritance easier.
