//
//  TableViewCellModelProtocol.swift
//  Demo
//
//  Created by Дмитрий Поляков on 11.09.2023.
//

import Foundation
import UIKit

//public protocol TableViewCellModelProtocol {
//    var cellClass: TableViewCellProtocol.Type { get }
//    var cellHeight: CGFloat { get }
//    var cellEstimatedHeight: CGFloat { get }
//}
//
//public extension TableViewCellModelProtocol {
//    var cellHeight: CGFloat { TableConstants.cellHeight }
//    var cellEstimatedHeight: CGFloat { TableConstants.cellEstimatedHeight }
//}

//public struct TableID: Equatable, ExpressibleByStringLiteral {
//
//    // MARK: - Init
//    public init(_ value: String) {
//        self.value = value
//    }
//
//    public init<T: CustomStringConvertible>(_ value: T) {
//        self.value = value.description
//    }
//
//    public init(stringLiteral value: String) {
//        self.value = value
//    }
//
//    // MARK: - Props
//    public let value: String
//
//    // MARK: - Methods
//    public static func == (lhs: Self, rhs: Self) -> Bool {
//        guard !lhs.value.isEmpty, !rhs.value.isEmpty else { return false }
//        return lhs.value == rhs.value
//    }
//}

//public protocol TableViewCellModel {
//    var id: TableID { get }
//}

//public protocol TableRepresentable {
//    var _representableIdentifier: String { get }
//}
//
//public extension TableRepresentable {
//
//    var _representableIdentifier: String {
////        String(describing: Self.self)
//        String(reflecting: Self.self)
//    }
//
//}
//
//public protocol TableViewCellAdapterProtocol {
//    var _model: TableRepresentable? { get }
//
//    var cellClass: TableViewCellProtocol.Type { get }
//    var cellHeight: CGFloat { get }
//    var cellEstimatedHeight: CGFloat { get }
//
//    var onCellForRow: TableViewCellContextClosure? { get }
//    var onWillDisplayRow: TableViewCellContextClosure? { get }
//    var didSelectRow: TableViewCellContextClosure? { get }
//    var didDeselectRow: TableViewCellContextClosure? { get }
//}
//
//public struct TableViewCellAdapter<Cell: TableViewCellProtocol, Model: TableRepresentable>: TableViewCellAdapterProtocol {
//
//    // MARK: - Init
//    public init(
//        model: Model? = nil,
//        cellHeight: CGFloat = TableConstants.cellHeight,
//        cellEstimatedHeight: CGFloat = TableConstants.cellEstimatedHeight,
//        onCellForRow: TableViewCellContextClosure? = nil,
//        onWillDisplayRow: TableViewCellContextClosure? = nil,
//        didSelectRow: TableViewCellContextClosure? = nil,
//        didDeselectRow: TableViewCellContextClosure? = nil
//    ) {
//        self.model = model
//        self.cellHeight = cellHeight
//        self.cellEstimatedHeight = cellEstimatedHeight
//        self.onCellForRow = onCellForRow
//        self.onWillDisplayRow = onWillDisplayRow
//        self.didSelectRow = didSelectRow
//        self.didDeselectRow = didDeselectRow
//    }
//
//    // MARK: - Props
//    public var model: Model? {
//        get { self._model as? Model }
//        set { self._model = newValue }
//    }
//
//    public var _model: TableRepresentable?
//
//    public var cellClass: TableViewCellProtocol.Type { Cell.self }
//    public var cellHeight: CGFloat = TableConstants.cellHeight
//    public var cellEstimatedHeight: CGFloat = TableConstants.cellEstimatedHeight
//
//    public var onCellForRow: TableViewCellContextClosure?
//    public var onWillDisplayRow: TableViewCellContextClosure?
//    public var didSelectRow: TableViewCellContextClosure?
//    public var didDeselectRow: TableViewCellContextClosure?
//}

