# Coordinators (3.0.0)
`Coordinators` are used to navigate between screens and implement flow. They implement the `DPCoordinatorProtocol` protocol:

```swift
public protocol DPCoordinatorProtocol: AnyObject {
    
    /// Called at `start`
    var didStart: ((DPCoordinatorProtocol?) -> Void)? { get set }
    
    /// Called at `finish`
    var didFinish: ((DPCoordinatorProtocol?) -> Void)? { get set }
    
    /// Method to start flow
    func start()
    
    /// Method to finish flow
    func finish()
}
```

There are two types of coordinators in the library: `WindowCoordinator` and `NavigationCoordinator`.

## WindowCoordinator
Manages flow inside `UIWindow`.

```swift
open class DPWindowCoordinator: DPCoordinatorProtocol {

    /// In the `init` you can pass `UIWindow` for control
    public init(window: UIWindow?)
    
    /// `UIWindow` for control
    open weak var window: UIWindow?
    
    /// Thrown property `UIWindow`. When setting the value of this property, the installed `UIViewController` is displayed
    open var rootViewController: UIViewController?
    
    /// Method for installing `viewController` in `rootViewController`
    open func show(_ viewController: UIViewController, animated: Bool = true)
    
}
```

## NavigationCoordinator
Manages within the `UINavigationController`.

```swift
open class DPNavigationCoordinator: DPCoordinatorProtocol {

    /// In the `init` you can pass `UINavigationController` for control
    public init(navigationController: UINavigationController?)
    
    /// `UINavigationController` for control
    open weak var navigationController: UINavigationController?
    
    /// Top controller in `navigationController` stack
    open var topViewController: UIViewController?
    
    open func show(_ viewController: UIViewController, animated: Bool = true)
    open func push(_ viewController: UIViewController, animated: Bool = true)
    open func pop(animated: Bool = true)
    open func popToRoot(animated: Bool = true)
    open func present(_ viewControllerToPresent: UIViewController, animated flag: Bool = true, completion: (() -> Void)? = nil)
    open func set(_ viewControllers: [UIViewController], animated: Bool)
    
}
```

## Coordinators and memory
It is proposed to store `coordinators` in managed `viewControllers`. For this, the `DPCoordinatableViewController` protocol is used. This approach solves the problem of `tapping on the back button`([Coordinators and the back button problem](https://medium.com/codex/coordinators-the-back-button-and-how-to-solve-it-d336877a6d29)). 
After deinitialization of the `viewController` in which the `coordinator` was stored (in the case of `NavigationCoordinator`, this is usually the `viewController` from which the flow `start`), the `coordinator` is also deinitialized.

```swift
public protocol DPCoordinatableViewController: UIViewController {
    
    /// Property to store a strong reference to the `coordinator`
    var coordinator: DPCoordinatorProtocol? { get set }
}
```
