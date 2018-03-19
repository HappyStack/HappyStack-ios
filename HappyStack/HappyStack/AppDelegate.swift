//
//  AppDelegate.swift
//  HappyStack
//
//  Created by Sacha DSO on 09/11/2017.
//  Copyright © 2017 HappyStack. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        sytleNavBar()
        window = UIWindow(frame: UIScreen.main.bounds)
        
        
        User.current = User()
        startLoggedInApp(user: User.current!)
//        if let user = User.current {
//            
//        } else {
//
//            let loginVC = LoginVC()
//            loginVC.delegate = self
//            window?.rootViewController = HSNAvigationController(rootViewController: loginVC)
//        }
        
//        var vitaminD = Item(identifier: "gv3rf3",
//                        name: "Vitamin D3",
//                        dosage: "5000 UI",
//                        time: Date(),
//                        isChecked: true)
//
//        vitaminD.serving = .pill
//        vitaminD.servingSize = 1
//
//
//        var whey = Item(identifier: "gv3f3",
//                            name: "Whey",
//                            dosage: "30g",
//                            time: Date(),
//                            isChecked: true)
//        whey.serving = .scoop
        
       window?.rootViewController = NewSupplementVC()
        
        window?.makeKeyAndVisible()
        return true
    }
    
    func startLoggedInApp(user: User) {
        let stackVC = StackVC(stack: user.stack)
        window?.rootViewController = HSNAvigationController(rootViewController: stackVC)
    }
    
    func sytleNavBar() {
        let navbarTitleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        UINavigationBar.appearance().barTintColor = UIColor.black
        UINavigationBar.appearance().titleTextAttributes = navbarTitleTextAttributes
        UINavigationBar.appearance().tintColor = UIColor.white
    }
}

extension AppDelegate: LoginVCDelegate {

    func loginVCDidLogin(user: User) {
        startLoggedInApp(user: user)
    }
}

class HSNAvigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
}

