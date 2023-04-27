# IOS-Swift-Code-Standard-Demo

## Structure
After many iterations and a little bit of though, here's a general overview of how I usually organize my projects' file hierarchy:
* **Appdelegate** - Contain Appdelete File
* **Auth** - Contain Model, View, ViewModel Folders related to Auth
  * **Model** - All models related to Auth (server-side entities' representation). Use codable model class.
  * **View** - StoryBoard and controller folder releated Auth
    * **StoryBoard** - Storyboard related to Auth
    * **Auth** - ViewController related to Auth
  * **ViewModel** - ViewModel folder
    * **ViewModel** - All ViewModel Files and logic related to Auth
* **Others** - Contain APIManager, Helper, Extention and related Logic
  * **Extentions** - All types of extention like UIView, String, Bundle, UIViewController etc.
  * **Helper** - Repeated usefull logic like Network Handler, UserDefault, object of all StoryBoard, Constant message, Static color etc.
  * **APIManager** - Common class for handle all types of api like POST, GET, PUT etc. WebURL class for add all api constant endpoint. Common api model for handle all api response.
* **Resources** - Any additionaly resources like media, documents, localization files and such

## Result
At the end it ends up looking something like this:

![Xcode Screenshot](https://github.com/MoonTechnolabs/IOS-Swift-Code-Standard-Demo/blob/main/readmeAssets/file.png "Xcode side bar screenshot")

# Naming Conventions
## Class Names:
**App prefix + Camel case description**

* Start class names with the app prefix
* Class names should be as descriptive as possible, avoid shorthand and abbreviations
* If subclassing, make it obvious by using the superclasses name in the new name

## Variable
**Lower-case identifier + Camel case description**

The lower-case identifier prefixes are designed to provide information, or metadata, about the variable. This helps with debugging and general readability by removing any ambiguity about the origin of the variable or the intended use of the variable.
 
## Methods and Functions

Method names start with a lower case letter followed by camel casing:

```
func initWithFrame(frame:CGRect)
func selectedItems(arr: [String])
```

## Reduce the use of Forced Unwrapping ("!")
Wrong:
```
let obj = ModelUser()
let str = obj.Username!
```
Correct:
```
let obj = ModelUser()
let str = obj.Username ?? ""

      OR
      
 if let str = obj.Username as? String {
 }
```
## Info.plist Permission

* **NSPhotoLibraryAddUsageDescription:** Your app adds photos to the user's photo library
```
<key>NSPhotoLibraryAddUsageDescription</key>
<string>Example: You should fill this in</string>
```

* **NSPhotoLibraryUsageDescription:** Your app accesses the user's photo library
```
<key>NSPhotoLibraryUsageDescription</key>
<string>Example: You should fill this in</string>
```

* **NSCameraUsageDescription:** Your app uses the device camera
```
<key>NSCameraUsageDescription</key>
<string>Example: You should fill this in</string>
```

* **NSLocationAlwaysUsageDescription:** Your app uses location services all the time
```
<key>NSLocationAlwaysUsageDescription</key>
<string>Example: You should fill this in</string>
```

* **NSLocationWhenInUseUsageDescription:** 	Your app uses location services only when the app is running
```
<key>NSLocationWhenInUseUsageDescription</key>
<string>Example: You should fill this in</string>
```

* **NSMicrophoneUsageDescription	:** Your app uses the device microphone
```
<key>NSMicrophoneUsageDescription</key>
<string>Example: You should fill this in</string>
```

* **NSFaceIDUsageDescription	:** Your app uses FaceID
```
<key>NSFaceIDUsageDescription</key>
<string>Example: You should fill this in</string>
```

* **NFCReaderUsageDescription	:** Your app uses the NFC reader
```
<key>NFCReaderUsageDescription</key>
<string>Example: You should fill this in</string>
```

* **NSContactsUsageDescription	:** Your app uses the address book
```
<key>NSContactsUsageDescription</key>
<string>Example: You should fill this in</string>
```

## Don’t Repeat Yourself
Every piece of knowledge must have a single, unambiguous, authoritative representation within a system.

You can imagine that, if you’ve written the same code in two places, maintaining and updating that code takes more time and effort than it would have if you had coded it once.

Imagine you’re building your app’s User Interface (UI) with Swift code. You want to add 3 buttons to the view. Once you coded one button, you copied that code and used it as a prototype for the other two buttons.

You end up with something like this:

```
let button1 = UIButton(type: .custom)
button1.setTitle(“Log In”, for: .normal)
button1.addTarget(self, action: #selector(onLoginButtonTapped(_:)), for: .touchUpInside)

let button2 = UIButton(type: .custom)
button2.setTitle(“Sign Up”, for: .normal)
button2.addTarget(self, action: #selector(onSignupButtonTapped(_:)), for: .touchUpInside)

let button3 = UIButton(type: .custom)
button3.setTitle(“Log In With Facebook”, for: .normal)
button3.addTarget(self, action: #selector(onLoginFacebookButtonTapped(_:)), for: .touchUpInside)
```

See what’s going on here? We’ve created 3 buttons, but 90% of code is the same. Moreover, we also have 3 functions (for the actions) that probably share a fair amount of business logic.

How can we improve the code? Here’s an idea:

  ```
  let buttons = [“Log In”, “Sign Up”, “Log In With Facebook”]

  for title in buttons
  {
  let button = UIButton(type: .custom)
  button.setTitle(title, for: .normal)
  button.addTarget(self, action: #selector(onButtonTapped(_:)), for: .touchUpInside)

  view.addSubview(button)
  }
```

You could call the above for loop a generator. Instead of hard-coding the 3 buttons, you use a data structure and iterate over it to generate the 3 buttons.

## Basic Rules
* Make clean code to understand better.
* Remove unnecessary code.
* Add comment in each complex logic.
* Add mark in every section like custom function, Click event etc.
* Use extention for make a seperate and clean code.
* Use multiple file instead of write lot's of line code in the same file.
