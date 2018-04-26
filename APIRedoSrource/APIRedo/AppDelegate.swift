//
//  AppDelegate.swift
//  APIRedo
//
//  Created by Noah_Shan on 2018/4/10.
//  Copyright © 2018年 Inspur. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        NetMoniterCenter.getInstance().startService()
        
        return true
    }


}

