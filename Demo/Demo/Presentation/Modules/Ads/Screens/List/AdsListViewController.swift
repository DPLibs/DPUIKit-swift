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
        
        result.adapter = DPCollectionAdapter(
            itemAdapters: [
                AdsListCollectionItemCell.Adapter(
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
        self.model?.reload()
    }
    
    override func updateComponents() {
        super.updateComponents()
        
        let sections = (self.model?.sections ?? []).map { section in
            DPRepresentableSection(
                items: section.ads,
                header: AdsListCollectionHeaderView.Model(title: section.name),
                footer: AdsListCollectionFooterView.Model(total: section.total)
            )
        }
        
        self.collectionView.adapter?.reloadData(sections)
    }
    
    override func modelReloaded(_ model: DPViewModel?) {
        self.updateComponents()
    }
    
}

// MARK: - Private
private extension AdsListViewController {
    
    func showAds(_ ads: Ads) {
        let vc = UIAlertController(title: ads.title, message: ads.body, preferredStyle: .alert)
        vc.addAction(.init(title: "OK", style: .cancel))
        self.present(vc, animated: true)
    }
    
}

typealias Representable = Hashable & Sendable

struct Test: Hashable, Identifiable {
    var id: UUID = .init()
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
}

struct TestParent {
    
    struct Test: Hashable, Identifiable {
        var id: UUID = .init()
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(self.id)
        }
        
    }
    
}

protocol SectionType {
    var items: [any Representable] { get set }
    var header: (any Representable)? { get set }
    var footer: (any Representable)? { get set }
}

struct Section: SectionType {
    var items: [any Representable]
    var header: (any Representable)?
    var footer: (any Representable)?
    
    func ttt() {
        guard let test = self.items.first else { return }
        let type = type(of: test)
        print("!!!", type)
    }
}

class Adapter<Model: Representable> {
    let representID = ObjectIdentifier(Model.self)
    
    
}
