import Foundation
import UIKit

open class DPView: UIView {
    
    // MARK: - Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupComponets()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setupComponets()
    }
    
    // MARK: - Methods
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupComponets()
    }
    
    open func setupComponets() {}
    
    open func updateComponets() {}
    
    @objc
    open func tapButtonAction(_ button: UIButton) { }

    @objc
    open func tapGestureAction(_ gesture: UITapGestureRecognizer) { }
    
}
