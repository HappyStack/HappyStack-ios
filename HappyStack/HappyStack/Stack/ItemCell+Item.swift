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

        visual.image = item.serving.visual
        name.text = item.name
        dosage.text = item.dosage
        let df = DateFormatter()
        df.locale = Locale(identifier: "fr_US")
        df.dateFormat = "hh"// a"
        hour.text = df.string(from: item.time as Date)
        
        let df2 = DateFormatter()
        df2.locale = Locale(identifier: "en_US")
        df2.dateFormat = "mm"// a"
        minutes.text = df2.string(from: item.time as Date)
        servingSize.text = "\(item.servingSize)"
        
        servingType.isHidden = item.isChecked
        servingSize.isHidden = item.isChecked
        takenIndicator.isHidden = !item.isChecked
        
        servingType.image = item.serving.icon
    }
}



extension Serving {
    
    var visual: UIImage {
        switch self {
        case .pill: return #imageLiteral(resourceName: "pillBottle")
        case .scoop: return #imageLiteral(resourceName: "powderBottle")
        case .drop: return #imageLiteral(resourceName: "liquidBottle")
        }
    }
    
    var icon: UIImage {
        switch self {
        case .pill: return #imageLiteral(resourceName: "pill")
        case .scoop: return #imageLiteral(resourceName: "scoop")
        case .drop: return #imageLiteral(resourceName: "drop")
        }
    }
}
