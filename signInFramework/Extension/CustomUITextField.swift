//
//  CustomUITextField.swift
//  signInFramework
//
//  Created by Aira Samson on 7/29/20.
//  Copyright © 2020 Aira Samson. All rights reserved.
//

import UIKit

@IBDesignable

public class CustomUITextField: UITextField {

    @IBInspectable public var actionable: Bool = true
    @IBInspectable public var removeShortcuts: Bool = true {
        didSet {
            if removeShortcuts {
                let item = inputAssistantItem
                item.leadingBarButtonGroups = []
                item.trailingBarButtonGroups = []
            }
        }
    }
    
    @IBInspectable public var placeHolderAlpha: CGFloat = 1.0 {
        didSet {
            updatePlaceHolder()
        }
    }
    
    @IBInspectable public var placeholderColor: UIColor = UIColor.white {
        didSet {
            updatePlaceHolder()
        }
    }
    
    public func updatePlaceHolder() {
        guard let font = self.font, let placeholder = self.placeholder else {
            print("Error unwrapping objects. ")
            return
        }
        
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: placeholderColor.withAlphaComponent(placeHolderAlpha)
            ])
    }
    
    public override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if actionable {return super.canPerformAction(action, withSender: sender)}
        return false
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        let input = inputAssistantItem
        input.leadingBarButtonGroups = []
        input.trailingBarButtonGroups = []
    }
    
}

