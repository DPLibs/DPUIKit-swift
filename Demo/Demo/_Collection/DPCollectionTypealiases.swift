//
//  DPCollectionTypealiases.swift
//  Demo
//
//  Created by Дмитрий Поляков on 20.09.2023.
//

import Foundation

public typealias DPCollectionItemContext = (cell: DPCollectionItemCellProtocol, model: DPCollectionItemModelProtocol, indexPath: IndexPath)
public typealias DPCollectionItemContextClosure = (DPCollectionItemContext) -> Void
