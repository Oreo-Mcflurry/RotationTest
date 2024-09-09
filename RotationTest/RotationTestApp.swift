//
//  RotationTestApp.swift
//  RotationTest
//
//  Created by Musk on 9/9/24.
//

import SwiftUI

@main
struct MyApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var rotationController = RotationPermissionController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
