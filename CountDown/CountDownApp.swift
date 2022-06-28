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
                    viewModel.receiceCountDown()
                }
        }
    }
}
