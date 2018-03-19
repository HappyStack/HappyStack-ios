//
//  NewSupplementView.swift
//  HappyStack
//
//  Created by Sacha DSO on 19/03/2018.
//  Copyright © 2018 HappyStack. All rights reserved.
//

import UIKit
import Stevia

class FieldComponent: UIView {
    
    let title = UILabel()
    let field = UITextField()
    
    convenience init() {
        self.init(frame: CGRect.zero)
        render()
    }
    
    func render() {
        let stack = UIStackView(arrangedSubviews: [
            title,
            field
        ])
        stack.axis = .vertical
        
        sv(stack)
        stack.fillContainer()
        
        title.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        title.textColor = UIColor(red: 153/255.0, green: 153/255.0, blue: 153/255.0, alpha: 1)
        field.font = UIFont.systemFont(ofSize: 36, weight: .light)
    }
}

class ServingTypeComponent: UIView {
    
    let title = UILabel()
    let field = UITextField()
    
    convenience init() {
        self.init(frame: CGRect.zero)
        render()
    }
    
    func render() {
        let image1 = UIImageView()
        image1.image = #imageLiteral(resourceName: "pill")
        let image2 = UIImageView()
        image2.image = #imageLiteral(resourceName: "scoop")
        let image3 = UIImageView()
        image3.image = #imageLiteral(resourceName: "drop")
        
        image1.contentMode = .center
        image2.contentMode = .center
        image3.contentMode = .center
        
        let horizontalStack = UIStackView(arrangedSubviews: [
            image1, image2, image3
        ])
        
        let stack = UIStackView(arrangedSubviews: [
            title,
            field,
            horizontalStack
            ])
        stack.axis = .vertical
        stack.spacing = 10
        horizontalStack.spacing = 20
        
        sv(stack)
        stack.fillContainer()
        
        title.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        title.textColor = UIColor(red: 153/255.0, green: 153/255.0, blue: 153/255.0, alpha: 1)
        field.font = UIFont.systemFont(ofSize: 36, weight: .light)
        
        field.isHidden = true
        
//        image1.translatesAutoresizingMaskIntoConstraints = false
        image1.size(50)
        image2.size(50)
        image3.size(50)
    }
}

class NewSupplementView: UIView {
    
    convenience init() {
        self.init(frame: CGRect.zero)
        render()
    }
    
    func render() {
        
        let image = UIImageView()
        let card = UIView()
        let name = FieldComponent()
        let type = ServingTypeComponent()
        let serving = FieldComponent()
        let dosage = FieldComponent()
        let time = FieldComponent()
        let background = UIImageView(image: #imageLiteral(resourceName: "BG"))
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "checkButton"), for: .normal)
        
        sv(
            background,
            card,
            image,
            name,
            type,
            serving,
            dosage,
            time,
            button
        )
        
        background.fillContainer()

        let margin: CGFloat = 20
        
        image.size(56).top(69).left(32)
        alignHorizontally(image-20-name)
        
        type.Top == name.Bottom + margin
        type.left(40)
        
        serving.Top == type.Bottom + margin

        dosage.Top == serving.Bottom + margin
        time.Top == dosage.Bottom + margin
        
        align(lefts: type,serving, dosage, time)
        
        button.Right == card.Right - 10
        button.Bottom == card.Bottom
        
        image.backgroundColor = UIColor(red: 229/255.0, green: 229/255.0, blue: 229/255.0, alpha: 1)
//        image.backgroundColor = .lightGray
        image.layer.cornerRadius = 4
        
        // Wordings
        name.title.text = "Title"
        name.field.placeholder = "Vitamin D"
        
        
        type.title.text = "Type"
        type.field.placeholder = "2"
        
        serving.title.text = "Serving"
        serving.field.placeholder = "2"
        
        dosage.title.text = "Dosage"
        dosage.field.placeholder = "5 000 UI"
        
        time.title.text = "Time"
        time.field.placeholder = "10:30 am"
        
        // Text
        name.field.text = "Vitamin D"
        serving.field.text = "2"
        dosage.field.text = "5 000 UI"
        time.field.text = "10:30 am"
        
        card.backgroundColor = .white
        card.top(32).bottom(32).fillHorizontally(m: 10)
        card.layer.cornerRadius = 8
        
        backgroundColor = .lightGray
        
        serving.field.keyboardType = .numberPad
//        dosage.field.keyboardType = .emailAddress
        
        
        let datePicker = UIDatePicker()
        datePicker.style { p in
            p.backgroundColor = .white
            p.datePickerMode = .time
            p.minuteInterval = 15
        }
        time.field.inputView = datePicker
    }
}
