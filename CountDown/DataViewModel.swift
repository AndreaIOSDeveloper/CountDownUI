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
    var tags: [TAG]
    var isCustom: Bool
    
    var countdown: DateComponents {
        if futureDate < Date() {
            return Calendar.current.dateComponents([.day, .hour, .minute, .second], from: Date(), to: Date())
        }
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
        if timer.days == 0, timer.hours == 0, timer.mins == 0, timer.secs == 0 || futureDate < Date() {
            return true
        } else {
            return false
        }
    }
    
    init(id: String, title: String, subTitle: String, colorCard: Color, isConfirmed: Bool, futureDate: Date, isPrefered: Bool, tags: [TAG], isCustom: Bool = false) {
        self.id = id
        self.title = title
        self.subTitle = subTitle
        self.colorCard = colorCard
        self.isConfirmed = isConfirmed
        self.futureDate = futureDate
        self.isPrefered = isPrefered
        self.tags = tags
        self.isCustom = isCustom
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
    @Published var items: [CountDownObject] = [CountDownObject(id: "0", title: "STRANGE THINGS", subTitle: "SEASON 4 VOLUME 1 RELEASE DATA", colorCard: .red, isConfirmed: false, futureDate: Calendar.current.date(from: DateComponents(year: 2022, month: 07, day: 01, hour: 0, minute: 0, second: 0))!, isPrefered: false, tags: [.tv]),
                                               CountDownObject(id: "1", title: "TRAVEL", subTitle: "GO TO IBIZA", colorCard: .red, isConfirmed: false, futureDate: Calendar.current.date(from: DateComponents(year: 2022, month: 06, day: 29, hour: 18, minute: 0, second: 0))!, isPrefered: true, tags: [.travel]),
                                               CountDownObject(id: "2", title: "ONE PUNCH MAN", subTitle: "SEASON 3 PREMIER DATA", colorCard:  .red, isConfirmed: false, futureDate: Calendar.current.date(from: DateComponents(year: 2022, month: 09, day: 13, hour: 0, minute: 0, second: 0))!, isPrefered: false, tags: [.tv]),
                                               CountDownObject(id: "3", title: "BETTER CALL SAUL", subTitle: "SEASON 6 VOLUME 2 RELEASE DATA", colorCard:  .red, isConfirmed: false, futureDate: Calendar.current.date(from: DateComponents(year: 2023, month: 11, day: 27, hour: 0, minute: 0, second: 0))!, isPrefered: false, tags: [.tv]),
                                               CountDownObject(id: "4", title: "SQUID GAME", subTitle: "SEASON 6 VOLUME 2 RELEASE DATA", colorCard: .red, isConfirmed: false, futureDate: Calendar.current.date(from: DateComponents(year: 2022, month: 11, day: 27, hour: 0, minute: 0, second: 0))!, isPrefered: false, tags: [.tv]),
                                               CountDownObject(id: "5", title: "NAPOLI VS GENOA", subTitle: "SERIE A 1a GIORNATA", colorCard: .red, isConfirmed: false, futureDate: Calendar.current.date(from: DateComponents(year: 2022, month: 08, day: 02, hour: 0, minute: 0, second: 0))!, isPrefered: false, tags: [.sport, .tv]),
                                               CountDownObject(id: "6", title: "NEW YEARS DAY", subTitle: "COUNT DOWN TO THE YEAR 2023", colorCard: .red, isConfirmed: false, futureDate: Calendar.current.date(from: DateComponents(year: 2022, month: 12, day: 31, hour: 23, minute: 59, second: 59))!, isPrefered: false, tags: [.event, .other])]
}

class DataViewModel: ObservableObject {
    static let shared = DataViewModel()
    
    @Published var listCountDownObject = CountDownPublisher()
    @Published var updateUI = false //WORK AROUND FOR PUSH OF COMPUTER PROPERTY
    
    init() { }

    func updateList() {
        updateUI = true
        listCountDownObject.items.forEach { elem in
//            debugPrint("futureDate: \(elem.futureDate)")
//            debugPrint("countdown: \(elem.countdown)")
//            debugPrint("timer: \(elem.timer)")
        }
    }
}


