//
//  AlarmApp_jan2025App.swift
//  AlarmApp-jan2025
//
//  Created by mac on 28/01/25.
//

import SwiftUI

// MARK: - Main App Structure
@main
struct AlarmApp: App {
    init() {
        // Request Notification Permission
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { success, error in
            if success {
                print("Notification access granted")
            } else {
                print("Notification access denied")
            }
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

