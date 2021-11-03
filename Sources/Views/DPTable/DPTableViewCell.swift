//
//  DPTableViewCell.swift
//  DPUIKit
//
//  Created by Дмитрий Поляков on 03.09.2021.
//

import Foundation
import UIKit

open class DPTableViewCell: UITableViewCell, DPViewProtocol {
    
    // MARK: - Props
    open var _model: Any? {
        didSet {
            self.updateComponents()
        }
    }
    
    // MARK: - Init
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.setupComponents()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.setupComponents()
    }

    // MARK: - Methods
    open override func awakeFromNib() {
        super.awakeFromNib()

        self.setupComponents()
    }
    
    open override func setSelected(_ selected: Bool, animated: Bool) {
        return
    }
    
    open override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        return
    }

    // MARK: - DPViewProtocol
    open func setupComponents() {
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
    }
    
    open func updateComponents() {}
    
    open func setHidden(_ hidden: Bool, animated: Bool) {}
    
    @objc
    open func tapButtonAction(_ button: UIButton) {}
    
    @objc
    open func tapGestureAction(_ gesture: UITapGestureRecognizer) {}
    
}
