import UIKit
import LandmarksIDiOS
#if DEBUG
import FLEX
#endif

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate { 
    
    var window: UIWindow?
    var landmarksIdManager: LandmarksIDManagerDelegate?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        #if DEBUG
        FLEXManager.shared.isNetworkDebuggingEnabled = true
        #endif

        guard let appId = Bundle.main.object(forInfoDictionaryKey: "LANDMARKS_ID_SDK_APP_ID") as? String else {
            fatalError("Error: 'LANDMARKS_ID_SDK_APP_ID' not found or not a String in Info.plist")
        }

        guard let appSecret = Bundle.main.object(forInfoDictionaryKey: "LANDMARKS_ID_APP_SECRET") as? String else {
            fatalError("Error: 'LANDMARKS_ID_APP_SECRET' not found or not a String in Info.plist")
        }
        
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "LANDMARKS_ID_SDK_APP_KEY") as? String else {
            fatalError("Error: 'LANDMARKS_ID_SDK_APP_KEY' not found or not a String in Info.plist")
        }
                               
        landmarksIdManager = LandmarksIDManagerDelegate.initialize(appId, appSecret: appSecret, apiKey: apiKey)
        // Set debug to true if using staging credentials
        landmarksIdManager?.debug = true
        landmarksIdManager?.setup()
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        DispatchQueue.global(qos: .utility).async {
            LandmarksIDManagerDelegate.sharedManager().stopTracking()
        }
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        DispatchQueue.global(qos: .utility).async {
            LandmarksIDManagerDelegate.sharedManager().startTracking()
        }
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        DispatchQueue.global(qos: .utility).async {
            LandmarksIDManagerDelegate.sharedManager().applicationWillTerminate()
        }
    }
}

