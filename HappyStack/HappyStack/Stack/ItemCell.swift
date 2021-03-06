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
    
    let name = UILabel()
    let time = UILabel()
    
    static let reuseIdentifier = "ItemCell"
    public required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        sv(
            name,
            time
        )
        
        name.centerVertically()
        alignHorizontally(|-16-name-(<=16)-time-16-|)
        
        accessoryType = .disclosureIndicator
        time.style { l in
            l.textAlignment = .right
            l.textColor = .gray
        }
    }
}
