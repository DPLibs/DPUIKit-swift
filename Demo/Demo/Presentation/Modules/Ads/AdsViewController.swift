//
//  AdsViewController.swift
//  Demo
//
//  Created by Дмитрий Поляков on 20.09.2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit
import DPUIKit

final class AdsViewController: DPViewController {
    
    // MARK: - Init
    override init() {
        super.init()
        
        self.model = .init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Props
    private var model: AdsViewModel? {
        get { self._model as? AdsViewModel }
        set { self._model = newValue }
    }
    
    private lazy var collectionView: DPCollectionView = {
        let layout = UICollectionViewFlowLayout()
        let result = DPCollectionView(frame: .zero, collectionViewLayout: layout)
        result.adapter?.onDisplayLastItem = { [weak self] in
            self?.model?.loadMore()
        }
        return result
    }()
    
    // MARK: - Methods
    override func loadView() {
        self.view = self.collectionView
    }
    
    override func setupComponents() {
        super.setupComponents()
        
        self.navigationItem.title = "Ads"
        self.model?.reload()
    }
    
    override func updateComponents() {
        super.updateComponents()
        
        let items: [DPCollectionItemModelProtocol] = (self.model?.ads ?? []).map({
            AdsCollectionItemCell.Model(ads: $0)
        })
        
        self.collectionView.reloadData(items)
    }
    
    override func modelReloaded(_ model: DPViewModel?) {
        self.updateComponents()
    }
    
}
