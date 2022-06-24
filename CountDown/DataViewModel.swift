//
//  DataViewModel.swift
//  CountDown
//
//  Created by Andrea Di Francia on 15/06/22.
//

import Foundation
import SwiftUI

struct CountDownObject: Identifiable, Equatable {
    var id: String
    var title: String
    var subTitle: String
    var colorCard: Color
    var isConfirmed: Bool = false
    
    var futureDate: Date
    
    @State var countdown: DateComponents?
    
    // var countdown: DateComponents {
    //     return Calendar.current.dateComponents([.day, .hour, .minute, .second], from: Date(), to: futureDate)
    // }
    
    var timer: TimeCard? {
         var timer = TimeCard(years: countdown?.year ?? 0,
                              months: countdown?.month ?? 0,
                              days: countdown?.day ?? 0,
                              hours: countdown?.hour ?? 0,
                              mins: countdown?.minute ?? 0,
                              secs: countdown?.second ?? 0)
         return timer
     }

    var isFinished: Bool {
        if timer?.days == 0, timer?.hours == 0, timer?.mins == 0, timer?.secs == 0 {
            return true
        } else {
            return false
        }
    }
    
    init(id: String, title: String, subTitle: String, colorCard: Color, isConfirmed: Bool, futureDate: Date) {
        self.id = id
        self.title = title
        self.subTitle = subTitle
        self.colorCard = colorCard
        self.isConfirmed = isConfirmed
        self.futureDate = futureDate
    }
    
    public static func == (lhs: CountDownObject, rhs: CountDownObject) -> Bool {
        lhs.id == rhs.id
    }
}

class CountDownPublisher: ObservableObject {
    @Published var items: [CountDownObject] = [CountDownObject(id: "1", title: "STRANGE THINGS", subTitle: "SEASON 4 VOLUME 2 RELEASE DATA", colorCard: .red, isConfirmed: false, futureDate: Calendar.current.date(from: DateComponents(year: 2022, month: 11, day: 30, hour: 0, minute: 0, second: 0))!),
        CountDownObject(id: "2", title: "TRAVEL", subTitle: "GO TO IBIZA", colorCard: .red, isConfirmed: false, futureDate: Calendar.current.date(from: DateComponents(year: 2022, month: 06, day: 29, hour: 18, minute: 0, second: 0))!),
        CountDownObject(id: "3", title: "BETTER CALL SAUL", subTitle: "SEASON 6 VOLUME 2 RELEASE DATA", colorCard:  .red, isConfirmed: false, futureDate: Calendar.current.date(from: DateComponents(year: 2023, month: 11, day: 27, hour: 0, minute: 0, second: 0))!),
        CountDownObject(id: "4", title: "SQUID GAME", subTitle: "SEASON 6 VOLUME 2 RELEASE DATA", colorCard: .red, isConfirmed: false, futureDate: Calendar.current.date(from: DateComponents(year: 2022, month: 11, day: 27, hour: 0, minute: 0, second: 0))!)]
}

class DataViewModel: ObservableObject {
    @Published var listCountDownObject = CountDownPublisher()
    
    init() { }

    func updateTime() {
         listCountDownObject.items.forEach {
             $0.countdown = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: Date(), to: $0.futureDate)
//             $0.timer = TimeCard(years: $0.countdown?.year ?? 0,
//                                 months: $0.countdown?.month ?? 0,
//                                 days: $0.countdown?.day ?? 0,
//                                 hours: $0.countdown?.hour ?? 0,
//                                 mins: $0.countdown?.minute ?? 0,
//                                 secs: $0.countdown?.second ?? 0)
         }        
    }
}


