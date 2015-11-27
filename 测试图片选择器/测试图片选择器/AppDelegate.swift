//
//  AppDelegate.swift
//  测试图片选择器
//
//  Created by mqy on 15/8/7.
//  Copyright © 2015年 qyma. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.whiteColor()
        window?.rootViewController = QYMPhotoSelectorController()
        window?.makeKeyAndVisible()
        
        
        return true
    }

  }

