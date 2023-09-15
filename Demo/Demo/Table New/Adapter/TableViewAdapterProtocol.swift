//
//  TableViewAdapterProtocol.swift
//  Demo
//
//  Created by Дмитрий Поляков on 11.09.2023.
//

import Foundation
import UIKit

public protocol TableViewAdapterProtocol: NSObject, UITableViewDataSource, UITableViewDelegate {
    var sections: [TableViewSectionProtocol] { get set }
}
