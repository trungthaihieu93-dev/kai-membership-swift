//
//  AppsFlyerManagement.swift
//  KAI Membership
//
//  Created by DAKiet on 19/03/2021.
//

import UIKit
import AppsFlyerLib

class AppsFlyerManagement: NSObject {
    
    // MARK: Properties
    static let shared = AppsFlyerManagement()
    
    // MARK: Methods
    func register() {
        AppsFlyerLib.shared().appsFlyerDevKey = "<AF_DEV_KEY>"
        AppsFlyerLib.shared().appleAppID = "<APPLE_APP_ID>"
        AppsFlyerLib.shared().delegate = self
        AppsFlyerLib.shared().isDebug = true
    }
    
    func start() {
        AppsFlyerLib.shared().start()
    }
    
    func handlePushNotification(_ userInfo: [AnyHashable : Any]) {
        AppsFlyerLib.shared().handlePushNotification(userInfo)
    }
    
    func `continue`(_ userActivity: NSUserActivity, restorationHandler: (([Any]?) -> Void)? = nil) {
        AppsFlyerLib.shared().continue(userActivity, restorationHandler: restorationHandler)
    }
    
    func handleOpen(_ url: URL, sourceApplication: String?, withAnnotation annotation: Any? = nil) {
        AppsFlyerLib.shared().handleOpen(url, sourceApplication: sourceApplication, withAnnotation: annotation)
    }
    
    func handleOpen(_ url: URL, options: [AnyHashable : Any]? = nil) {
        AppsFlyerLib.shared().handleOpen(url, options: options)
    }
    
    func logEvent(with name: String, params: [String : Any]? = nil) {
        AppsFlyerLib.shared().logEvent(name, withValues: params)
    }
}

//MARK: AppsFlyerTrackerDelegate
extension AppsFlyerManagement: AppsFlyerLibDelegate {
    
    // Handle Organic/Non-organic installation
    func onConversionDataSuccess(_ installData: [AnyHashable: Any]) {
        print("onConversionDataSuccess data:")
        for (key, value) in installData {
            print(key, ":", value)
        }
        if let status = installData["af_status"] as? String {
            if (status == "Non-organic") {
                if let sourceID = installData["media_source"],
                   let campaign = installData["campaign"] {
                    print("This is a Non-Organic install. Media source: \(sourceID)  Campaign: \(campaign)")
                }
            } else {
                print("This is an organic install.")
            }
            if let is_first_launch = installData["is_first_launch"] as? Bool,
               is_first_launch {
                print("First Launch")
            } else {
                print("Not First Launch")
            }
        }
    }
    
    func onConversionDataFail(_ error: Error) {
        print(error)
    }
    
    //Handle Deep Link
    func onAppOpenAttribution(_ attributionData: [AnyHashable : Any]) {
        //Handle Deep Link Data
        print("onAppOpenAttribution data:")
        for (key, value) in attributionData {
            print(key, ":",value)
        }
    }
    
    func onAppOpenAttributionFailure(_ error: Error) {
        print(error)
    }
}
