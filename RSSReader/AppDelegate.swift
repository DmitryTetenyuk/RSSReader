//
//  AppDelegate.swift
//  RSSReader
//
//  Created by Admin on 23.11.17.
//  Copyright © 2017 Admin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let appContainer = AppContainer()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let newsViewController = self.window?.rootViewController as? NewsViewController
        newsViewController?.setNewsViewModel(viewModel: appContainer.getNewsViewModel())
        // Override point for customization after application launch.
        return true
    }

}

