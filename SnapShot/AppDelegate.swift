//
//  AppDelegate.swift
//  SnapShot
//
//  Created by Jacob Li on 09/10/2015.
//  Copyright © 2015 Jacob Li. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
import PKRevealController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, SnapShotEngineProtocol, CLLocationManagerDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController?
    var revealController: PKRevealController?
    var frontViewController: FrontViewController?
    var leftViewController: LeftViewController?
    var searchViewController: SearchViewController?
    var locationManager:CLLocationManager = CLLocationManager()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.

        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent        
        NSThread .sleepForTimeInterval(1)
        self.frontViewController = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("frontViewController") as? FrontViewController
         self.leftViewController = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("leftViewController") as? LeftViewController
        self.revealController = PKRevealController.init(frontViewController: frontViewController, leftViewController: leftViewController)
        self.revealController!.setMinimumWidth(220.0, maximumWidth: 240.0, forViewController: leftViewController)
        self.revealController!.recognizesPanningOnFrontView = true
        self.revealController!.title = "咔嚓"
        self.revealController?.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: "popToSearchView")
        self.navigationController = UINavigationController()
        self.window?.rootViewController = self.initNavigationController()
        self.navigationController!.pushViewController(revealController!, animated: false)
        
        
        
        return true
    }
    
    func locationAuthenticate() {
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if (ToolKit.iOS8()){
            self.locationManager.requestAlwaysAuthorization()
        }

    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case CLAuthorizationStatus.NotDetermined:
            if self.locationManager.respondsToSelector("requestAlwaysAuthorization") {
                self.locationManager.requestWhenInUseAuthorization()
            }
        default:
            break
        }
        
    }

    func initNavigationController()-> UINavigationController {
        self.navigationController = nil
        self.navigationController = UINavigationController()
        
        self.navigationController?.navigationBar.barTintColor = NAVIGATION_BAR_COLOR_GREY
        let titleShadow: NSShadow = NSShadow()
        titleShadow.shadowColor = UIColor(red: 218/255, green: 147/255, blue: 171/255, alpha: 1)
        titleShadow.shadowOffset = CGSizeMake(0, 0)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor(), NSFontAttributeName:UIFont(name: HEITI, size: TITLE_FONT_SIZE)!, NSShadowAttributeName:titleShadow]
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        return self.navigationController!
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "Jacob.SnapShot" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("SnapShot", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason

            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    func leftViewShowAction() {
        self.revealController?.showViewController(self.leftViewController)
    }

    func popToSearchView() {
        self.searchViewController = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()).instantiateViewControllerWithIdentifier("searchViewController") as? SearchViewController
        self.navigationController?.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(searchViewController!, animated: true)
    }
    
    func onTaskError(taskType: Int!, errorCode: Int, extraData: AnyObject) {
        print("onTaskError")
    }
    func onTaskSuccess(taskType: Int!, successCode: Int, extraData: AnyObject) {
        print("onTaskSuccess")
    }
}

