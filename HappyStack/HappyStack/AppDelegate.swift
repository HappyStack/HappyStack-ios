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
        
        if let user = User.current {
            startLoggedInApp(user: user)
        } else {

            let loginVC = LoginVC()
            loginVC.delegate = self
            window?.rootViewController = UINavigationController(rootViewController: loginVC)
        }
        
        window?.makeKeyAndVisible()
        return true
    }
    
    func startLoggedInApp(user: User) {
        let stackVC = StackVC(stack: user.stack)
        window?.rootViewController = UINavigationController(rootViewController: stackVC)
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

