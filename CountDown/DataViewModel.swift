//
//  DataViewModel.swift
//  CountDown
//
//  Created by Andrea Di Francia on 15/06/22.
//

import Foundation
import SwiftUI

struct CountDownObject: Identifiable, Equatable, Hashable {
    var id: String
    var title: String
    var subTitle: String
    var colorCard: Color
    var isConfirmed: Bool = false
    var isPrefered: Bool
    var futureDate: Date
    
    var countdown: DateComponents {
        return Calendar.current.dateComponents([.day, .hour, .minute, .second], from: Date(), to: futureDate)
    }

    var timer: TimeCard {
        return TimeCard(years: countdown.year ?? 0,
                                months: countdown.month ?? 0,
                                days: countdown.day ?? 0,
                                hours: countdown.hour ?? 0,
                                mins: countdown.minute ?? 0,
                                secs: countdown.second ?? 0)
   }

    var isFinished: Bool {
        if timer.days == 0, timer.hours == 0, timer.mins == 0, timer.secs == 0 {
            return true
        } else {
            return false
        }
    }
    
    init(id: String, title: String, subTitle: String, colorCard: Color, isConfirmed: Bool, futureDate: Date, isPrefered: Bool) {
        self.id = id
        self.title = title
        self.subTitle = subTitle
        self.colorCard = colorCard
        self.isConfirmed = isConfirmed
        self.futureDate = futureDate
        self.isPrefered = isPrefered
    }
    
    public static func == (lhs: CountDownObject, rhs: CountDownObject) -> Bool {
        lhs.id == rhs.id
    }
    
    mutating func preferedDidTap() {
        self.isPrefered.toggle()
        debugPrint("IsPrefered: \(self.isPrefered)")
    }
}

class CountDownPublisher: ObservableObject {
    @Published var items: [CountDownObject] = [CountDownObject(id: "1", title: "STRANGE THINGS", subTitle: "SEASON 4 VOLUME 2 RELEASE DATA", colorCard: .red, isConfirmed: false, futureDate: Calendar.current.date(from: DateComponents(year: 2022, month: 11, day: 30, hour: 0, minute: 0, second: 0))!, isPrefered: false),
                                               CountDownObject(id: "2", title: "TRAVEL", subTitle: "GO TO IBIZA", colorCard: .red, isConfirmed: false, futureDate: Calendar.current.date(from: DateComponents(year: 2022, month: 06, day: 29, hour: 18, minute: 0, second: 0))!, isPrefered: true),
                                               CountDownObject(id: "3", title: "BETTER CALL SAUL", subTitle: "SEASON 6 VOLUME 2 RELEASE DATA", colorCard:  .red, isConfirmed: false, futureDate: Calendar.current.date(from: DateComponents(year: 2023, month: 11, day: 27, hour: 0, minute: 0, second: 0))!, isPrefered: false),
                                               CountDownObject(id: "4", title: "SQUID GAME", subTitle: "SEASON 6 VOLUME 2 RELEASE DATA", colorCard: .red, isConfirmed: false, futureDate: Calendar.current.date(from: DateComponents(year: 2022, month: 11, day: 27, hour: 0, minute: 0, second: 0))!, isPrefered: false)]
}

class DataViewModel: ObservableObject {
    @Published var listCountDownObject = CountDownPublisher()
    @Published var updateUI = false //WORK AROUND FOR PUSH OF COMPUTER PROPERTY
    
    init() { }

    func updateTime() {
        updateUI = true
        listCountDownObject.items.forEach { elem in
//            debugPrint("futureDate: \(elem.futureDate)")
//            debugPrint("countdown: \(elem.countdown)")
//            debugPrint("timer: \(elem.timer)")
        }
    }
}


