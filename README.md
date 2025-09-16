---
id: iOS_LOD
title: LOD - iOS SDK
---

## v 3.0.0 (released 15-09-2025)


## Support
- The LANDMARKS ID SDK supports iOS 15.6 and above.

## Setup Instructions

### Using CocoaPods
1. If you previously included the SDK manually please delete both `LandmarksIDiOS.framework` and `BDPointSDK.framework` from the project.
2. Include the LandmarksID pod in the Podfile.

```ruby
pod 'LANDMARKSID-LOD-SDK', :git => 'https://github.com/LANDMARKSID/ios-lod-sdk.git', :tag => '3.0.0'
```
3. Run `pod install`.

An example application is available in the Examples folder of the [GitHub repository](https://github.com/LANDMARKSID/ios-lod-sdk).

### Local Installation (Manual Download)

1. Go to the [GitHub releases page](https://github.com/LANDMARKSID/ios-lod-sdk/releases) and download the latest `LandmarksIDiOS.xcframework.zip` file.
2. Extract the zip file to get `LandmarksIDiOS.xcframework`.
3. In Xcode, open your project and navigate to your app target.
4. Go to **Project Navigator** → Select your project → Select your target → **General** tab.
5. Under **Frameworks, Libraries, and Embedded Content**, click the **+** button.
6. Click **Add Other...** → **Add Files...** and select the extracted `LandmarksIDiOS.xcframework`.
7. Ensure the framework is set to **"Embed & Sign"**.

### Swift Package Manager (SPM)

#### Option 1: Using Xcode Package Manager

1. In Xcode, open your project and go to **File** → **Add Package Dependencies**.
2. Enter the following repository URL:
   ```
   https://github.com/LANDMARKSID/ios-lod-sdk.git
   ```
3. Select the latest version available (3.0.0).
4. Click **Add Package** and wait for Xcode to resolve the dependency.
5. Select **LandmarksIDiOS** from the list and click **Add Package**.

**iOS Configuration Information**

  1. Locate the app's `Info.plist` file in the Supporting Files folder of the Xcode project.
  2. Select the file once to display the Key/Value pairs in the editor pane.
  3. Find an existing entry titled 'Required background modes' or create one if it does not exist.
  4. Select the (+) icon and select from the drop-down list provided: App registers for location updates.

**Required background updates description**

Usage description is required to be set in the applications `info.plist` when utilising Location services.
   
  1. Locate the app's `info.plist` file in the Supporting Files folder of the Xcode project.
  2. Select the icon and set the below description values for the application (It is mandatory that all are set).
    - `Privacy - Location Always and When In Use Usage Description`
    - `Privacy - Location Always Usage Description`
    - `Privacy - Location When In Use Usage Description`
     
**Local Notification Permission Prompt**

  The SDK is configured to prompt Local Notification Permissions as default. To disable the notification permission prompt, the following key should be declared in the `info.plist`:

  1. Locate the app’s info.plist file in the Supporting Files folder.
  2. Select the (+) icon to add a new key. BDPointLocalNotificationEnabled, and set the value to Boolean Type.
    - `set the value to YES to enable default notification prompt`
    - `set the value to NO to disable default notification prompt`
    
**Edit the AppDelegate**

1. Import the LANDMARKS ID SDK
    ```swift
    import LandmarksIDiOS
    ```

2. Copy the following snippet into `application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool`
    ```swift
    let appId = "APP_ID"
    let appSecret = "APP_SECRET"
    let apiKey = "API_KEY"
            
    let landmarksManager = LandmarksIDManagerDelegate.initialize(appId, appSecret: appSecret, apiKey: apiKey)
    
    landmarksManager?.setup()
            
    LandmarksIDLocationManager.getInstance().locationDelegate = landmarksManager
    LandmarksIDLocationManager.getInstance().sessionDelegate  = landmarksManager
    ```

**HINT**: Store your secrets safely, like in an `.xcconfig` file, to avoid committing them to the code.


### Required Application State Transition Management

The LANDMARKS ID SDK must be notified when the application is terminated and when there is a transiton between the Foreground / Background

Call the function below inside `applicationWillTerminate(_ application: UIApplication)` when the application is terminated.

```swift
DispatchQueue.global(qos: .utility).async {
  LandmarksIDManagerDelegate.sharedManager().applicationWillTerminate()
}
```

Call the function below inside `applicationDidEnterBackground(_ application: UIApplication)`when the application transitions into the background.

```swift
DispatchQueue.global(qos: .utility).async {
  LandmarksIDManagerDelegate.sharedManager().stopTracking()
}
```

Call the function below inside `applicationWillEnterForeground(_ application: UIApplication)` when the application transitions into the Foreground.

```swift
DispatchQueue.global(qos: .utility).async {
  LandmarksIDManagerDelegate.sharedManager().startTracking()
}
```

## Optional Controls

### Requesting Location Permissions

Call the function below to initiate a user location permissions request via the SDK. It is good practice to set a location usage explaination within the `Info.plist` describing how you intend to use user's location data (Strongly recommended).

```swift
LandmarksIDManagerDelegate.sharedManager().requestLocationPermissions(CLAuthorizationStatus.authorizedAlways)
```

### Controlling User Data Collection

These functions are designed for applications that have controls in place for managing device level data collection. When the `isAllowedToRecordData` function is set to `false` the LANDMARKS ID SDK will not record any data from the device.

- Checking if it is allowed to collect data for the user (Default: `true`).

    ```swift
    LandmarksIDManagerDelegate.sharedManager().isAllowedToRecordData()
    ```
- Stop recording data for the user.

    ```swift
    LandmarksIDManagerDelegate.sharedManager().stopRecordingData()
    ```
- Restart recording data for the user.

    ```swift
    LandmarksIDManagerDelegate.sharedManager().restartRecordingData()
    ```

### Sending Additional Data

User data that is collected by, or made available to, the application can be attach to the LANDMARKS ID SDK session as custom values. These will be recorded by the LANDMARKS ID SDK with each location event. Multiple custom values can be passed into each function.

**Standardised - Functions provisioned for specific user data**

  - Set Clients Customer ID
    ```swift
    LandmarksIDManagerDelegate.sharedManager().customerId = "CUSTOMER_ID"
    ```

**Custom - Functions provisioned for all other non specific user data**

  - Set an integer value
    ```swift
    LandmarksIDManagerDelegate.sharedManager().setCustomInt("rank", value: 12)
    ```

  - Set a float value
    ```swift
    LandmarksIDManagerDelegate.sharedManager().setCustomFloat("score", value: 23.29)
    ```

  - Set a string value
    ```swift
    LandmarksIDManagerDelegate.sharedManager().setCustomString("mobile", value: "123134323432")
    ```

## Contact Details

If you have any further questions please do not hesitate to contact our friendly team at;

developers@landmarksid.com
