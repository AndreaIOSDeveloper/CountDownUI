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
    @State private var viewModel = DataViewModel()
    @State private var selection = 0
    @State private var currentTab = 0
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init() { }
    
    var body: some View {
        TabView(selection: $selection) {
            ListCard(data: $viewModel, model: viewModel, isPreferitiSection: false)
                .tabItem {
                    Label("Home", systemImage: "list.dash")
                }
                .tag(0)
                .onAppear() {
                    viewModel.listCountDownObject.items.forEach { item in
                        debugPrint("SEZIONE HOME: \(item)")
                    }
                    self.currentTab = 0
                }
            
            ListCard(data: $viewModel, model: viewModel, isPreferitiSection: true)
                .tabItem {
                    Label("Preferiti", systemImage: "list.dash")
                }
                .tag(1)
                .onAppear() {
                    viewModel.listCountDownObject.items.forEach { item in
                        debugPrint("SEZIONE PREFERITI: \(item)")
                    }
                    
                    self.currentTab = 1
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
