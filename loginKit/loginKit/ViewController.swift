//
//  ViewController.swift
//  loginKit
//
//  Created by Aira Samson on 6/30/20.
//  Copyright © 2020 Aira Samson. All rights reserved.
//

import UIKit

import loginFramework

import GoogleSignIn

import FBSDKLoginKit

import FacebookLogin

import FacebookCore

class ViewController: UIViewController, GIDSignInDelegate {
    
    struct segueIds {
        
        static let showSignIn = "showSignInSegue"
        
    }
    
    lazy var login: LoginView = {
         var view = LoginView()
         self.view.addSubview(view)
         view.anchor(top: self.view.topAnchor, leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor)
         self.view.addConstraint(.init(item: view, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0))
         return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let token = AccessToken.current, !token.isExpired {
           print("Not logged in")
        } else {
            getFacebookUserInfo()
        }
        
        login.isHidden = false
        login.logoImage = "1.png"
        
        login.setupUserName(placeholder: "Email Address", keyboardType: .default, imageName: "", isShow: true)
        
        login.setupPassword(placeholder: "Password", keyboardType: .default, imageName: "eyeImageView.png", isShow: false)
        
        login.setupLoginButton(font: "Helvetica", size: 12, bgColor: #colorLiteral(red: 0.968627451, green: 0.5764705882, blue: 0.1176470588, alpha: 1), titleColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), btnName: "LOG IN")
        login.setuptextLabel(text: "Don't have an account?", font: "Helvetica", size: 12, textColor: #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1))
        login.setupSignUpLabel(text: "Sign Up.", font: "Helvetica", size: 12, textColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
        
        login.tapGoogleLoginAction = {
            GIDSignIn.sharedInstance()?.presentingViewController = self
            GIDSignIn.sharedInstance()?.delegate = self
            GIDSignIn.sharedInstance()?.signIn()
        }
        
        login.tapFacebookLoginAction = {
            self.getFacebookUserInfo()
        }
        
        login.tapSignUpAction = {
            self.performSegue(withIdentifier: segueIds.showSignIn, sender: self)
        }
    }

    func getFacebookUserInfo(){
        let loginManager = LoginManager()
        loginManager.logIn(permissions: [.publicProfile, .email], viewController: self) { (result) in
            switch result{
            case .cancelled:
                print("Cancel button click")
            case .success:
                let params = ["fields" : "id, name, first_name, last_name, picture.type(large), email "]
                let graphRequest = GraphRequest.init(graphPath: "/me", parameters: params)
                let Connection = GraphRequestConnection()
                Connection.add(graphRequest) { (Connection, result, error) in
                    let info = result as! [String : AnyObject]
                    print(info["name"] as! String)
                }
                Connection.start()
            case .failed(let err):
                print(err.localizedDescription)
            }
        }
    }
    
   func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error != nil) {
            print(error.localizedDescription)
        } else {
            print("User Email : \(user.profile.email ?? "")")
        }
    }

    open func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
    }

}

