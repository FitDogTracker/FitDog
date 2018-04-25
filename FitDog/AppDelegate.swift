//
//  AppDelegate.swift
//  FitDog
//
//  Created by Kristine Laranjo on 2/24/18.
//  Copyright © 2018 Kristine Laranjo. All rights reserved.
//

import UIKit
import Parse
import CoreLocation
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        Parse.initialize(
            with: ParseClientConfiguration(block: { (configuration: ParseMutableClientConfiguration) -> Void in
                configuration.applicationId = "FitDog"
                configuration.clientKey = "csumb123"  // set to nil assuming you have not set clientKey
                configuration.server = "https://fit-dog.herokuapp.com/parse"
            }))
        
        //ask for permission to access location
        DistanceTracker.shared.locationManager.requestWhenInUseAuthorization()
        
        PFUser.enableAutomaticUser()
        PFUser.current()!.saveInBackground()
        let dogs = PFUser.current()?.value(forKey: "dogs") as? [Dog]
        
        if( dogs != nil  && (dogs!.count > 0)){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            //View controller currently being set in the Storyboard as default will be overridden
            window?.rootViewController = storyboard.instantiateViewController(withIdentifier: "HomeNavigationController")
        }
        let navigation = UINavigationBar.appearance()
        navigation.tintColor = UIColor(hexString: "#4d2600ff")
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

