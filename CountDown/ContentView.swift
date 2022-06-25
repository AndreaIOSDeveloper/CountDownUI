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
    @State private var selection = 0

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init() { }
    
    var body: some View {
        TabView(selection: $selection) {
            ListCard(isPreferitiSection: false)
                .tabItem {
                    Label("Home", systemImage: "list.dash")
                }
                .tag(0)
                .onAppear() {
                    self.selection = 0
                }
            
            ListCard(isPreferitiSection: true)
                .tabItem {
                    Label("Preferiti", systemImage: "list.dash")
                }
                .tag(1)
                .onAppear() {
                    self.selection = 1
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
