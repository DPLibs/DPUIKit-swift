import Foundation
import UIKit

open class DPTableViewCell: UITableViewCell, DPViewProtocol {
    
    // MARK: - Props
    open var _model: Any? {
        didSet {
            self.updateComponets()
        }
    }
    
    // MARK: - Init
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.setupComponets()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.setupComponets()
    }

    // MARK: - Methods
    open override func awakeFromNib() {
        super.awakeFromNib()

        self.setupComponets()
    }
    
    open override func setSelected(_ selected: Bool, animated: Bool) {
        return
    }

    // MARK: - DPViewProtocol
    open func setupComponets() {}
    
    open func updateComponets() {}
    
    open func setHidden(_ hidden: Bool, animated: Bool) {}
    
    @objc
    open func tapButtonAction(_ button: UIButton) {}
    
    @objc
    open func tapGestureAction(_ gesture: UITapGestureRecognizer) {}
    
}

