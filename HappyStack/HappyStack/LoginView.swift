//
//  LoginView.swift
//  HappyStack
//
//  Created by Sacha DSO on 12/11/2017.
//  Copyright © 2017 HappyStack. All rights reserved.
//

import Stevia

final class LoginView: UIView {
    
    let keyboard = Keyboard()
    let login = UIButton()
    let emailBackground = UIView()
    let email = UITextField()
    let passwordBackground = UIView()
    let password = UITextField()
    
    convenience init() {
        self.init(frame: CGRect.zero)
        keyboard.initializeKeyboardLayoutGuide(inView: self)
        
        sv(
            emailBackground.sv(
                email
            ),
            passwordBackground.sv(
                password
            ),
           login
        )
        
        layout(
            100,
            |-20-emailBackground-20-| ~ 50,
            10,
            |-20-passwordBackground-20-| ~ 50,
            >=20,
            |login| ~ 60
        )
        
        login.bottomAnchor.constraint(equalTo: keyboard.topAnchor).isActive = true
        
        layout(
            0,
            |-15-email-15-|,
            0
        )
        
        layout(
            0,
            |-15-password-15-|,
            0
        )
        
        backgroundColor = .white
        emailBackground.style(fieldBackgroundStyle)
        passwordBackground.style(fieldBackgroundStyle)
        email.style { f in
            f.returnKeyType = .next
            f.delegate = self
            f.autocapitalizationType = .none
            f.clearButtonMode = .whileEditing
            f.keyboardType = UIKeyboardType.emailAddress
            f.autocorrectionType = .no
        }
        password.style { f in
            f.isSecureTextEntry = true
            f.returnKeyType = .send
            f.clearButtonMode = .whileEditing
        }
        login.setBackgroundColor(.black, forState: .normal)
        login.setTitleColor(.white, for: .normal)
        
        email.placeholder = "Email"
        password.placeholder = "Password"
        login.text("Login")
    }
    
    func fieldBackgroundStyle(_ v: UIView) {
        v.backgroundColor = .white
        v.layer.cornerRadius = 4
        v.layer.borderWidth = 0.5
    }
}

extension LoginView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        password.becomeFirstResponder()
        return true
    }
}


extension UIButton {
    public func setBackgroundColor(_ color: UIColor, forState: UIControlState) {
        let img = UIImage(color: color, size: CGSize(width: 1.0, height: 1.0))
        setBackgroundImage(img, for: forState)
    }
}


extension UIImage {
    /// Create an square image fill with color
    public convenience init(color: UIColor, size: CGSize) {
        
        var rect = CGRect.zero
        rect.size = size
        
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        color.setFill()
        UIRectFill(rect)
        
        let uiImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if let cgImage = uiImage?.cgImage {
            self.init(cgImage: cgImage)
        } else {
            self.init()
        }
    }
}
