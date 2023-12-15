//
//  AdsListViewController.swift
//  Demo
//
//  Created by Дмитрий Поляков on 20.09.2023.
//  Copyright © 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import UIKit
import DPUIKit

final class AdsListViewController: DPViewController {
    
    // MARK: - Init
    override init() {
        super.init()
        
        self.model = .init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Props
    private var model: AdsListViewModel? {
        get { self._model as? AdsListViewModel }
        set { self._model = newValue }
    }
    
    private lazy var collectionView: DPCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        
        let result = DPCollectionView(frame: .zero, collectionViewLayout: layout)
        result.refreshControl = DPRefreshControl(didBeginRefreshing: { [weak self] in
            self?.model?.reload()
        })
        
        result.adapter = DPCollectionAdapter(
            itemAdapters: [
                AdsListCollectionItemCell.Adapter(
                    didSelect: { [weak self] ctx in
                        self?.showAds(ctx.model)
                    },
                    didEndDisplaying : {[weak self] ctx in
                        print("didEndDisplaying: \(ctx.indexPath)")
                    },
                    onSizeForItem: { [weak self] ctx in
                        guard let self else { return nil }
                        let side = (self.view.frame.width - 48) / 2
                        return CGSize(width: side, height: side)
                    }
                )
            ],
            supplementaryAdapters: [
                AdsListCollectionHeaderView.Adapter(
                    viewSize: .init(width: 200, height: 40)
                ),
                AdsListCollectionFooterView.Adapter(
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
        
        self.model?.onDeleteAds = { [weak self] ads, section in
            self?.collectionView.adapter?.performBatchUpdates([ .deleteItems(identified: [ads]) ], completion: { [weak self] _ in
                UIView.performWithoutAnimation { [weak self] in
                    self?.collectionView.adapter?.performBatchUpdates([ .setSections(identified: [section]) ])
                }
            })
        }
        
        self.model?.onDeleteSection = { [weak self] section in
            self?.collectionView.adapter?.performBatchUpdates([
                .deleteSections(identified: [section])
            ])
        }
        
        self.model?.reload()
    }
    
    override func updateComponents() {
        super.updateComponents()
        
        let sections = self.model?.sections ?? []
        self.collectionView.adapter?.reloadData(sections)
    }
    
    override func modelReloaded(_ model: DPViewModel?) {
        self.collectionView.refreshControl?.endRefreshing()
        self.updateComponents()
    }
    
}

// MARK: - Private
private extension AdsListViewController {
    
    func showAds(_ ads: Ads) {
        let vc = UIAlertController(title: ads.title, message: ads.body, preferredStyle: .alert)
        vc.addAction(.init(title: "OK", style: .cancel))
        vc.addAction(.init(title: "Delete", style: .destructive, handler: { [weak self] _ in
            self?.model?.deleteAds(ads)
        }))
        self.present(vc, animated: true)
    }
    
}