//public protocol TableViewRowProtocol {
//    var id: TableUUID { get }
//    var cellClass: TableViewCellProtocol.Type { get }
//    var cellHeight: CGFloat { get }
//    var cellEstimatedHeight: CGFloat { get }
//
//    var onCellForRow: TableViewCellContextClosure? { get }
//    var onWillDisplayRow: TableViewCellContextClosure? { get }
//    var didSelectRow: TableViewCellContextClosure? { get }
//    var didDeselectRow: TableViewCellContextClosure? { get }
//}
//
//public extension TableViewRowProtocol {
//    var id: TableUUID { "" }
//    var cellHeight: CGFloat { TableConstants.cellHeight }
//    var cellEstimatedHeight: CGFloat { TableConstants.cellEstimatedHeight }
//}
//
//public protocol TableViewRowAdapterProtocol: TableViewRowProtocol {
//    associatedtype Cell: TableViewCellProtocol
//    associatedtype Model
//
//    var model: Model { get }
//}
//
//public extension TableViewRowAdapterProtocol {
//
//    var cellClass: TableViewCellProtocol.Type {
//        Cell.self
//    }
//
//}
//
//public struct TableViewRowAdapter<Cell: TableViewCellProtocol, Model>: TableViewRowAdapterProtocol {
//
//    // MARK: - Init
//    public init(
//        model: Model,
//        id: TableUUID = "",
//        cellHeight: CGFloat = TableConstants.cellHeight,
//        cellEstimatedHeight: CGFloat = TableConstants.cellEstimatedHeight,
//        onCellForRow: TableViewCellContextClosure? = nil,
//        onWillDisplayRow: TableViewCellContextClosure? = nil,
//        didSelectRow: TableViewCellContextClosure? = nil,
//        didDeselectRow: TableViewCellContextClosure? = nil
//    ) {
//        self.model = model
//        self.id = id
//        self.cellHeight = cellHeight
//        self.cellEstimatedHeight = cellEstimatedHeight
//        self.onCellForRow = onCellForRow
//        self.onWillDisplayRow = onWillDisplayRow
//        self.didSelectRow = didSelectRow
//        self.didDeselectRow = didDeselectRow
//    }
//
//    // MARK: - Types
//    public typealias Cell = Cell
//
//    // MARK: - Props
//    public let id: TableUUID
//    public let cellHeight: CGFloat
//    public let cellEstimatedHeight: CGFloat
//    public let model: Model
//    public var onCellForRow: TableViewCellContextClosure?
//    public var onWillDisplayRow: TableViewCellContextClosure?
//    public var didSelectRow: TableViewCellContextClosure?
//    public var didDeselectRow: TableViewCellContextClosure?
//}
//
//public protocol TableViewCellAdapterProtocol {
//    var id: TableUUID { get }
//    var cellClass: AnyClass { get }
//    var cellHeight: CGFloat { get }
//    var cellEstimatedHeight: CGFloat { get }
//    var output: TableViewCellOutputProtocol? { get }
//}
//
//// MARK: - Default
//public extension TableViewCellAdapterProtocol {
//    var id: TableUUID { "" }
//    var cellHeight: CGFloat { TableConstants.cellHeight }
//    var cellEstimatedHeight: CGFloat { TableConstants.cellEstimatedHeight }
//    var output: TableViewCellOutputProtocol? { nil }
//}
//
//public protocol TableViewCellAdapterProtocol1: TableViewCellModelProtocol, TableViewCellConfiguration, TableViewCellOutput1 {
//    associatedtype Cell: TableViewCellProtocol
//    associatedtype Model
//}
//
//public extension TableViewCellAdapterProtocol1 {
//    var cellClass: AnyClass { Cell.self }
//}
//
//public protocol TableViewCellModelProtocol {
//    var id: TableUUID { get }
//}
//
//public extension TableViewCellModelProtocol {
//    var id: TableUUID { "" }
//}
//
//public protocol TableViewCellConfiguration {
//    var cellClass: AnyClass { get }
//    var cellHeight: CGFloat { get }
//    var cellEstimatedHeight: CGFloat { get }
//}
//
//public extension TableViewCellConfiguration {
//    var cellHeight: CGFloat { TableConstants.cellHeight }
//    var cellEstimatedHeight: CGFloat { TableConstants.cellEstimatedHeight }
//}
//
//public protocol TableViewCellOutput1 {
//    var onCellForRow: TableViewCellContextClosure? { get }
//    var onWillDisplayRow: TableViewCellContextClosure? { get }
//    var didSelectRow: TableViewCellContextClosure? { get }
//    var didDeselectRow: TableViewCellContextClosure? { get }
//}
