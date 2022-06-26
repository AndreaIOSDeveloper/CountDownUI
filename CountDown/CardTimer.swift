//
//  CardTimer.swift
//  CountDown
//
//  Created by Andrea Di Francia on 15/06/22.
//

import Foundation
import SwiftUI

struct TimeCard {
    var years: Int
    var months: Int
    var days: Int
    var hours: Int
    var mins: Int
    var secs: Int
    
    init(years: Int, months: Int, days: Int, hours: Int, mins: Int, secs: Int) {
        self.years = years
        self.months = months
        self.days = days
        self.hours = hours
        self.mins = mins
        self.secs = secs
    }
}

enum TAG {
    case tv
    case other
    case event
    case movies
    case sport
    case game
    case travel
    
    func title() -> String {
        switch self {
        case .tv:
            return "TV"
        case .other:
            return "Other"
        case .event:
            return "Event"
        case .movies:
            return "Movies"
        case .sport:
            return "Sport"
        case .game:
            return "Game"
        case .travel:
            return "Travel"
        }
    }
    
    static func enumFromString(string: String) -> TAG {
        switch string {
        case self.tv.title():
            return .tv
        case self.other.title():
            return .other
        case self.event.title():
            return .event
        case self.movies.title():
            return .movies
        case self.sport.title():
            return .sport
        case self.game.title():
            return .game
        case self.travel.title():
            return .travel
        default:
            return .other
        }
    }
}

extension TAG: Identifiable {
    var id: Self { self }
}

struct CardTimer: View {
    private var title: String
    private var subTitle: String
    private var colorCard: Color = .red
    private var time: TimeCard = TimeCard(years: 0, months: 0, days: 0, hours: 0, mins: 0, secs: 0)
    private var nElem: Int
    private var tags: [TAG]

    @StateObject private var viewModel = DataViewModel.shared
    
    @State private var isSelected: Bool
    @State private var imageName: String
    @State private var isCustom: Bool
    @State private var isFinishTime: Bool
    
    init(object: CountDownObject, nElem: Int, isCustom: Bool = false) {
        self.title = object.title
        self.subTitle = object.subTitle
        self.colorCard = object.colorCard
        self.time = object.timer
        self.isSelected = object.isPrefered
        self.imageName = object.isPrefered ? "star.fill" : "star"
        self.nElem = nElem
        self.tags = object.tags
        self.isCustom = object.isCustom
        self.isFinishTime = object.isFinished
        
        if object.title == "STRANGE THINGS" {
            debugPrint(object.isPrefered)
            debugPrint(self.isSelected)
            debugPrint(self.imageName)
            debugPrint(self.nElem)
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                PreventableScrollView(canScroll: .constant(false)) {
                    ForEach(0 ..< tags.count, id: \.self) { tag in
                        TagView(title: tags[tag].title())
                            .foregroundColor(isCustom ? .blue : .red)
                            .font(.system(size: 13))
                    }
                }
                
                Spacer()
                Button(action: {
                    viewModel.listCountDownObject.items[nElem].isPrefered.toggle()
                    self.isSelected.toggle()
                    self.imageName = isSelected ? "star.fill" : "star"
                }) {
                    Image(systemName: imageName)
                        .foregroundColor(.white)
                }
            }
            Text(title)
                .foregroundColor(Color.white)
                .bold()
                .padding(.bottom, 4.0)
            
            Text(subTitle)
                .padding(.bottom, 16.0)
                .foregroundColor(Color.white)
            HStack {
                if !isFinishTime {
                    VStack {
                        Text(time.days.description)
                            .bold()
                            .foregroundColor(Color.white)
                        Text("Days")
                            .foregroundColor(Color.white)
                    }
                    .padding(.trailing)
                    
                    VStack {
                        Text(time.hours.description)
                            .bold()
                            .foregroundColor(Color.white)
                        Text("Hours")
                            .foregroundColor(Color.white)
                    }
                    .padding(.trailing)
                    
                    VStack {
                        Text(time.mins.description)
                            .bold()
                            .foregroundColor(Color.white)
                        Text("Mins")
                            .foregroundColor(Color.white)
                    }
                    .padding(.trailing)
                    
                    VStack {
                        Text(time.secs.description)
                            .bold()
                            .foregroundColor(Color.white)
                        Text("Secs")
                            .foregroundColor(Color.white)
                    }
                } else {
                    Text("COUNT DOWN IS FINISH !")
                        .foregroundColor(Color.white)
                        .bold()
                        .padding(.bottom, 4.0)
                }
            }
        }
        .padding()
        .background(colorCard)
    }
}

struct CardTimer_Previews: PreviewProvider {
    static var previews: some View {
        CardTimer(object: CountDownObject(id: "0",
                                          title: "Test",
                                          subTitle: "TestTestTestTestTestTestTestTest",
                                          colorCard: .red,
                                          isConfirmed: false,
                                          futureDate: Calendar.current.date(from: DateComponents(year: 2022, month: 11, day: 27, hour: 0, minute: 0, second: 0))!,
                                          isPrefered: false,
                                          tags: [.movies]),
                                          nElem: 1)
    }
}
