//
//  LoginView.swift
//  loginFramework
//
//  Created by Aira Samson on 7/8/20.
//  Copyright © 2020 Aira Samson. All rights reserved.
//

import UIKit

open class LoginView: UIView {
    
    // MARK: - Actions
    public var tapGoogleLoginAction: (() -> Void)?
    public var tapFacebookLoginAction: (() -> Void)?
    public var tapSignUpAction: (() -> Void)?
    
    open var logoImage : String = "" {
        didSet {
            imageView.image = UIImage(named: logoImage)
        }
    }
    
    public func setupUserName(placeholder: String, keyboardType: UIKeyboardType,imageName: String,isShow: Bool) {
        userNameTextField.customTextField.placeholder = placeholder
        userNameTextField.customTextField.keyboardType = keyboardType
        userNameTextField.imageName = imageName
        userNameTextField.customImageView.isHidden = isShow
        
    }
    
    public func setupPassword(placeholder: String, keyboardType: UIKeyboardType,imageName: String,isShow: Bool) {
        passwordTextField.customTextField.placeholder = placeholder
        passwordTextField.customTextField.keyboardType = keyboardType
        passwordTextField.imageName = imageName
        passwordTextField.customImageView.isHidden = isShow
    }
    
    public func setupLoginButton(font: String, size: Int, bgColor: UIColor, titleColor: UIColor, btnName: String) {
        loginButton.titleLabel?.font = UIFont(name: font, size: CGFloat(size))
        loginButton.backgroundColor = bgColor
        loginButton.setTitleColor(titleColor, for: .normal)
        loginButton.setTitle(btnName, for: .normal)
    }
    
    public func setuptextLabel(text: String, font: String, size: Int, textColor: UIColor) {
        textLabel.text = text
        textLabel.textColor = textColor
        textLabel.font = UIFont(name: font, size: CGFloat(size))
    }
    
    public func setupSignUpLabel(text: String, font: String, size: Int, textColor: UIColor) {
        signUpLabel.text = text
        signUpLabel.textColor = textColor
        signUpLabel.font = UIFont(name: font, size: CGFloat(size))
    }

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        self.container.addSubview(imageView)
        imageView.anchor(top:self.container.topAnchor , leading: self.container.leadingAnchor, bottom: nil, trailing: self.container.trailingAnchor, padding: .init(top: 80, left: 40, bottom: 0, right: 40))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var userNameTextField : CustomTextField = {
        let userNameTextField = CustomTextField()
        self.container.addSubview(userNameTextField)
        userNameTextField.anchor(top:self.imageView.bottomAnchor, leading: self.container.leadingAnchor, bottom: nil, trailing: self.container.trailingAnchor, padding: .init(top: 30, left: 0, bottom: 0, right: 0), size: .init(width: self.container.bounds.width, height: 65))
        userNameTextField.customTextField.delegate = self
        userNameTextField.customTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
        return userNameTextField
    }()
    
    lazy var passwordTextField : CustomTextField = {
        let passwordTextField = CustomTextField()
        self.container.addSubview(passwordTextField)
        passwordTextField.anchor(top:self.userNameTextField.bottomAnchor, leading: self.container.leadingAnchor, bottom: nil, trailing: self.container.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: self.container.bounds.width, height: 65))
        passwordTextField.customTextField.delegate = self
        passwordTextField.customTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
        
