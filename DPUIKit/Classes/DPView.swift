import Foundation
import UIKit

open class DPView: UIView, DPViewProtocol {
    
    // MARK: - Model
    open var _model: Any? {
        didSet {
            self.updateComponets()
        }
    }
    
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
    
    // MARK: - DPViewProtocol
    open func setupComponets() {}
    
    open func updateComponets() {}
    
    open func setHidden(_ hidden: Bool, animated: Bool) {
        guard self.isHidden != hidden else { return }
        
        self.isHidden = hidden
    }
    
    @objc
    open func tapButtonAction(_ button: UIButton) {}
    
    @objc
    open func tapGestureAction(_ gesture: UITapGestureRecognizer) {}

}
