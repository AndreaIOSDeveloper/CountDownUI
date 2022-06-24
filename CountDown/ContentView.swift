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
    @State var datacount: String = ""
    
    let futureDate: Date = {
           var future = DateComponents(
               year: 2022,
               month: 11,
               day: 27,
               hour: 0,
               minute: 0,
               second: 0
           )
           return Calendar.current.date(from: future)!
       }()
    
    var countdown: DateComponents {
        return Calendar.current.dateComponents([.day, .hour, .minute, .second], from: Date(), to: futureDate)
    }
    
    init() {
  
    }
    
    var body: some View {
        TabView {
//            Text("\(datacount)")
//                .onReceive(timer) { input in
//                    updateTime()
//                }
            
            ListCard()
                .tabItem {
                    Label("Preferiti", systemImage: "list.dash")
                }
            
            ListCard(colorCard: .orange)
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
        }
    }
    
//    func runCountdown() {
//        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
//    }
    
    func updateTime() {
        let countdown = self.countdown //only compute once per call
        let days = countdown.day!
        let hours = countdown.hour!
        let minutes = countdown.minute!
        let seconds = countdown.second!
        datacount = String(format: "Giorni: %02d ORE: %02d MINUTI: %02d SECONDI: %02d", days, hours, minutes, seconds)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
