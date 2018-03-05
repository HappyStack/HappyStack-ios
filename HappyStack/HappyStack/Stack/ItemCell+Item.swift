//
//  ItemCell+Item.swift
//  HappyStack
//
//  Created by Sacha DSO on 10/11/2017.
//  Copyright © 2017 HappyStack. All rights reserved.
//

import UIKit

extension ItemCell {
    func render(with item:Item) {
        name.text = item.name
        dosage.text = item.dosage
        let df = DateFormatter()
        df.locale = Locale(identifier: "en_US")
        df.dateFormat = "h:mm"// a"
        time.text = df.string(from: item.time as Date)
        takenIndicator.isHidden = !item.isChecked
        
        name.alpha = item.isChecked ? 0.2 : 1
        dosage.alpha = item.isChecked ? 0.2 : 1
        time.alpha = item.isChecked ? 0.2 : 1
    }
}
