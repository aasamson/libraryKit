//
//  CustomTextField.swift
//  signInFramework
//
//  Created by Aira Samson on 7/29/20.
//  Copyright © 2020 Aira Samson. All rights reserved.
//

import UIKit

class CustomizeTextField: UIView {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var customTextField: CustomUITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var customImageView: UIImageView!
    
    var text : String = "" {
        didSet {
            textLabel.text = text
        }
    }
    
    var error : String = "" {
        didSet {
            errorLabel.text = error
        }
    }
    
    var textField : String = "" {
        didSet {
            customTextField.placeholder = textField
        }
    }
    
    var imageName : String = "" {
        didSet {
            customImageView.image = UIImage(named: imageName)
        }
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
        text = ""
        error = ""
        textField = ""
        imageName = ""
        customView.layer.cornerRadius = 5
        customView.layer.borderWidth = 1
        customView.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
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
