//
//  ItemVC.swift
//  HappyStack
//
//  Created by Sacha DSO on 10/11/2017.
//  Copyright © 2017 HappyStack. All rights reserved.
//

import UIKit

protocol ItemVCDelegate {
    func itemVCDidSaveOrDeleteItem()
}

class ItemVC:UIViewController {
    
    var item = Item()
    var v = ItemView()
    var delegate:ItemVCDelegate?
    
    override func loadView() { view = v }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = (item.name == "") ? "New Item" : item.name
        if presentingViewController != nil {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel,
                                                               target: self,
                                                               action: #selector(ItemVC.close))
            v.nameField.becomeFirstResponder()
        } else {
            v.nameField.text = item.name
            v.datePicker.date = item.time
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save,
                                                            target: self,
                                                            action: #selector(ItemVC.save))
        
        v.deleteButton.tap(delete)
        v.deleteButton.isHidden = false
    }
    
    @objc func save() {
        item.name = v.nameField.text!
        
        
        let calendar = NSCalendar.current
        let ca = calendar.dateComponents( [.hour, .minute], from:  v.datePicker.date)
        let atime = calendar.date(from: ca)!
        
        item.time = atime
        item.createdBy = User.current
        item.saveInBackground()
        close()
        delegate?.itemVCDidSaveOrDeleteItem()
        
        //        // test Local notif.
        //        var n = UILocalNotification()
        //        n.fireDate = NSDate().dateByAddingTimeInterval(10)//v.datePicker.date
        //        n.alertBody = "Hey Buddy it's time to take your \(v.nameField.text)"
        //        n.applicationIconBadgeNumber = 1
        //        UIApplication.sharedApplication().scheduleLocalNotification(n)
        //
        if(UIApplication.instancesRespond(to: #selector(UIApplication.registerUserNotificationSettings(_:)))) {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.sound, .alert, .badge], categories: nil))
        }
    }
    
    func delete() {
        let alert = UIAlertController(title: "Remove",
                                      message: "Do you really want to remove \(item.name) from your stack?",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yup, I'm done with it", style: .default, handler: { _ in
            self.item.deleteInBackground()
            self.close()
            self.delegate?.itemVCDidSaveOrDeleteItem()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc
    func close() {
        if presentingViewController != nil {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
}
