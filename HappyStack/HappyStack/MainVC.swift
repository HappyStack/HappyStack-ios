//
//  MainVC.swift
//  HappyStack
//
//  Created by Sacha DSO on 24/03/2018.
//  Copyright © 2018 HappyStack. All rights reserved.
//

import UIKit
import Stevia

class MainView: UIView {
    
    let background = UIImageView(image: #imageLiteral(resourceName: "BG"))
    let pageControl = UIPageControl()
    let scrollView = UIScrollView()

    convenience init() {
        self.init(frame: CGRect.zero)
    
        sv(
            background,
            pageControl,
            scrollView
        )
        
        background.fillContainer()
        
        layout(
            0,
            |scrollView|,
            0
        )
    
        |pageControl|.bottom(20)

        pageControl.numberOfPages = 2
        
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
    }
}

class MainVC: UIViewController {
    
    var v = MainView()
    var stackVC: StackVC!
    let newSupplementVC = NewSupplementVC()
    
    override func loadView() { view = v }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackVC = StackVC(stack: User.current!.stack)
        
        
        build()
        on("INJECTION_BUNDLE_NOTIFICATION") {
            self.view = MainView()
            self.build()
        }
    }
    
    func build() {
        addChildViewController(stackVC)
        addChildViewController(newSupplementVC)
        v.scrollView.sv(
            stackVC.view,
            newSupplementVC.view
        )
        
        stackVC.view.Width == view.Width
        newSupplementVC.view.Width == view.Width
        
        |stackVC.view-0-newSupplementVC.view|
        
        stackVC.view.Top == view.safeAreaLayoutGuide.Top
        stackVC.view.Bottom == view.safeAreaLayoutGuide.Bottom
        newSupplementVC.view.Top == view.safeAreaLayoutGuide.Top
        newSupplementVC.view.Bottom == view.safeAreaLayoutGuide.Bottom
    }
}

