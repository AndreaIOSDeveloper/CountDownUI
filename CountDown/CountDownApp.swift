//
//  CountDownApp.swift
//  CountDown
//
//  Created by Andrea Di Francia on 15/06/22.
//

import SwiftUI

@main
struct CountDownApp: App {
    @StateObject private var viewModel = DataViewModel.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear() {
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                        if success {
                            print("✅ Permission ok for notification")
                        } else if let error = error {
                            print("❌ No Permission for notification")
                            print(error.localizedDescription)
                        }
                    }
                    
                    viewModel.receiceCountDown()
                }
        }
    }
}
