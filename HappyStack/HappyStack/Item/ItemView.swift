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
    let dosageField = UITextField()
    let datePicker = UIDatePicker()
    let deleteButton = UIButton(type: .custom)
    
    convenience init() {
        self.init(frame: CGRect.zero)
    
        sv(
            nameField,
            dosageField,
            datePicker,
            deleteButton
        )
        
        layout(
            80,
            |-nameField-|,
            |-dosageField-|,
            <=20,
            |datePicker|,
            |-deleteButton-| ~ 60,
            0
        )
        
        backgroundColor = .white
        nameField.style { f in
            f.backgroundColor = .white
            f.font = UIFont(name: "HelveticaNeue-Light", size: 40)
            f.textAlignment = .center
            f.returnKeyType = .done
        }
        dosageField.style { f in
            f.backgroundColor = .white
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
        
        
        nameField.placeholder = "Name"
        dosageField.placeholder = "Dosage"
        
        nameField.delegate = self
        dosageField.delegate = self
    }
}

extension ItemView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameField {
            dosageField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}
