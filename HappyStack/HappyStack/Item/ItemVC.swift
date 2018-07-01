//
//  ItemVC.swift
//  HappyStack
//
//  Created by Sacha DSO on 10/11/2017.
//  Copyright © 2017 HappyStack. All rights reserved.
//

//import UIKit
//
//class ItemVC: UIViewController {
//    
//
//    
//    var isNewItem = false
//    
//    init(item: Item) {
//        self.item = item
//        super.init(nibName: nil, bundle: nil)
//    }
//    
//    convenience init() {
//        self.init(item: Item(name: "Unknown"))
//        self.isNewItem = true
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        title = isNewItem ? "New Item" : item.name
//        
////        if isNewItem {
//            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
//                                                               target: self,
//                                                               action: #selector(close))
////            v.nameField.becomeFirstResponder()
////        } else {
//            v.nameField.text = item.name
//            v.dosageField.text = item.dosage
//            v.datePicker.date = item.time
////        }
//        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
//                                                            target: self,
//                                                            action: #selector(save))
//        
//        
//        v.deleteButton.addTarget(self, action: #selector(deleteItem), for: .touchUpInside)
//        v.deleteButton.isHidden = isNewItem
//    }
//    
//    @objc
//    func save() {
//        
//        let name = v.nameField.text!
//        let dosage = v.dosageField.text!
//        
//        let calendar = NSCalendar.current
//        let ca = calendar.dateComponents( [.hour, .minute], from:  v.datePicker.date)
//        let time = calendar.date(from: ca)!
//        
//        let editedItem = Item(identifier:item.identifier, name: name, dosage: dosage, time: time, isChecked: item.isChecked)
//        editedItem.saveInBackground()
//        
//        close()
//        delegate?.itemVCDidSaveOrDeleteItem()
//        
//        //        // test Local notif.
//        //        var n = UILocalNotification()
//        //        n.fireDate = NSDate().dateByAddingTimeInterval(10)//v.datePicker.date
//        //        n.alertBody = "Hey Buddy it's time to take your \(v.nameField.text)"
//        //        n.applicationIconBadgeNumber = 1
//        //        UIApplication.sharedApplication().scheduleLocalNotification(n)
//        //
//        if(UIApplication.instancesRespond(to: #selector(UIApplication.registerUserNotificationSettings(_:)))) {
//            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.sound, .alert, .badge], categories: nil))
//        }
//    }
//    
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
//        delegate?.itemVCDidTapCancel()
//    }
//    
//}
