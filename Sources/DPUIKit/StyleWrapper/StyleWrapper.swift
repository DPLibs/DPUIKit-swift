import UIKit

public typealias Style<Element> = (Element) -> Void

public enum StyleWrapper<Element> {
    case wrap(style: Style<Element>)
}
