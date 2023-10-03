//
//  DPCollectionView.swift
//  Demo
//
//  Created by Дмитрий Поляков on 20.09.2023.
//

import Foundation
import UIKit
import DPUIKit

open class DPCollectionView: UICollectionView, DPViewProtocol {
    
    // MARK: - Init
    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.setupComponents()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupComponents()
    }
    
    // MARK: - Props
    open var adapter: DPCollectionAdapter? {
        didSet { self.adapter?.collectionView = self }
    }
    
    // MARK: - Methods
    open func setupComponents() {
        self.adapter = DPCollectionAdapter()
    }
    
    open func updateComponents() {}
    
    open func reloadData(_ sections: [DPCollectionSectionProtocol]) {
        self.adapter?.sections = sections
        self.reloadData()
    }
    
    open func reloadData(_ items: [DPCollectionItemModelProtocol]) {
        self.adapter?.sections = [ DPCollectionSection(items: items) ]
        self.reloadData()
    }
    
}
