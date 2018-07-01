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
    
    var item: Item?
    
    var didCancel = {}
    var didDelete = {}
    var didAddSupplement = {}
    var isNewItem = false
    
    var v = SupplementView()
    override func loadView() { view = v }

    convenience init() {
        self.init(item: Item(name: "Unknown"))
        isNewItem = true
    }
    
    init(item: Item) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        v.deleteButton.isHidden = isNewItem
        
        if let item = item {
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
        
        if var item = item {
            
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
            item.time = df.date(from: v.time.field.text!)!
            
            
            item.saveInBackground()
            view.endEditing(true)
            didAddSupplement()
        } else {
            
            let name = v.name.field.text!
            var newItem = Item(name: name)//, dosage: dosage, time: time)
            if let serving = v.serving.field.text, let servingInt = Int(serving) {
                newItem.servingSize = servingInt
            }
            newItem.dosage = v.dosage.field.text!
            
            // time.
            let calendar = NSCalendar.current
            let ca = calendar.dateComponents( [.hour, .minute], from:  v.datePicker.date)
            let time = calendar.date(from: ca)!
            newItem.time = time
            
            newItem.saveInBackground()
            
            v.name.field.text = ""
            v.serving.field.text = ""
            v.dosage.field.text = ""
            v.time.field.text = ""
            
            view.endEditing(true)
            didAddSupplement()
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
        guard let item = item else {
            return 
        }
        let alert = UIAlertController(title: "Remove",
                                      message: "Do you really want to remove \(item.name) from your stack?",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yup, I'm done with it", style: .default, handler: { [weak self] _ in
            item.deleteInBackground()
            self?.didDelete()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

