import Foundation
import UIKit
import Kingfisher

public extension UIImageView {
     
    // MARK: - Setup image methods
    
    /// Setup image from remote url by Kingfisher.
    /// - Parameter url: Image remote url.
    /// - Parameter placeholder: Image placehoder if image not loaded from url.
    /// - Parameter completion: Completion closure.
    ///
    func setupImageFromRemoteUrl(_ url: URL?, placeholder: UIImage?, completion: ((Bool) -> Void)? = nil) {
        self.kf.indicatorType = .activity
        
        guard let url = url else {
            self.kf.indicatorType = .none
            self.image = placeholder
            
            completion?(false)
            return
        }
        
        let options: [KingfisherOptionsInfoItem] = [
            .diskCacheExpiration(.seconds(600)),
            .transition(.none)
        ]

        self.kf.setImage(with: url, placeholder: nil, options: options, progressBlock: nil) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let value):
                self.image = value.image
                completion?(true)
            case .failure:
                self.image = placeholder
                completion?(false)
            }
        }
    }
    
    /// Setup image from `ImageModel` by Kingfisher.
    /// - Parameter image: ImageModel.
    /// - Parameter completion: Completion closure.
    ///
    func setupImageFromImageModel(_ image: DPImage?, completion: ((Bool) -> Void)? = nil) {
        self.setupImageFromRemoteUrl(image?.remoteUrl, placeholder: image?.placeholder, completion: completion)
    }
    
}
