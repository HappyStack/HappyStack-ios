//
//  SupplementVC.swift
//  HappyStack
//
//  Created by Sacha DSO on 19/03/2018.
//  Copyright © 2018 HappyStack. All rights reserved.
//

import UIKit

class SupplementVC: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var item: Item
    
    var didCancel = {}
    var didDelete = {}
    var didAddSupplement = {}
    
    var v = SupplementView()
    override func loadView() { view = v }

    convenience init() {
        self.init(item: Item())
    }
    
    init(item: Item) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func servingTypePillTapped() {
        item.serving = .pill
        v.type.button1.setBackgroundColor(UIColor.clear, forState: .normal)
        v.type.button2.setBackgroundColor(UIColor.white.withAlphaComponent(0.5), forState: .normal)
        v.type.button3.setBackgroundColor(UIColor.white.withAlphaComponent(0.5), forState: .normal)
    }
    
    @objc
    func servingTypeScoopTapped() {
        item.serving = .scoop
        v.type.button1.setBackgroundColor(UIColor.white.withAlphaComponent(0.5), forState: .normal)
        v.type.button2.setBackgroundColor(UIColor.clear, forState: .normal)
        v.type.button3.setBackgroundColor(UIColor.white.withAlphaComponent(0.5), forState: .normal)
    }
    
    @objc
    func servingTypeDropTapped() {
        item.serving = .drop
        v.type.button1.setBackgroundColor(UIColor.white.withAlphaComponent(0.5), forState: .normal)
        v.type.button2.setBackgroundColor(UIColor.white.withAlphaComponent(0.5), forState: .normal)
        v.type.button3.setBackgroundColor(UIColor.clear, forState: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        v.type.button1.addTarget(self, action: #selector(servingTypePillTapped), for: .touchUpInside)
        v.type.button2.addTarget(self, action: #selector(servingTypeScoopTapped), for: .touchUpInside)
        v.type.button3.addTarget(self, action: #selector(servingTypeDropTapped), for: .touchUpInside)
        
        
        v.deleteButton.isHidden = item.isNew
        v.button.setTitle((item.isNew ? "Add my supplement" : "Save").uppercased() , for: .normal)
        
        if !item.isNew {
            v.name.field.text = item.name
            v.serving.field.text = "\(item.servingSize)"
            v.dosage.field.text = item.dosage
            
            let df = DateFormatter()
            df.dateFormat = "h:mm a"
            v.time.field.text = df.string(from: item.time)
        }
    
        v.button.addTarget(self, action: #selector(addSupplement), for: .touchUpInside)
        v.cancelButton.addTarget(self, action: #selector(didTapCancel), for: .touchUpInside)
        v.deleteButton.addTarget(self, action: #selector(deleteItem), for: .touchUpInside)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        view.addGestureRecognizer(tap)
    
        v.datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        
        
        
        let calendar = NSCalendar.current
        let ca = calendar.dateComponents( [.hour, .minute], from:  v.datePicker.date)
        let time = calendar.date(from: ca)!
        
        servingTypePillTapped()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        v.name.field.becomeFirstResponder()
    }
    
    @objc
    func dateChanged() {
        let df = DateFormatter()
        df.dateFormat = "h:mm a"
        v.time.field.text = df.string(from: v.datePicker.date)
    }
    
    @objc
    func tapped() {
        view.endEditing(true)
    }
    
    @objc
    func didTapCancel() {
        didCancel()
    }
    
    @objc
    func addSupplement() {
        
        if !item.isNew {
            item.name = v.name.field.text!
            if let serving = v.serving.field.text, let servingInt = Int(serving) {
                item.servingSize = servingInt
            }
            item.dosage = v.dosage.field.text!
            
            // time.
//            let calendar = NSCalendar.current
//            let ca = calendar.dateComponents( [.hour, .minute], from:  v.datePicker.date)
//            let time = calendar.date(from: ca)!
//            item.time = time
    
            // Set date picker date
            let df = DateFormatter()
            df.dateFormat = "h:mm a"
            if let dateString = v.time.field.text, let date = df.date(from: dateString) {
                
                item.time = date
            }
   
            
            item.time = df.date(from: v.time.field.text!)!

            item.save().then { [weak self] in
                self?.view.endEditing(true)
                self?.didAddSupplement()
            }

        } else {
            item.name = v.name.field.text ?? ""
            if let serving = v.serving.field.text, let servingInt = Int(serving) {
                item.servingSize = servingInt
            }
            item.dosage = v.dosage.field.text!
            
            // time.
            let calendar = NSCalendar.current
            let ca = calendar.dateComponents( [.hour, .minute], from:  v.datePicker.date)
            let time = calendar.date(from: ca)!
            item.time = time
            
            item.save().then { [weak self] in
                self?.v.name.field.text = ""
                self?.v.serving.field.text = ""
                self?.v.dosage.field.text = ""
                self?.v.time.field.text = ""
                self?.view.endEditing(true)
                self?.didAddSupplement()
            }
        }
    }
        
//        close()
//        delegate?.itemVCDidSaveOrDeleteItem()
        
        //        // test Local notif.
        //        var n = UILocalNotification()
        //        n. fireDate = NSDate().dateByAddingTimeInterval(10)//v.datePicker.date
        //        n.alertBody = "Hey Buddy it's time to take your \(v.nameField.text)"
        //        n.applicationIconBadgeNumber = 1
        //        UIApplication.sharedApplication().scheduleLocalNotification(n)
        //
//        if(UIApplication.instancesRespond(to: #selector(UIApplication.registerUserNotificationSettings(_:)))) {
//            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.sound, .alert, .badge], categories: nil))
//        }
    
    @objc
    func deleteItem() {
        let alert = UIAlertController(title: "Remove",
                                      message: "Do you really want to remove \(item.name) from your stack?",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yup, I'm done with it", style: .default, handler: { [weak self] _ in
            self?.item.delete().then {
                self?.didDelete()
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension Item {
    var isNew: Bool { return identifier == 0 }
}
