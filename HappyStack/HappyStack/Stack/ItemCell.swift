//
//  ItemCell.swift
//  HappyStack
//
//  Created by Sacha DSO on 10/11/2017.
//  Copyright © 2017 HappyStack. All rights reserved.
//

import UIKit
import Stevia

public class ItemCell: UITableViewCell {
    
    let visual = UIImageView()
    let name = UILabel()
    let dosage = UILabel()
    let hour = UILabel()
    let minutes = UILabel()
    let servingType = UIImageView()
    let servingSize = UILabel()
    let takenIndicator = UIImageView(image: #imageLiteral(resourceName: "check"))
    let separator = UIView()
    
    static let reuseIdentifier = "ItemCell"
    public required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        sv(
            visual,
            name,
            dosage,
            hour,
            minutes,
            servingType,
            servingSize,
            takenIndicator,
            separator
        )
        
        |-43-visual.size(56).centerVertically()

        visual-10-name
        name.Top == visual.Top + 9
        
        visual-10-dosage
        dosage.Top == name.Bottom //+ 9
        
        takenIndicator.centerVertically()-23-|
        
        servingType.size(18)
        servingSize.centerVertically()
        align(horizontally: servingType-4-servingSize-26-|)
        
        layout(
            20,
            |-15-hour.width(25),
            -6,
            |-15-minutes.width(25)
        )
//        hour.backgroundColor = .red
        
        servingType.image = #imageLiteral(resourceName: "drop")
        servingType.contentMode = .scaleAspectFit
        
        |-16-separator.height(1)|
        
        separator.backgroundColor = UIColor(red: 229/255.0, green: 229/255.0, blue: 229/255.0, alpha: 1)
        
        visual.style { i in
            i.contentMode = .center
            i.backgroundColor = UIColor(red: 229/255.0, green: 229/255.0, blue: 229/255.0, alpha: 1)
            i.layer.cornerRadius = 4
        }
        name.style { l in
            l.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            l.textColor = .themeDarkColor
        }
        dosage.style { l in
            l.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            l.textColor = UIColor(red: 153/255.0, green: 153/255.0, blue: 153/255.0, alpha: 1)
        }
        servingSize.style { l in
            l.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        }
        hour.style { l in
            l.textAlignment = .center
            l.textColor = .gray
            l.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
            l.textColor = .themeMainColor
        }
        minutes.style { l in
            l.textAlignment = .center
            l.textColor = .gray
            l.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
            l.textColor = .themeMainColor
        }
    }
}
