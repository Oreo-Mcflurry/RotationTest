//
//  ContentView.swift
//  RotationTest
//
//  Created by Musk on 9/9/24.
//

import SwiftUI

final class RotationPermissionController: ObservableObject {
    static let shared = RotationPermissionController()
    
    @Published var isRotationAllowed: Bool = false {
        didSet {
            if isRotationAllowed {
                UIDevice.current.setValue(UIInterfaceOrientation.unknown.rawValue, forKey: "orientation")
            } else {
                UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
            }
            UIViewController.attemptRotationToDeviceOrientation()
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return RotationPermissionController.shared.isRotationAllowed ? .allButUpsideDown : .portrait
    }
}

struct ContentView: View {
    @StateObject private var rotationController = RotationPermissionController.shared
    
    var body: some View {
        NavigationView {
            VStack {
                Text("현재 회전 허용 상태: \(rotationController.isRotationAllowed ? "허용" : "금지")")
                
                Button(rotationController.isRotationAllowed ? "회전 금지" : "회전 허용") {
                    rotationController.isRotationAllowed.toggle()
                }
                
                NavigationLink("다른 뷰로 이동", destination: OtherView())
            }
        }
    }
}

struct OtherView: View {
    @StateObject private var rotationController = RotationPermissionController.shared
    
    var body: some View {
        VStack {
            Text("다른 뷰")
            Text("현재 회전 허용 상태: \(rotationController.isRotationAllowed ? "허용" : "금지")")
        }
        .onAppear {
            // 이 뷰에서 회전을 허용하고 싶다면:
            // rotationController.isRotationAllowed = true
        }
        .onDisappear {
            // 이 뷰를 나갈 때 회전을 다시 금지하고 싶다면:
            // rotationController.isRotationAllowed = false
        }
    }
}
