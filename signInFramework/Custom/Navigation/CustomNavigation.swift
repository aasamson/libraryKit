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
    @IBOutlet weak var navButton: UIButton!
    
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
    
     
     public var headerButton: UIImage? {
         get {
             return navButton.currentImage
         }
         set(value) {
             if let image = value {
                 navButton.setImage(image, for: .normal)
                 navButton.isHidden = false
             } else {
                 navButton.setImage(nil, for: .normal)
                 navButton.isHidden = true
             }
         }
     }

     
     // MARK: - Actions
     
     public var tapNavButtonAction: (() -> Void)?
     
     @IBAction func didTapNavButton(_ sender: Any) {
         tapNavButtonAction?()
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
         
         headerButton = nil
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
