//
//  CardTimer.swift
//  CountDown
//
//  Created by Andrea Di Francia on 15/06/22.
//

import Foundation
import SwiftUI

struct TimeCard: Codable {
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
    
    enum CodingKeys: String, CodingKey {
        case years = "years"
        case months = "months"
        case days = "days"
        case hours = "hours"
        case mins = "mins"
        case secs = "secs"
    }
}

enum TAG: Codable {
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
    
    enum CodingKeys: String, CodingKey {
        case tv = "tv"
        case other = "other"
        case event = "event"
        case movies = "movies"
        case sport = "sport"
        case game = "game"
        case travel = "travel"
    }
}

extension TAG: Identifiable {
    var id: Self { self }
}

struct CardTimer: View {
    private var title: String
    private var subTitle: String
    private var time: TimeCard = TimeCard(years: 0, months: 0, days: 0, hours: 0, mins: 0, secs: 0)
    private var idToPrefered: String
    private var tags: [TAG]
    private var imageName: String {
        return isPrefered ? "star.fill" : "star"
    }
    
    @StateObject private var viewModel = DataViewModel.shared
    @State private var colorCard: Color
    @State private var isPrefered: Bool
    @State private var isCustom: Bool
    @State private var isFinishTime: Bool
    
    private let timerCard = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    init(object: CountDownObject, idToPrefered: String) {
        self.title = object.title
        self.subTitle = object.subTitle
        self.colorCard = object.convertColor(stringColor: object.colorCard)
        self.time = object.timer
        self.isPrefered = object.isPrefered
        self.idToPrefered = idToPrefered
        self.tags = object.tags
        self.isCustom = object.isCustom
        self.isFinishTime = object.isFinished
    }
    
    func didTapPrefered() {
        viewModel.listCountDownObject.items.enumerated().forEach({ idx, item in
            if item.id == idToPrefered {
                    debugPrint("🥵 Ho tappato un elemento STANDARD: \(viewModel.listCountDownObject.items[idx].title) è un preferito: \(viewModel.listCountDownObject.items[idx].isPrefered)")
                    viewModel.listCountDownObject.items[idx].isPrefered = !viewModel.listCountDownObject.items[idx].isPrefered
                    isPrefered = viewModel.listCountDownObject.items[idx].isPrefered
                    debugPrint("🥵 Ho tappato un elemento STANDARD: \(viewModel.listCountDownObject.items[idx].title) è diventato: \(viewModel.listCountDownObject.items[idx].isPrefered)")
            }
        })
        
        viewModel.listCountDownObject.customItems.enumerated().forEach({ idx, item in
            if item.id == idToPrefered {
                    debugPrint("🥵 Ho tappato un elemento CUSTOM: \(viewModel.listCountDownObject.customItems[idx].title) è un preferito: \(viewModel.listCountDownObject.customItems[idx].isPrefered)")
                    viewModel.listCountDownObject.customItems[idx].isPrefered = !viewModel.listCountDownObject.customItems[idx].isPrefered
                    isPrefered = viewModel.listCountDownObject.customItems[idx].isPrefered
                    debugPrint("🥵 Ho tappato un elemento CUSTOM: \(viewModel.listCountDownObject.customItems[idx].title) è diventato: \(viewModel.listCountDownObject.customItems[idx].isPrefered)")
            }
        })
        
        viewModel.updateUserDefault(item: viewModel.listCountDownObject.items)
    }
    
    var body: some View {
        VStack {
            HStack {
                PreventableScrollView(canScroll: .constant(false)) {
                    ForEach(0 ..< tags.count, id: \.self) { tag in
                        TagView(title: tags[tag].title(), colorTag: colorCard)
                            .foregroundColor(colorCard)
                            .font(.system(size: 13))
                    }
                }
                
                Spacer()
                Button(action: {
                    DispatchQueue.main.async {
                        debugPrint("⚠️ DidTap on \(title) with id: \(idToPrefered)")
                        didTapPrefered()
                    }
                }) {
                    Image(systemName: imageName)
                        .foregroundColor(.white)
                }
                .frame(width: 50, height: 50, alignment: .center)
            }
            Text(title)
                .foregroundColor(Color.white)
                .bold()
                .multilineTextAlignment(.center)
                .padding(.bottom, 4.0)
            
            Text(subTitle)
                .padding(.bottom, 16.0)
                .foregroundColor(Color.white)
                .multilineTextAlignment(.center)
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
            .onReceive(timerCard) { time in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    isFinishTime = viewModel.checkFinishTimer(id: idToPrefered)
                    isPrefered = viewModel.checkPrefered(findElem: idToPrefered)
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
                                          colorCard: "red",
                                          isConfirmed: false,
                                          futureDate: Calendar.current.date(from: DateComponents(year: 2022, month: 11, day: 27, hour: 0, minute: 0, second: 0))!,
                                          isPrefered: false,
                                          tags: [.movies]),
                                          idToPrefered: "1")
    }
}
