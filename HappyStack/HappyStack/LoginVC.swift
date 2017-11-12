//
//  LoginVC.swift
//  HappyStack
//
//  Created by Sacha DSO on 12/11/2017.
//  Copyright © 2017 HappyStack. All rights reserved.
//

import UIKit
import Stevia

protocol LoginVCDelegate: class {
    func loginVCDidLogin(user: User)
}

final class LoginVC: UIViewController {
    
    weak var delegate: LoginVCDelegate?
    var counter = 5
    var v = LoginView()
    override func loadView() { view = v }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        v.login.addTarget(self, action: #selector(login), for: .touchUpInside)
        prefillWithPreviouslyUsedEmail()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        v.email.becomeFirstResponder()
    }
    
    @objc
    func login() {
        guard let email = v.email.text, let password = v.password.text else {
            return
        }
        saveEnteredCredentials()
        v.login.alpha = 0.7
        v.login.isEnabled = false
        
        User.login(username: email, password: password).then { user in
            User.current = user
            self.stopLoginAnimation()
            self.delegate?.loginVCDidLogin(user: user)
        }.onError { _ in
            self.stopLoginAnimation()
            self.animateWrongLogin()
        }
    }
    
    func saveEnteredCredentials() {
        let localStorage = UserDefaults.standard
        localStorage.set(v.email.text, forKey: "HSLoginPreviousEmail")
        localStorage.synchronize()
    }
    
    func stopLoginAnimation() {
        v.login.alpha = 1
        v.login.isEnabled = true
    }
    
    func animateWrongLogin() {
        let multiplier: CGFloat = 5
        var offset: CGFloat = CGFloat(counter)*multiplier
        if counter % 2 != 0 {
            offset = -offset
        }
        
        UIView.animate(withDuration: 0.07, animations: {
            self.v.emailBackground.transform = CGAffineTransform(translationX: offset, y: 0)
            self.v.passwordBackground.transform = CGAffineTransform(translationX: offset, y: 0)
        }) { _ in
            if self.counter > 0 {
                self.counter -= 1
                self.animateWrongLogin()
            } else {
                self.counter = 5
            }
        }
    }
    
    func prefillWithPreviouslyUsedEmail() {
        if let storedEmail = UserDefaults.standard
            .object(forKey: "HSLoginPreviousEmail") as? String {
            v.email.text = storedEmail
        }
    }
}
