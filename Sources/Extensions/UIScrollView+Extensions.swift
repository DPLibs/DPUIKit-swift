//
//  File.swift
//  
//
//  Created by Дмитрий Поляков on 10.02.2022.
//

import Foundation
import UIKit

public extension UIScrollView {
    
    func calculateBottomOffset() -> CGPoint {
        let y =
            self.contentSize.height -
            self.frame.size.height +
            self.contentInset.top +
            self.contentInset.bottom

        return .init(x: 0, y: y)
    }
    
}
