//
//  SignInView.swift
//  signInFramework
//
//  Created by Aira Samson on 7/29/20.
//  Copyright © 2020 Aira Samson. All rights reserved.
//

import UIKit

open class SignInView : UIView {
    
    public var username: String!
    public var password: String!
    public var fullName: String!
    
    public var showError:Bool = true
    
    public var tapNavLeftButtonAction: (() -> Void)?
    public var tapSignUpButtonAction: (() -> Void)?
    
    public func setupNavigation(title: String, imageName: String) {
        customNav.navLabel.text = title
        customNav.leftButton = UIImage(named:imageName)
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
        customNav.navLeftButton.addTarget(self, action: #selector(didTapNavLeftButton), for: .touchDown)
        customNav.navRightButton.isHidden = true
        return customNav
    }()
    
    lazy var tableView : UITableView = {
        let tableView = UITableView()
        self.container.addSubview(tableView)
        tableView.anchor(top:self.customNav.bottomAnchor, leading: self.container.leadingAnchor, bottom: nil, trailing: self.container.trailingAnchor, size: .init(width: self.container.bounds.width, height: 400))
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.register(FormCvCell.self, forCellReuseIdentifier: .init(describing: FormCvCell.self))
        return tableView
    }()
    
    lazy var btnSignUp: UIButton = {
       let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.5764705882, blue: 0.1176470588, alpha: 1)
        button.layer.cornerRadius = 5
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: UIControl.State.normal)
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        self.container.addSubview(button)
        button.anchor(top:nil , leading: self.container.leadingAnchor, bottom: self.container.bottomAnchor, trailing: self.container.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 20, right: 20))
        button.addTarget(self, action: #selector(didTapSignUpButton), for: .touchDown)
       return button
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
        self.btnSignUp.isHidden = false
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
        return 88
    }
        
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: .init(describing: FormCvCell.self), for: indexPath) as? FormCvCell{
            
            cell.customTextField.customTextField.delegate = self
            cell.customTextField.customTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            
            switch indexPath.row {
                
            case 0:
                cell.setupCustomTextField(tag: 0, placeholder: "Email Address", keyboardType: .default, headerLabel: "Email Address", imageName: "", isShow: showError)
                cell.customTextField.customTextField.text = self.username
                cell.customTextField.error = "Email Address should not be empty."
                break
                
            case 1:
                cell.setupCustomTextField(tag: 1, placeholder: "Password", keyboardType: .default, headerLabel: "Password", imageName: "eyeImageView.png", isShow: showError)
                cell.customTextField.error = "Password should not be empty."
                cell.customTextField.customTextField.text = self.password
                cell.customTextField.customTextField.isSecureTextEntry = true
                cell.customTextField.customTextField.disableAutoFill()
                
                let tapRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.didTap(_:)))
                tapRecognizer.minimumPressDuration = 0
                cell.customTextField.customImageView.addGestureRecognizer(tapRecognizer)
                cell.customTextField.customImageView.isUserInteractionEnabled = true
                
                break
                
            default:
                cell.setupCustomTextField(tag: 2, placeholder: "Full Name", keyboardType: .default, headerLabel: "Full Name", imageName: "", isShow: showError)
                cell.customTextField.customTextField.text = self.fullName
                cell.customTextField.error = "Full Name should not be empty."
            break
            
            }
            
            return cell
        }
        return UITableViewCell()
    }
    
}

extension SignInView : UITextFieldDelegate {

    @objc func textFieldDidChange(_ textField: UITextField) {
       switch textField.tag {
       case 0:
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as! FormCvCell
            if textField.text?.count == 0 {
                cell.customTextField.errorLabel.isHidden = !showError
            } else {
                cell.customTextField.errorLabel.isHidden = showError
                self.username = textField.text
            }
            break
       case 1:
        let indexPath = IndexPath(row: 1, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as! FormCvCell
            if textField.text?.count == 0 {
                cell.customTextField.errorLabel.isHidden = !showError
            } else {
                cell.customTextField.errorLabel.isHidden = showError
                self.password = textField.text
            }
            break
       case 2:
        let indexPath = IndexPath(row: 2, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as! FormCvCell
            if textField.text?.count == 0 {
                cell.customTextField.errorLabel.isHidden = !showError
            } else {
                cell.customTextField.errorLabel.isHidden = showError
                self.fullName = textField.text
            }
            break
       default:
            break
        
        }
    }
}

class FormCvCell: BaseTVCell{
    
    lazy var customTextField : CustomizeTextField = {
        let customTextField = CustomizeTextField()
        self.contentView.addSubview(customTextField)
        self.contentView.addConstraintsWithFormat(format: "V:|-0-[v0]-5-|", views: customTextField)
        self.contentView.addConstraintsWithFormat(format: "H:|-0-[v0]-5-|", views: customTextField)
        return customTextField
    }()
    
    override func setupView() {
        customTextField.isHidden = false
    }
    
    public func setupCustomTextField(tag: Int, placeholder: String, keyboardType: UIKeyboardType, headerLabel: String, imageName: String, isShow: Bool) {
        customTextField.customTextField.tag = tag
        customTextField.customTextField.placeholder = placeholder
        customTextField.textLabel.text = headerLabel
        customTextField.imageName = imageName
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

    func didTapNavLeftButton(){
         tapNavLeftButtonAction?()
    }
    
    func didTapSignUpButton(){
        self.tableView.reloadData()
        tapSignUpButtonAction?()
    }
    
    @objc func didTap(_ sender: Any) {
        let tap = sender as! UIGestureRecognizer
        switch tap.state {
        case .began:
            let indexPath = IndexPath(row: 1, section: 0)
            let cell = tableView.cellForRow(at: indexPath) as! FormCvCell
            cell.customTextField.customTextField.resignFirstResponder()
            cell.customTextField.customTextField.isSecureTextEntry = false
        case .ended:
            let indexPath = IndexPath(row: 1, section: 0)
            let cell = tableView.cellForRow(at: indexPath) as! FormCvCell
            cell.customTextField.customTextField.resignFirstResponder()
            cell.customTextField.customTextField.isSecureTextEntry = true
        default:
            return
        }
    }

}

extension UITextField {
    func disableAutoFill() {
        if #available(iOS 12, *) {
            textContentType = .oneTimeCode
        } else {
            textContentType = .init(rawValue: "")
        }
    }
}