        let tapRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.didTap(_:)))
        tapRecognizer.minimumPressDuration = 0
        passwordTextField.customImageView.addGestureRecognizer(tapRecognizer)
        passwordTextField.customImageView.isUserInteractionEnabled = true
        passwordTextField.customTextField.disableAutoFill()
        
        return passwordTextField
    }()
    
    lazy var loginButton : UIButton = {
        let loginButton = UIButton()
        self.container.addSubview(loginButton)
        loginButton.anchor(top:self.passwordTextField.bottomAnchor, leading: self.container.leadingAnchor, bottom: nil, trailing: self.container.trailingAnchor, padding: .init(top: 15, left: 40, bottom: 0, right: 40), size: .init(width: 300, height: 40))
        loginButton.layer.cornerRadius = 5
        return loginButton
    }()
    
    lazy var fbButton : UIButton = {
        let fbButton = UIButton()
        self.container.addSubview(fbButton)
        fbButton.anchor(top:self.loginButton.bottomAnchor, leading: self.container.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 80, left: 140, bottom: 0, right: 10), size: .init(width: 40, height: 40))
        fbButton.setImage(UIImage(named: "facebook.png"), for: .normal)
        fbButton.addTarget(self, action: #selector(didTapFacebookLogin), for: .touchDown)
        return fbButton
    }()
    
    lazy var googleButton : UIButton = {
        let googleButton = UIButton()
        self.container.addSubview(googleButton)
        googleButton.anchor(top:self.loginButton.bottomAnchor, leading: nil, bottom: nil, trailing: self.container.trailingAnchor, padding: .init(top: 80, left: 10, bottom: 0, right: 140), size: .init(width: 40, height: 40))
        googleButton.setImage(UIImage(named: "google.png"), for: .normal)
        googleButton.addTarget(self, action: #selector(didTapGoogleLogin), for: .touchDown)
        return fbButton
    }()
    
    lazy var textLabel : UILabel = {
        let textLabel = UILabel()
        self.container.addSubview(textLabel)
        textLabel.anchor(top:self.fbButton.bottomAnchor, leading: self.container.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 15, left: 100, bottom: 0, right: 0))
        return textLabel
    }()
    
    lazy var signUpLabel : UILabel = {
        let signUpLabel = UILabel()
        self.container.addSubview(signUpLabel)
        signUpLabel.anchor(top:self.fbButton.bottomAnchor, leading: nil, bottom: nil, trailing: self.container.trailingAnchor, padding: .init(top: 15, left: 0, bottom: 0, right: 100))
        let signUpLabelTap = UITapGestureRecognizer(target: self, action: #selector(self.didTapSignUp(_:)))
        signUpLabel.isUserInteractionEnabled = true
        signUpLabel.addGestureRecognizer(signUpLabelTap)
        return signUpLabel
    }()
    
    lazy var container: UIView = {
        var view = UIView()
        self.addSubview(view)
        self.addConstraintsWithFormat(format: "V:|[v0]|", views: view)
        self.addConstraintsWithFormat(format: "H:|[v0]|", views: view)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView(){
        self.container.isHidden = false
        self.imageView.isHidden = false
        self.userNameTextField.isHidden = false
        self.passwordTextField.isHidden = false
        self.loginButton.isHidden = false
        self.fbButton.isHidden = false
        self.googleButton.isHidden = false
        self.textLabel.isHidden = false
        self.signUpLabel.isHidden = false
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LoginView : UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if textField == self.userNameTextField.customTextField {
            if textField.text?.count == 0 {
                self.userNameTextField.error = "User Email should not be empty"
                self.userNameTextField.errorLabel.isHidden = false
            } else {
                self.userNameTextField.errorLabel.isHidden = true
            }
        } else {
            if textField.text?.count == 0 {
                self.passwordTextField.error = "Password should not be empty"
                self.passwordTextField.errorLabel.isHidden = false
            } else {
                self.passwordTextField.errorLabel.isHidden = true
            }
        }
        
    }
}

@objc
extension LoginView {
    
    func didTapGoogleLogin(){
        tapGoogleLoginAction?()
    }
    
    func didTapFacebookLogin(){
        tapFacebookLoginAction?()
    }
    
    func didTapSignUp(_ sender: UITapGestureRecognizer){
        tapSignUpAction?()
    }
    
    
    @objc func didTap(_ sender: Any) {
        let tap = sender as! UIGestureRecognizer
        switch tap.state {
        case .began:
            passwordTextField.customTextField.resignFirstResponder()
            passwordTextField.customTextField.isSecureTextEntry = false
        case .ended:
            passwordTextField.customTextField.resignFirstResponder()
            passwordTextField.customTextField.isSecureTextEntry = true
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

