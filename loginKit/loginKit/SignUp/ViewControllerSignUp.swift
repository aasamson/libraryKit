//
//  ViewControllerSignUp.swift
//  loginKit
//
//  Created by Aira Samson on 8/4/20.
//  Copyright © 2020 Aira Samson. All rights reserved.
//

import UIKit

import signInFramework

import FirebaseAuth

import FirebaseDatabase

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
        signIn.tapNavLeftButtonAction = {
            self.dismiss(animated: true, completion: nil)
        }
        
        signIn.tapSignUpButtonAction = {
            
            Auth.auth().createUser(withEmail: self.signIn.username, password: self.signIn.password, completion: { (user, error) in
                if error != nil {
                    print(error!.localizedDescription)
                    return
                }
                let ref = Database.database().reference()
                let userReference = ref.child("users")
                let uid = user!.user.uid
                let newUserReference = userReference.child(uid)
                newUserReference.setValue(["emailAddress": self.signIn.username,"password": self.signIn.password,"fullName" : self.signIn.fullName, uid: uid])
                print("description :\(newUserReference.description())")
            })
        }
    }

}
