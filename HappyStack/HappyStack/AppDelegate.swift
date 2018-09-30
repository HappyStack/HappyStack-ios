//
//  AppDelegate.swift
//  HappyStack
//
//  Created by Sacha DSO on 09/11/2017.
//  Copyright © 2017 HappyStack. All rights reserved.
//

import UIKit

// Inject the api we want here.
extension ApiProvider {
    static func api() -> Api {
        return GoApi.shared// LocalApi.shared
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        sytleNavBar()
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // Fake user
        let user = User()
        user.identifier = 1
        User.current = user

        if let user = User.current {
            startLoggedInApp(user: user)
        } else {
            let loginVC = LoginVC()
            loginVC.delegate = self
            window?.rootViewController = HSNAvigationController(rootViewController: loginVC)
        }
        
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
        
        
        window?.makeKeyAndVisible()
        return true
    }
    
    func startLoggedInApp(user: User) {
        window?.rootViewController = StackVC(stack: user.stack)
    }
    
    func sytleNavBar() {
        let navbarTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
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

