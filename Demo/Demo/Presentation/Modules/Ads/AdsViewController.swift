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
        layout.scrollDirection = .vertical
        layout.sectionInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        
        let result = DPCollectionView(frame: .zero, collectionViewLayout: layout)
        
        result.adapter = DPCollectionAdapter(
            itemAdapters: [
                AdsCollectionItemCell.Adapter(
                    didSelect: { [weak self] ctx in
                        self?.showAds(ctx.model)
                    },
                    onSizeForItem: { [weak self] ctx in
                        guard let self else { return nil }
                        let side = (self.view.frame.width - 48) / 2
                        return CGSize(width: side, height: side)
                    }
                )
            ],
            supplementaryAdapters: [
                AdsCollectionHeaderView.Adapter(
                    viewSize: .init(width: 200, height: 40)
                ),
                AdsCollectionFooterView.Adapter(
                    viewSize: .init(width: 200, height: 40)
                )
            ]
        )
        
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
        
        let sections = (self.model?.sections ?? []).map { section in
            DPCollectionSection(
                items: section.ads.map({ AdsCollectionItemCell.Model(ads: $0) }),
                header: AdsCollectionHeaderView.Model(title: section.name),
                footer: AdsCollectionFooterView.Model(total: section.total)
            )
        }
        
        self.collectionView.adapter?.reloadData(sections)
    }
    
    override func modelReloaded(_ model: DPViewModel?) {
        self.updateComponents()
    }
    
}

// MARK: - Private
private extension AdsViewController {
    
    func showAds(_ model: AdsCollectionItemCell.Model) {
        let ads = model.ads
        let vc = UIAlertController(title: ads.title, message: ads.body, preferredStyle: .alert)
        vc.addAction(.init(title: "OK", style: .cancel))
        vc.addAction(.init(title: "Delete", style: .destructive, handler: { [weak self] _ in
            self?.model?.deleteAds(ads, comletion: { [weak self] indexPath in
                self?.collectionView.adapter?.performBatchUpdates([
                    .deleteItems(at: [indexPath])
                ])
            })
        }))
        self.present(vc, animated: true)
    }
    
}
