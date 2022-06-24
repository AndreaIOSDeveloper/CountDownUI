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
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init() {
  
    }
    
    var body: some View {
        TabView {
            ListCard()
                .tabItem {
                    Label("Home", systemImage: "list.dash")
                }
            
            ListCard(colorCard: .orange)
                .tabItem {
                    Label("Preferiti", systemImage: "list.dash")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
