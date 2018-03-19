//
//  NewSupplementVC.swift
//  HappyStack
//
//  Created by Sacha DSO on 19/03/2018.
//  Copyright © 2018 HappyStack. All rights reserved.
//

import UIKit

class NewSupplementVC: UIViewController {
    
    var v = NewSupplementView()
    override func loadView() { view = v }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        on("INJECTION_BUNDLE_NOTIFICATION") {
            self.view = NewSupplementView()
        }
    }
}
