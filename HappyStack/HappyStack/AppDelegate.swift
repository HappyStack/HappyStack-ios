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
        
        // Fake login
        let stack = User.current.stack
        let stackVC = StackVC(stack: stack)
        window?.rootViewController = UINavigationController(rootViewController: stackVC)
        window?.makeKeyAndVisible()
        return true
    }
    
    func sytleNavBar() {
        let navbarTitleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        UINavigationBar.appearance().barTintColor = UIColor.black
        UINavigationBar.appearance().titleTextAttributes = navbarTitleTextAttributes
        UINavigationBar.appearance().tintColor = UIColor.white
    }
}

