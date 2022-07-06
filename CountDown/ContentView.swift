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
    @StateObject private var viewModel = DataViewModel.shared
    
    var body: some View {
        TabView(selection: $tabSelection) {
            ListCard(typeSection: .home)
                .tabItem {
                    tabSelection == 0 ? Label("Home", systemImage: "house.fill").environment(\.symbolVariants, .none) : Label("Home", systemImage: "house").environment(\.symbolVariants, .none)
                }
                .tag(0)

            ListCard(typeSection: .preferiti)
                .tabItem {
                    tabSelection == 1 ? Label("Favourites", systemImage: "bookmark.fill").environment(\.symbolVariants, .none) : Label("Favourites", systemImage: "bookmark").environment(\.symbolVariants, .none)
                }
                .tag(1)
            
            ListCard(typeSection: .completati)
                .tabItem {
                    tabSelection == 2 ? Label("Completed", systemImage: "hourglass.bottomhalf.fill").environment(\.symbolVariants, .none) : Label("Completed", systemImage: "hourglass").environment(\.symbolVariants, .none)
                }
                .tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
