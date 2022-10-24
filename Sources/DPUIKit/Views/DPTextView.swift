//
//  DPTextView.swift
//  
//
//  Created by Дмитрий Поляков on 24.10.2022.
//

import Foundation
import UIKit

open class DPTextView: UITextView, DPViewProtocol {
    
    // MARK: - Init
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override public init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        self.setupComponents()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupComponents()
    }
    
    // MARK: - Props
    open override var intrinsicContentSize: CGSize {
        if let autoHeightSettings = self.autoHeightSettings {
            return CGSize(width: UIView.noIntrinsicMetric, height: autoHeightSettings.min)
        } else {
            return super.intrinsicContentSize
        }
    }
    
    override open var text: String! {
        didSet { self.setNeedsDisplay() }
    }
    
    open override var font: UIFont? {
        didSet { self.setNeedsDisplay() }
    }
    
    open var autoHeightSettings: DPTextView.AutoHeightSettings? {
        didSet {
            self.oldSize = .zero
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    open var placeholder: String? {
        didSet { self.setNeedsDisplay() }
    }
    
    open var placeholderColor = UIColor(white: 0.8, alpha: 1.0) {
        didSet { self.setNeedsDisplay() }
    }
    
    open var placeholderFont: UIFont? {
        didSet { self.setNeedsDisplay() }
    }
    
    open var placeholderAligment: NSTextAlignment? {
        didSet { self.setNeedsDisplay() }
    }
    
    open var attributedPlaceholder: NSAttributedString? {
        didSet { self.setNeedsDisplay() }
    }
    
    open var didChangeHeight: ((CGFloat) -> Void)?
    
    private var heightConstraint: NSLayoutConstraint?
    private var oldText: String = ""
    private var oldSize: CGSize = .zero
    
    // MARK: - Methods
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.drawPlaceholder(rect)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        self.updateHeight()
    }
    
    open func setupComponents() {
        self.contentMode = .redraw
        
        self.constraints.forEach { constraint in
            guard constraint.firstAttribute == .height && constraint.relation == .equal else { return }
            self.heightConstraint = constraint
        }
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.textDidChange(_:)),
            name: UITextView.textDidChangeNotification,
            object: self
        )
    }
    
    open func updateComponents() {}
    
    open func setHidden(_ hidden: Bool, animated: Bool) {
        self.isHidden = hidden
    }
    
    open func drawPlaceholder(_ rect: CGRect) {
        guard self.text.isEmpty else { return }
        
        let x = self.textContainerInset.left + self.textContainer.lineFragmentPadding
        let y = self.textContainerInset.top
        let width = rect.size.width - x - self.textContainerInset.right - self.textContainer.lineFragmentPadding
        let height = rect.size.height - y - self.textContainerInset.bottom
        let placeholderRect = CGRect(x: x, y: y, width: width, height: height)
        
        if let attributedPlaceholder = self.attributedPlaceholder {
            attributedPlaceholder.draw(in: placeholderRect)
        } else if let placeholder = self.placeholder {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = self.placeholderAligment ?? self.textAlignment
            
            var attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: self.placeholderColor,
                .paragraphStyle: paragraphStyle
            ]
            
            if let font = self.placeholderFont ?? self.font {
                attributes[.font] = font
            }
            
            placeholder.draw(in: placeholderRect, withAttributes: attributes)
        }
    }
    
    open func updateHeight() {
        guard
            let autoHeightSettings = self.autoHeightSettings,
            (self.text != self.oldText || self.bounds.size != self.oldSize)
        else { return }
        
        self.oldText = self.text
        self.oldSize = self.bounds.size
        
        let size = self.sizeThatFits(CGSize(width: self.bounds.size.width, height: CGFloat.greatestFiniteMagnitude))
        
        var height = size.height
        height = autoHeightSettings.min > 0 ? max(height, autoHeightSettings.min) : height
        height = autoHeightSettings.max > 0 ? min(height, autoHeightSettings.max) : height
        
        if self.heightConstraint == nil {
            let heightConstraint = NSLayoutConstraint(
                item: self,
                attribute: .height,
                relatedBy: .equal,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: 1.0,
                constant: height
            )
            
            self.heightConstraint = heightConstraint
            self.addConstraint(heightConstraint)
        }
        
        if height != self.heightConstraint?.constant {
            self.heightConstraint?.constant = height
            self.didChangeHeight?(height)
        }
    }
    
    @objc
    open func textDidChange(_ notification: Notification) {
        guard let sender = notification.object as? DPTextView, sender == self else { return }
        self.setNeedsDisplay()
    }
    
}

// MARK: - AutoHeightSettings
public extension DPTextView {
    
    struct AutoHeightSettings {
        
        // MARK: - Init
        public init(min: CGFloat, max: CGFloat) {
            self.min = min
            self.max = max
        }
        
        // MARK: - Props
        public var min: CGFloat
        public var max: CGFloat
        
    }
    
}
