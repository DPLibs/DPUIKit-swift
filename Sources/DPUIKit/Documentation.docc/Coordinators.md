# Coordinators

Used to navigate between screens and implement flow.

@Metadata {
    @Available(iOS, introduced: "11.0")
}

## Overview

They implement the ``DPCoordinatorProtocol`` protocol. There are two types of coordinators in the library: ``DPWindowCoordinator`` and ``DPNavigationCoordinator``.

It is proposed to store `coordinators` in managed `viewControllers`. For this, the ``DPCoordinatableViewController`` protocol is used. This approach solves the problem of `tapping on the back button`([Coordinators and the back button problem](https://medium.com/codex/coordinators-the-back-button-and-how-to-solve-it-d336877a6d29)). 
After deinitialization of the `viewController` in which the `coordinator` was stored (in the case of ``DPNavigationCoordinator``, this is usually the `viewController` from which the flow `start`), the `coordinator` is also deinitialized.

## Topics
- ``DPCoordinatorProtocol``
- ``DPWindowCoordinator``
- ``DPNavigationCoordinator``
- ``DPCoordinatableViewController``
