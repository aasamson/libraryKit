//
//  ViewControllerSignUp.swift
//  loginKit
//
//  Created by Aira Samson on 8/4/20.
//  Copyright © 2020 Aira Samson. All rights reserved.
//

import UIKit

import signInFramework

class ViewControllerSignUp: UIViewController {
    
    lazy var signIn: SignInView = {
         var view = SignInView()
         self.view.addSubview(view)
         view.anchor(top: self.view.topAnchor, leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor)
         self.view.addConstraint(.init(item: view, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0))
         return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        signIn.isHidden = false
        signIn.setupNavigation(title: "Sign Up", imageName: "navClose.png")
        signIn.tapNavButtonAction = {
            self.dismiss(animated: true, completion: nil)
        }
        
       // signIn.setupFirstNameTextField(placeholder: "First Name", headerLabel: "First Name", imageName: "", isShow: false)
    }

}
