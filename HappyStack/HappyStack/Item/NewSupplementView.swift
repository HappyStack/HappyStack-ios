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
            l.font = UIFont.systemFont(ofSize: 13.5, weight: .semibold)
            l.textColor = UIColor(red: 153/255.0, green: 153/255.0, blue: 153/255.0, alpha: 1)
        }
        field.font = UIFont.systemFont(ofSize: 35, weight: .light)
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
        horizontalStack.layoutMargins.left = -11
        horizontalStack.isLayoutMarginsRelativeArrangement = true
        stack.axis = .vertical
        stack.spacing = -1
        horizontalStack.spacing = 9
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
    let datePicker = UIDatePicker()
    let button = UIButton()
    let cancelButton = UIButton()
    
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
            button,
            cancelButton
        )
        
        // Layout
        let margin: CGFloat = 21
        background.fillContainer()
        card.top(32).fillHorizontally(m: 10)
        image.size(56).top(69).left(32)
        image-20-name
        name.Top == image.Top
        
        type.Top == image.Bottom + (margin + 10)
        type.left(41)
        serving.Top == type.Bottom + margin
        dosage.Top == serving.Bottom + margin
        time.Top == dosage.Bottom + margin
        align(lefts: type,serving, dosage, time)
        
        button.Top == time.Bottom + 40
        button.Left == card.Left + margin
        button.Bottom == card.Bottom - 30
        button.height(42)
        
        align(horizontally: button-cancelButton)

        
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
        
        
        datePicker.style { p in
            p.datePickerMode = .time
            p.minuteInterval = 15
        }
        time.field.inputView = datePicker
        
        button.style { b in
            b.setTitleColor(.white, for: .normal)
            b.setBackgroundColor(.themeMainColor, forState: .normal)
            b.contentEdgeInsets = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
            b.layer.cornerRadius = 21
            b.clipsToBounds = true
            b.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        }
        cancelButton.style { b in
            b.setTitleColor(UIColor.themeMainColor, for: .normal)
//            b.setBackgroundColor(.themeMainColor, forState: .normal)
//            b.contentEdgeInsets = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
//            b.layer.cornerRadius = 21
//            b.clipsToBounds = true
            b.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        }
        
        // Wordings
        name.title.text = "Title"
        name.field.placeholder = "Vitamin D"
        type.title.text = "Type"
        serving.title.text = "Serving"
        serving.field.placeholder = "1,2,3..."
        dosage.title.text = "Dosage"
        dosage.field.placeholder = "600 UI, 3mg, 15ml..."
        time.title.text = "Time"
        time.field.placeholder = "10:30 am"
        button.setTitle("Add my supplement".uppercased(), for: .normal)
        cancelButton.setTitle("Cancel", for: .normal)
    }
}
