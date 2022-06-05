import Foundation
import UIKit

public extension UILabel {
    
    // MARK: - Size methods
    
    /// Method determines whether the label reduces the text’s font size to fit the title string into the label’s bounding rectangle.
    /// - Parameter size: Estimated label frame size.
    /// - Parameter minimumFontSize: Minimum label font size.
    ///
    func adjustsFontSizeToFitWidth(estimatedFrameSize size: CGSize, minimumFontSize: CGFloat) {
        var font = self.font ?? UIFont.systemFont(ofSize: 16, weight: .regular)
        var index = font.pointSize
        let text = self.text ?? ""
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: size.width, height: 1000))
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = text
        
        while index >= minimumFontSize {
            font = font.withSize(index)
            label.font = font
            label.sizeToFit()
            if label.frame.height <= size.height {
                break
            }
            index -= 1
        }
        
        for word in text.split(separator: " ") {
            let labelWidth = UILabel()
            font = font.withSize(index)
            labelWidth.font = font
            labelWidth.text = String(word)
            labelWidth.sizeToFit()
            while index >= minimumFontSize {
                font = font.withSize(index)
                label.font = font
                label.sizeToFit()
                if label.frame.width <= size.width {
                    break
                }
                index -= 1
            }
        }
        
        self.font = font
        self.text = text
    }
    
    // MARK: - Number of lines methods
    
    /// Returns the count of all rows, regardless of the set parameter `numberOfLines`.
    ///
    func calculateAllNumberOfLines() -> Int {
        guard let myText = self.text as NSString?, let font = self.font else { return 0 }
        
        let rect = CGSize(width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let labelSize = myText.boundingRect(
            with: rect,
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: font],
            context: nil
        )
        
        return Int(ceil(CGFloat(labelSize.height) / self.font.lineHeight))
    }
    
    /// Returns `true` if the number of all lines is greater than the specified `value`.
    /// - Parameter value: Specified number of lines for compare.
    /// - Returns: Comparision result.
    ///
    func isTruncated(forNumberOfLines value: Int) -> Bool {
        self.calculateAllNumberOfLines() > value
    }
    
}
