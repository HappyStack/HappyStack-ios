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

        let stack = UIStackView(arrangedSubviews: [
            title,
            field
        ])
        
        sv(stack)
        
        stack.fillContainer()
        
        stack.axis = .vertical
        title.style { l in
            l.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
            l.textColor = UIColor(red: 153/255.0, green: 153/255.0, blue: 153/255.0, alpha: 1)
        }
        field.font = UIFont.systemFont(ofSize: 36, weight: .light)
    }
}

class ServingTypeComponent: UIView {
    
    let title = UILabel()
    
    convenience init() {
        self.init(frame: CGRect.zero)
        
        let image1 = UIImageView(image:#imageLiteral(resourceName: "pill"))
        let image2 = UIImageView(image:#imageLiteral(resourceName: "scoop"))
        let image3 = UIImageView(image:#imageLiteral(resourceName: "drop"))
        let images = [image1, image2, image3]
        
        let horizontalStack = UIStackView(arrangedSubviews: images)
        let stack = UIStackView(arrangedSubviews: [
            title,
            horizontalStack
        ])
        
        sv(stack)
        
        stack.fillContainer()
        images.forEach { $0.size(50) }
        
        title.style { l in
            l.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
            l.textColor = UIColor(red: 153/255.0, green: 153/255.0, blue: 153/255.0, alpha: 1)
        }
        stack.axis = .vertical
        stack.spacing = 10
        horizontalStack.spacing = 20
        images.forEach { $0.contentMode = .center }
    }
}

class NewSupplementView: UIView {
    
    let background = UIImageView(image: #imageLiteral(resourceName: "BG"))
    let card = UIView()
    let image = UIImageView()
    let name = FieldComponent()
    let type = ServingTypeComponent()
    let serving = FieldComponent()
    let dosage = FieldComponent()
    let time = FieldComponent()
    let button = UIButton()
    
    convenience init() {
        self.init(frame: CGRect.zero)
        
        // View Hierarchy
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
        
        // Layout
        let margin: CGFloat = 20
        background.fillContainer()
        card.top(32).bottom(32).fillHorizontally(m: 10)
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
        
        // Style
        card.style { v in
            v.backgroundColor = .white
            v.layer.cornerRadius = 8
        }
        image.style { i in
            i.backgroundColor = UIColor(red: 229/255.0, green: 229/255.0, blue: 229/255.0, alpha: 1)
            i.layer.cornerRadius = 4
        }
        serving.field.keyboardType = .numberPad
        button.setImage(#imageLiteral(resourceName: "checkButton"), for: .normal)
        
        let datePicker = UIDatePicker()
        datePicker.style { p in
            p.datePickerMode = .time
            p.minuteInterval = 15
        }
        time.field.inputView = datePicker
        
        // Wordings
        name.title.text = "Title"
        name.field.placeholder = "Vitamin D"
        type.title.text = "Type"
        serving.title.text = "Serving"
        serving.field.placeholder = "2"
        dosage.title.text = "Dosage"
        dosage.field.placeholder = "5 000 UI"
        time.title.text = "Time"
        time.field.placeholder = "10:30 am"
        
        // Test Texts
        name.field.text = "Vitamin D"
        serving.field.text = "2"
        dosage.field.text = "5 000 UI"
        time.field.text = "10:30 am"
    }
}
