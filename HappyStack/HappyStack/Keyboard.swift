//
//  Keyboard.swift
//  HappyStack
//
//  Created by Sacha DSO on 12/11/2017.
//  Copyright © 2017 HappyStack. All rights reserved.
//

import UIKit

public class Keyboard {
    
    var topAnchor: NSLayoutYAxisAnchor {
        return keyboardLayoutGuide.topAnchor
    }
    
    var height:CGFloat = 0
    
    private let keyboardLayoutGuide = UILayoutGuide()
    
    init() {
        let nc = NotificationCenter.default
        nc.addObserver(self,
                       selector: #selector(keyboardWillShow(_:)),
                       name: .UIKeyboardWillShow,
                       object: nil)
        nc.addObserver(self,
                       selector: #selector(keyboardWillHide(_:)),
                       name: .UIKeyboardWillHide,
                       object: nil)
    }
    
    var view: UIView?
    
    public func initializeKeyboardLayoutGuide(inView view: UIView) {
        self.view = view
        view.addLayoutGuide(keyboardLayoutGuide)
        
        if #available(iOS 11.0, *) {
            height = view.safeAreaInsets.bottom
        } else {
            height = 0
        }
        keyboardLayoutGuide.heightAnchor.constraint(equalToConstant: height).isActive = true
        keyboardLayoutGuide.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        keyboardLayoutGuide.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        keyboardLayoutGuide.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    private var keyboardWillChangeBlock:((CGFloat) -> Void)?
    
    public func keyboardWillChange(block: @escaping (CGFloat) -> Void) {
        keyboardWillChangeBlock = block
    }
    
    @objc
    func keyboardWillShow(_ note: Notification) {
        if let h = note.keyboardHeight {
            height = h
            keyboardLayoutGuide.heightConstraint?.constant = height
        }
        animate(note)
        keyboardWillChangeBlock?(height)
    }
    
    @objc
    func keyboardWillHide(_ note: Notification) {
        if #available(iOS 11.0, *) {
            height = view?.safeAreaInsets.bottom ?? 0
        } else {
            height = 0
        }
        keyboardLayoutGuide.heightConstraint?.constant = height
        animate(note)
        keyboardWillChangeBlock?(height)
    }
    
    func animate(_ note: Notification) {
        guard let animationDuration = note.animationDuration,
            let animationCurve = note.animationCurve else {
                return
        }
        UIView.animate(withDuration: animationDuration, delay: 0, options: animationCurve, animations: {
            self.keyboardLayoutGuide.owningView?.layoutIfNeeded()
        }, completion: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

public extension UILayoutGuide {
    var heightConstraint: NSLayoutConstraint? {
        guard let target = owningView else { return nil }
        for c in target.constraints {
            if let fi = c.firstItem as? UILayoutGuide, fi == self && c.firstAttribute == .height {
                return c
            }
        }
        return nil
    }
}

extension Notification {
    
    var animationDuration: TimeInterval? {
        return (userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double)
    }
    
    var animationCurve: UIViewAnimationOptions? {
        guard let value = (userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? Int) else {
            return nil
        }
        return UIViewAnimationOptions(rawValue: UInt(value))
    }
    
    var keyboardHeight: CGFloat? {
        if let v = userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            return v.cgRectValue.size.height
        }
        return nil
    }
}
