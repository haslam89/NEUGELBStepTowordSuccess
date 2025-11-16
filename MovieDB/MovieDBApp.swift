//
//  MovieDBApp.swift
//  MovieDB
//
//  Created by Hassan Jaffri on 13/11/2025.
//

import SwiftUI

@main
struct MovieDBApp: App {
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
        }
        .onChange(of: scenePhase) { newPhase in
                        switch newPhase {
                        case .active:
                            print("App is active")
                            // Handle when app becomes active
                        case .inactive:
                            print("App is inactive")
                        case .background:
                            print("App is in background")
                        @unknown default:
                            print("Unexpected new scene phase")
                        }
                    }
    }
}

