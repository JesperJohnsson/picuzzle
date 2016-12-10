//
//  AppDelegate.swift
//  picuzzle
//
//  Created by Jesper Johnsson on 2016-11-17.
//  Copyright © 2016 Jesper Johnsson. All rights reserved.
//

import UIKit
import CoreData
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
        let pageController = UIPageControl.appearance()
        pageController.pageIndicatorTintColor = UIColor.lightGray
        pageController.currentPageIndicatorTintColor = BG_ORANGE
        //pageController.backgroundColor = UIColor.red
        
        let titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        let titleTextAttributes2 = [NSForegroundColorAttributeName: UIColor.black]
        UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributes, for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes(titleTextAttributes2, for: .normal)

        FIRApp.configure()
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
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Picuzzle")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                
                fatalError("Unresolved error \(error))")
            }
        })
        return container
    }()
    
    //@TODO Not have fatalError in a shipping application...
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror)")
            }
        }
    }
}
let BG_GRAY = UIColor(red: 239.0 / 255, green: 239.0 / 255, blue: 239.0 / 255, alpha: 1.0)
let BG_ORANGE = UIColor(red: 244.0 / 255, green: 109.0 / 255, blue: 41.0 / 255, alpha: 1.0)
let BG_YELLOW = UIColor(red: 246.0 / 255, green: 219.0 / 255, blue: 124.0 / 255, alpha: 1.0)
let BG_BLUE = UIColor(red: 13, green: 49, blue: 64, alpha: 1.0)
let turkey = UIColor(red: 74.0, green: 195.0, blue: 201.0, alpha: 1.0)


let ad = UIApplication.shared.delegate as! AppDelegate
let context = ad.persistentContainer.viewContext
