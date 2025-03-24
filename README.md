# Dynamic App Icon

A simple demo project showcasing how to dynamically change your iOS app's icon at runtime.

## ✨ Features
- Easily change the app icon programmatically.
- Supports multiple alternate app icon sets.
- Compatible with iOS 14 and later.

## ✅ Prerequisites
- Xcode 14+
- Swift 5.x
- iOS 14+

## 🚀 Installation

Clone the repository:

```bash
git clone https://github.com/PoemKimlang/DynamicAppIcon.git
```

## 📌 Implementation Steps

### Step 1: Prepare Your Icons

Create your app icons with sizes recommended by Apple:

- Standard App Icon sizes (e.g., 120x120, 180x180).
- Ensure icons are in PNG format and properly named.

**Add your alternate app icons to your asset catalog:**

1. Open `Assets.xcassets`.
2. Click the `+` button and select **New iOS App Icon**.
3. Clearly name each set (e.g., `KhmerNewYearIcon`, `ChristmasAppIcon`).
4. Add icon images to the appropriate sizes.

### Step 2: Update Info.plist

Edit your `Info.plist` with the following:

```xml
<key>CFBundleIcons</key>
<dict>
    <key>CFBundlePrimaryIcon</key>
    <dict>
        <key>CFBundleIconFiles</key>
        <array>
            <string>AppIcon</string>
        </array>
    </dict>
    <key>CFBundleAlternateIcons</key>
    <dict>
        <key>KhmerNewYearIcon</key>
        <dict>
            <key>CFBundleIconFiles</key>
            <array>
                <string>KhmerNewYearIcon</string>
            </array>
        </dict>
        <key>ChristmasAppIcon</key>
        <dict>
            <key>CFBundleIconFiles</key>
            <array>
                <string>ChristmasAppIcon</string>
            </array>
        </dict>
    </dict>
</dict>
```

### Step 3: Change App Icon Programmatically (Swift)

Use this Swift function to switch icons:

```swift
func setAppIcon(to iconName: String?) {
    guard UIApplication.shared.supportsAlternateIcons else { return }

    UIApplication.shared.setAlternateIconName(iconName) { error in
        if let error = error {
            print("❌ Error setting icon: \(error.localizedDescription)")
        } else {
            let icon = iconName ?? "default icon"
            print("🎉 Successfully changed icon to \(icon).")
        }
    }
}
```

#### Usage Example:

To set the icon to `KhmerNewYearIcon`:

```swift
setAppIcon(to: "KhmerNewYearIcon")
```

To revert to the default app icon:

```swift
setAppIcon(to: nil)
```


## 🙋‍♂️ Contributing
Feel free to contribute by creating pull requests or raising issues.

## ✏️ Author
Created by [Poem Kimlang](https://github.com/PoemKimlang).

