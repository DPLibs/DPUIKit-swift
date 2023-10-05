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
                items: section.ads.map({ AdsListCollectionItemCell.Model(ads: $0) }),
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
    
    func showAds(_ model: AdsListCollectionItemCell.Model) {
        let vc = UIAlertController(title: model.ads.title, message: model.ads.body, preferredStyle: .alert)
        vc.addAction(.init(title: "OK", style: .cancel))
        self.present(vc, animated: true)
    }
    
}

protocol Representable: Hashable, Sendable {
    var _representID: ObjectIdentifier { get }
}

extension Representable {
    
    var _representID: ObjectIdentifier {
        ObjectIdentifier(Self.self)
    }
    
}

struct Test: Representable, Identifiable {
    var id: UUID = .init()
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
}

struct TestParent {
    struct Test1: Representable, Identifiable {
        var id: UUID = .init()
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(self.id)
        }
        
    }
}

//class Adapter {
//    typealias Row = Hashable & Sendable
//
//    var rows: [any Row] = []
//
//    var onModel: ((any Row) -> Void)?
//
//    func test() {
//        let adapter = Adapter()
//        adapter.rows = [Test(), TestParent.Test1()]
//        let id1 = ObjectIdentifier(Test.self)
//        let id2 = ObjectIdentifier(Test.self)
//        let id3 = ObjectIdentifier(String.self)
//        let id4 = ObjectIdentifier(String.self)
//        print("!!!", id1)
//        print("!!!", id2)
//        print("!!!", id3)
//        print("!!!", id4)
//        print("!!!", ObjectIdentifier(TestParent.Test1.self))
//        print("!!!", ObjectIdentifier(TestParent.Test1.self))
//        print("!!!", id4.hashValue, id4.debugDescription)
//    }
//
//    func remove<T: Hashable>(_ row: T) {
//        self.rows.removeAll(where: {
//            guard let r = $0 as? T else { return false }
//            return r == row
//        })
//    }
//
//    func method(row: any Row) {
//        rows += [row]
//    }
//}

protocol SectionType {
    var items: [any Hashable & Sendable] { get set }
    var header: (any Hashable & Sendable)? { get set }
    var footer: (any Hashable & Sendable)? { get set }
}

struct Section: SectionType {
    var items: [any Hashable & Sendable]
    var header: (any Hashable & Sendable)?
    var footer: (any Hashable & Sendable)?
}

class Adapter<Model: Hashable & Sendable> {
    let representID = ObjectIdentifier(Model.self)
}


