//
//  ViewController.swift
//  DynamicIcon
//
//  Created by Poem Kimlang on 1/3/25.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var blankViewControllerTransitioningDelegate = BlankViewControllerTransitioningDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.checkAndUpdateAppIcon()
        }
    }
    
    // MARK: - Manual Icon Change Actions
    
    @IBAction func christmasAction(_ sender: Any) {
        setAppIcon(to: "ChristmasAppIcon")
    }
    
    @IBAction func khmerAction(_ sender: Any) {
        setAppIcon(to: "KhmerNewYearIcon")
    }
    
    @IBAction func defaultAction(_ sender: Any) {
        setAppIcon(to: nil)
    }
    
    /// Changes the app icon manually.
    /// - Parameter iconName: Name of the icon to switch to. Pass nil for default.
    func setAppIcon(to iconName: String?) {
        guard #available(iOS 10.3, *), UIApplication.shared.supportsAlternateIcons else {
            print("⚠️ Alternate icons are not supported on this device.")
            return
        }
        
        guard UIApplication.shared.alternateIconName != iconName else {
            print("✅ App icon already set to \(iconName ?? "default").")
            return
        }
        
        print("🔄 Attempting to change icon to: \(iconName ?? "Default")")
        
        UIApplication.shared.setAlternateIconName(iconName) { error in
            if let error = error {
                print("❌ Error setting icon: \(error.localizedDescription)")
            } else {
                print("🎉 Successfully changed icon to \(iconName ?? "default").")
            }
        }
    }
}

// MARK: - Dynamic Icon Management
extension ViewController {
    
    /// Checks current date and updates app icon accordingly.
    func checkAndUpdateAppIcon() {
        let today = Date()
        var targetIcon: String? = nil
        
        if isKhmerNewYear(today) {
            targetIcon = "KhmerNewYearIcon"
            print("📅 Today is Khmer New Year (April 1-20)")
        } else if isChristmas(today) {
            targetIcon = "ChristmasAppIcon"
            print("📅 Today is Christmas (December 20-30)")
        } else {
            print("📅 Today is NOT a special event. Using default icon.")
        }
        
        if UIApplication.shared.alternateIconName != targetIcon {
            setDynamicAppIcon(to: targetIcon)
        } else {
            print("✅ App icon already matches the current event.")
        }
    }
    
    /// Sets app icon dynamically based on date.
    /// - Parameter iconName: Desired icon name based on date/event.
    private func setDynamicAppIcon(to iconName: String?) {
        // Check if the device supports alternate icons (iOS 10.3+).
        guard #available(iOS 10.3, *),
              UIApplication.shared.supportsAlternateIcons else {
            print("⚠️ Alternate icons not supported on this device.")
            return
        }
        
        // Avoid changing the icon if it's already set to the desired value.
        if UIApplication.shared.alternateIconName == iconName {
            print("✅ App icon is already set to \(iconName ?? "default"), no change needed.")
            return
        }
        
        if UIApplication.shared.supportsAlternateIcons {
            // Create a blank view controller to avoid showing the alert popup.
            let blankViewController = UIViewController()
            blankViewController.modalPresentationStyle = .custom
            blankViewController.transitioningDelegate = blankViewControllerTransitioningDelegate
            
            present(blankViewController, animated: false, completion: { [weak self] in
                UIApplication.shared.setAlternateIconName(iconName) { error in
                    if let error = error {
                        print("❌ Error setting icon: \(error.localizedDescription)")
                    } else {
                        print("🎉 Successfully changed icon to \(iconName ?? "default").")
                    }
                }
                self?.dismiss(animated: false, completion: nil)
            })
        }
    }
    
    /// Determines if today's date falls within Khmer New Year.
    /// - Parameter date: Date to evaluate.
    private func isKhmerNewYear(_ date: Date) -> Bool {
        let components = Calendar.current.dateComponents([.month, .day], from: date)
        guard let month = components.month, let day = components.day else { return false }
        return month == 4 && day >= 1 && day <= 20
    }
    
    /// Determines if today's date falls within Christmas.
    /// - Parameter date: Date to evaluate.
    private func isChristmas(_ date: Date) -> Bool {
        let components = Calendar.current.dateComponents([.month, .day], from: date)
        guard let month = components.month, let day = components.day else { return false }
        return month == 12 && day >= 20 && day <= 30
    }
}
