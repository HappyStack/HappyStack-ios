//
//  SupplementView.swift
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
            l.font = UIFont(name: "Lato-Medium", size: 14)
            l.textColor = .themeMainColor
        }
        field.style { f in
            f.font = UIFont(name: "Lato-Light", size: 36)
            f.textColor = .themeDarkColor
        }
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
            l.font = UIFont(name: "Lato-Medium", size: 14)
            l.textColor = .themeMainColor
        }
        horizontalStack.layoutMargins.left = -11
        horizontalStack.isLayoutMarginsRelativeArrangement = true
        stack.axis = .vertical
        stack.spacing = -1
        horizontalStack.spacing = 9
        images.forEach { $0.contentMode = .center }
    }
}

class SupplementView: UIView {
    
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
    let deleteButton = UIButton()
    
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
            cancelButton,
            deleteButton
        )
        
        // Layout
        let margin: CGFloat = 21
        background.fillContainer()
        
        card.Top == safeAreaLayoutGuide.Top + 32
        card.fillHorizontally(m: 10)
        
        image.Top == card.Top + 37
        image.size(56).left(32)
        image-20-name-20-|
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
        
        deleteButton.centerHorizontally()
        deleteButton.Top == card.Bottom + 20

        
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
            b.titleLabel?.font = UIFont(name: "Lato-Bold", size: 12)
        }
        cancelButton.style { b in
            b.setTitleColor(UIColor.themeMainColor, for: .normal)
            b.titleLabel?.font = UIFont(name: "Lato-Semibold", size: 15)
        }
        deleteButton.style { b in
            b.setTitleColor(UIColor.red, for: .normal)
            b.titleLabel?.font = UIFont(name: "Lato-Semibold", size: 15)
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
        deleteButton.setTitle("Delete", for: .normal)
        
        name.field.adjustsFontSizeToFitWidth = true
        name.field.minimumFontSize = 16
    }
}
