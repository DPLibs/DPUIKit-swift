//
//  File.swift
//  
//
//  Created by Дмитрий Поляков on 20.02.2022.
//

import Foundation

public struct DPTableSection: DPTableSectionProtocol {
    
    // MARK: - Init
    public init(
        rows: [DPRepresentableModel] = [],
        header: DPRepresentableModel? = nil,
        footer: DPRepresentableModel? = nil
    ) {
        self.rows = rows
        self.header = header
        self.footer = footer
    }

    // MARK: - Props
    public var rows: [DPRepresentableModel]
    public var header: DPRepresentableModel?
    public var footer: DPRepresentableModel?
}
