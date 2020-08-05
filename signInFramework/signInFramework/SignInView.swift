//
//  SignInView.swift
//  signInFramework
//
//  Created by Aira Samson on 7/29/20.
//  Copyright © 2020 Aira Samson. All rights reserved.
//

import UIKit

open class SignInView : UIView {
    
    public var tapNavButtonAction: (() -> Void)?
    
    public func setupNavigation(title: String, imageName: String) {
        customNav.navLabel.text = title
        customNav.headerButton = UIImage(named:imageName)
    }
    
    lazy var container: UIView = {
        var view = UIView()
        self.addSubview(view)
        self.addConstraintsWithFormat(format: "V:|[v0]|", views: view)
        self.addConstraintsWithFormat(format: "H:|[v0]|", views: view)
        return view
    }()
    
    lazy var customNav : CustomNavigation = {
        let customNav = CustomNavigation()
        self.container.addSubview(customNav)
        customNav.backgroundViewColor = UIColor.clear
        customNav.anchor(top:self.container.topAnchor, leading: self.container.leadingAnchor, bottom: nil, trailing: self.container.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: self.container.bounds.width, height: 60))
        customNav.navButton.addTarget(self, action: #selector(didTapNavButton), for: .touchDown)
        return customNav
    }()
    
    lazy var tableView : UITableView = {
        let tableView = UITableView()
        self.container.addSubview(tableView)
        tableView.anchor(top:self.customNav.bottomAnchor, leading: self.container.leadingAnchor, bottom: nil, trailing: self.container.trailingAnchor, size: .init(width: self.container.bounds.width, height: 600))
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.register(FormCvCell.self, forCellReuseIdentifier: .init(describing: FormCvCell.self))
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        self.container.isHidden = false
        self.customNav.isHidden = false
        self.tableView.isHidden = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
        //self.firstNameTextField.isHidden = false
    }
    
}

extension SignInView: UITableViewDelegate, UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
        
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: .init(describing: FormCvCell.self), for: indexPath) as? FormCvCell{
            
            switch indexPath.row {
                
            case 0:
                cell.setupCustomTextField(placeholder: "Full Name", keyboardType: .default, headerLabel: "Full Name", imageName: "", isShow: false)
                break
                
            case 1:
                cell.setupCustomTextField(placeholder: "Email Address", keyboardType: .emailAddress, headerLabel: "Email Address", imageName: "", isShow: false)
                break
            
            default:
                cell.setupCustomTextField(placeholder: "Mobile Number", keyboardType: .numberPad, headerLabel: "Mobile Number", imageName: "", isShow: false)
                
                break
            }
            
            return cell
        }
        return UITableViewCell()
    }
    
}

class FormCvCell: BaseTVCell{
    
    lazy var customTextField : CustomizeTextField = {
        let customTextField = CustomizeTextField()
        self.contentView.addSubview(customTextField)
        self.contentView.addConstraintsWithFormat(format: "V:|-5-[v0]-5-|", views: customTextField)
        self.contentView.addConstraintsWithFormat(format: "H:|-5-[v0]-5-|", views: customTextField)
        return customTextField
    }()
    
    override func setupView() {
        customTextField.isHidden = false
    }
    
    public func setupCustomTextField(placeholder: String, keyboardType: UIKeyboardType, headerLabel: String, imageName: String, isShow: Bool) {
        customTextField.customTextField.placeholder = placeholder
        customTextField.textLabel.text = headerLabel
        customTextField.customImageView.image = UIImage(named: imageName)
        customTextField.customImageView.isHidden = isShow
        customTextField.customTextField.keyboardType = keyboardType
    }
}



open class BaseTVCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    public  func setupView(){
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


@objc
extension SignInView {

    func didTapNavButton(){
        tapNavButtonAction?()
    }

}
