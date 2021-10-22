import Foundation
import UIKit

/// Struct for defining the image.
///
public struct DPImage {
    
    /// Image remote url.
    ///
    public let remoteUrl: URL?
    
    /// Image placeholder.
    ///
    public let placeholder: UIImage?
    
    /// Initialize  default.
    /// - Parameter remoteUrl - Image remote url.
    /// - Parameter placeholder - Image placeholder.
    ///
    public init(remoteUrl: URL?, placeholder: UIImage?) {
        self.remoteUrl = remoteUrl
        self.placeholder = placeholder
    }
}
