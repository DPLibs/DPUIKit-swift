import Foundation
import UIKit

open class DPTableViewHeaderFooterView: UITableViewHeaderFooterView {
    
    // MARK: - Model
    open var model: Any? {
        didSet {
            self.updateViews()
        }
    }
    
    // MARK: - Init
    override public init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        self.setupViews()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.setupViews()
    }

    // MARK: - Methods
    open override func awakeFromNib() {
        super.awakeFromNib()

        self.setupViews()
    }

    open func setupViews() {}

    open func updateViews() {}

    @objc
    open func tapButtonHandler(_ button: UIButton) {}

    @objc
    open func tapGestureHandler(_ gesture: UITapGestureRecognizer) {}
    
}
