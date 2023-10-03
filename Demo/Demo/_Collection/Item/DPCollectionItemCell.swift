//
//  DPCollectionItemCell.swift
//  Demo
//
//  Created by Дмитрий Поляков on 20.09.2023.
//

import Foundation
import UIKit

public protocol DPCollectionItemCellProtocol: UICollectionViewCell {
    var _model: DPCollectionItemModelProtocol? { get set }
}

open class DPCollectionItemCell: UICollectionViewCell, DPCollectionItemCellProtocol {
    
    // MARK: - Init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupComponents()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupComponents()
    }
    
    // MARK: - Props
    open var _model: DPCollectionItemModelProtocol? {
        didSet { self.updateComponents() }
    }
    
    // MARK: - Methods
    open func setupComponents() {
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
    }
    
    open func updateComponents() {}
    
}
