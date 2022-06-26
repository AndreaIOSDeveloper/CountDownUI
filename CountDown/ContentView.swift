//
//  ContentView.swift
//  CountDown
//
//  Created by Andrea Di Francia on 15/06/22.
//

import SwiftUI
import UIKit
import Foundation

struct ContentView: View {
    @State private var tabSelection = 0

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        TabView(selection: $tabSelection) {
            ListCard(isPreferitiSection: false)
                .tabItem {
                    tabSelection == 0 ? Label("Home", systemImage: "house.fill").environment(\.symbolVariants, .none) : Label("Home", systemImage: "house").environment(\.symbolVariants, .none)
                }
                .tag(0)

            ListCard(isPreferitiSection: true)
                .tabItem {
                    tabSelection == 1 ? Label("Preferiti", systemImage: "bookmark.fill").environment(\.symbolVariants, .none) : Label("Preferiti", systemImage: "bookmark").environment(\.symbolVariants, .none)
                }
                .tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
