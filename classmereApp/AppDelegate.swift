//
//  AppDelegate.swift
//  classmereApp
//
//  Created by Brandon Lee on 8/25/15.
//  Copyright (c) 2015 Brandon Lee. All rights reserved.
//

import UIKit

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?

    func application(application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

            let viewController = TodayTableViewController()
            let navigationController = UINavigationController(rootViewController: viewController)
            viewController.view.backgroundColor = UIColor.purpleColor()
            
            window = UIWindow(frame: UIScreen.mainScreen().bounds)
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()

            return true
    }
}
