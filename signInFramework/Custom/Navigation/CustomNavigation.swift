//
//  CustomNavigation.swift
//  signInFramework
//
//  Created by Aira Samson on 8/4/20.
//  Copyright © 2020 Aira Samson. All rights reserved.
//

import UIKit

class CustomNavigation: UIView{

    @IBOutlet weak var navView: UIView!
    @IBOutlet weak var navLabel: UILabel!
    @IBOutlet weak var navLeftButton: UIButton!
    @IBOutlet weak var navRightButton: UIButton!
    
    @IBInspectable public var backgroundViewColor: UIColor? {
         get {
             return navView.backgroundColor
         }
         set(color) {
             navView.backgroundColor = color
         }
     }
     
     var headerLabel: String = "" {
         didSet {
             navLabel.text = headerLabel
         }
     }
    
     public var leftButton: UIImage? {
         get {
             return navLeftButton.currentImage
         }
         set(value) {
             if let image = value {
                 navLeftButton.setImage(image, for: .normal)
                 navLeftButton.isHidden = false
             } else {
                 navLeftButton.setImage(nil, for: .normal)
                 navLeftButton.isHidden = true
             }
         }
     }
    
    public var rightButton: UIImage? {
        get {
            return navRightButton.currentImage
        }
        set(value) {
            if let image = value {
                navRightButton.setImage(image, for: .normal)
                navRightButton.isHidden = false
            } else {
                navRightButton.setImage(nil, for: .normal)
                navRightButton.isHidden = true
            }
        }
    }
    
    
     // MARK: - Actions
     
     public var tapNavLeftButtonAction: (() -> Void)?
     public var tapNavRightButtonAction: (() -> Void)?
     
     @IBAction func didTapNavLeftButton(_ sender: Any) {
         tapNavLeftButtonAction?()
     }
    
     @IBAction func didTapRightLeftButton(_ sender: Any) {
         tapNavRightButtonAction?()
     }
    
     // MARK: - Initializers
     
     override init(frame: CGRect) {
         super.init(frame: frame)
         setupView()
         setupDefaults()
     }
     
     public required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
         setupView()
         setupDefaults()
     }
     
     private func setupDefaults() {
         
         leftButton = nil
         rightButton = nil
         headerLabel = ""
         
     }
     
     // MARK: - Private Helper Methods
     
     // Performs the initial setup.
     private func setupView() {
         let view = viewFromNibForClass()
         view.frame = bounds
         
         // Auto-layout stuff.
         view.autoresizingMask = [
             UIView.AutoresizingMask.flexibleWidth,
             UIView.AutoresizingMask.flexibleHeight
         ]
         
         // Show the view.
         addSubview(view)
     }
     
     // Loads a XIB file into a view and returns this view.
     private func viewFromNibForClass() -> UIView {
         
         let bundle = Bundle(for: type(of: self))
         let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
         let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
         
         
         return view
     }

}
