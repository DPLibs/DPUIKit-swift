# MVVM

Module for designing a screen or part of a screen

@Metadata {
    @Available(iOS, introduced: "11.0")
}

## Overview

Consists of the following components: ``DPViewController``, ``DPViewModel``, ``DPViewModelOutput`` and ``DPViewErrorHandler``.


The main concept is to implement an approach of simple scalability, flexibility and component unobtrusiveness. Therefore, `MVVM` does not always have to be built entirely on a legacy implementation. Those. initially there can only be a `TestViewController`. For example: 

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

## Topics

- ``DPViewController``
- ``DPViewModel``
- ``DPViewModelOutput``
- ``DPViewErrorHandler``
