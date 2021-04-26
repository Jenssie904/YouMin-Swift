//
//  AppDelegate.swift
//  BibleColor_MVVM
//
//  Created by admin on 2021/4/6.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    public var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = YMTabBarController()
        window?.makeKeyAndVisible()
        return true
    }

}

