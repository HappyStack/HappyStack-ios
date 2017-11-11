//
//  ItemView.swift
//  HappyStack
//
//  Created by Sacha DSO on 10/11/2017.
//  Copyright © 2017 HappyStack. All rights reserved.
//

import Stevia

class ItemView: UIView {
    
    let nameField = UITextField()
    let datePicker = UIDatePicker()
    let deleteButton = UIButton(type: .custom)
    
    convenience init() {
        self.init(frame: CGRect.zero)
    
        sv(
            nameField,
            datePicker,
            deleteButton
        )
        
        layout(
            80,
            |-nameField-|,
            "",
            |datePicker|,
            |-deleteButton-| ~ 60,
            0
        )
        
        backgroundColor = .white
        nameField.style { f in
            f.backgroundColor = .white
            f.placeholder = "Name"
            f.font = UIFont(name: "HelveticaNeue-Light", size: 40)
            f.textAlignment = .center
            f.returnKeyType = .done
        }
        datePicker.style { p in
            p.backgroundColor = .white
            p.datePickerMode = .time
            p.minuteInterval = 15
        }
        deleteButton.style { b in
            b.isHidden = true
            b.setTitle("Remove", for: .normal)
            b.setTitleColor(.red, for: .normal)
        }
        
        nameField.delegate = self
    }
}

extension ItemView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
