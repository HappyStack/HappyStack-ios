//
//  NewSupplementVC.swift
//  HappyStack
//
//  Created by Sacha DSO on 19/03/2018.
//  Copyright © 2018 HappyStack. All rights reserved.
//

import UIKit

class NewSupplementVC: UIViewController {
    
    var v = NewSupplementView()
    override func loadView() { view = v }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        on("INJECTION_BUNDLE_NOTIFICATION") {
            self.view = NewSupplementView()
        }
        
//        v.name.field.becomeFirstResponder()
        v.button.addTarget(self, action: #selector(addSupplement), for: .touchUpInside)
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        view.addGestureRecognizer(tap)
    }
    
    @objc
    func tapped() {
        view.endEditing(true)
    }
    
    @objc
    func addSupplement() {
        
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
    }
    
//    @objc
//    func deleteItem() {
//        let alert = UIAlertController(title: "Remove",
//                                      message: "Do you really want to remove \(item.name) from your stack?",
//            preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Yup, I'm done with it", style: .default, handler: { _ in
//            self.item.deleteInBackground()
//            self.close()
//            self.delegate?.itemVCDidSaveOrDeleteItem()
//        }))
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        present(alert, animated: true, completion: nil)
//    }
//
//    @objc
//    func close() {
//        if isNewItem {
//            dismiss(animated: true, completion: nil)
//        } else {
//            navigationController?.popViewController(animated: true)
//        }
//    }

