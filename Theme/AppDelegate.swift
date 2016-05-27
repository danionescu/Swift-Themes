//
//  AppDelegate.swift
//  Theme
//
//  Created by Dan Ionescu on 25/05/16.
//  Copyright © 2016 Alt Tab. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        ThemeManager.theme.themeApplication()
        return true
    }

}

