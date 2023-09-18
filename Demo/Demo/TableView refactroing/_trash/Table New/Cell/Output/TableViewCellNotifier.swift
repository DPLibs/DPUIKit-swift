//
//  TableViewCellNotifier.swift
//  Demo
//
//  Created by Дмитрий Поляков on 14.09.2023.
//

//import Foundation
//import Combine
//
//@available(iOS 13.0, *)
//public struct TableViewCellNotifier: TableViewCellOutputProtocol {
//    
//    // MARK: - Init
//    public init() {
//        self.publisher = .init()
//    }
//    
//    // MARK: - Types
//    public enum Event {
//        case onCellForRow(TableViewCellContext)
//        case onWillDisplayRow(TableViewCellContext)
//        case didSelectRow(TableViewCellContext)
//        case didDeselectRow(TableViewCellContext)
//    }
//    
//    // MARK: - Props
//    private let publisher: PassthroughSubject<Event, Never>
//    public var output: AnyPublisher<Event, Never> { self.publisher.eraseToAnyPublisher() }
//    
//    // MARK: - Methods
//    public func _sendOnCellForRow(_ context: TableViewCellContext) {
//        self.publisher.send(.onCellForRow(context))
//    }
//    
//    public func _sendOnWillDisplayRow(_ context: TableViewCellContext) {
//        self.publisher.send(.onWillDisplayRow(context))
//    }
//    
//    public func _sendDidSelectRow(_ context: TableViewCellContext) {
//        self.publisher.send(.didSelectRow(context))
//    }
//    
//    public func _sendDidDeselectRow(_ context: TableViewCellContext) {
//        self.publisher.send(.didDeselectRow(context))
//    }
//}
