//
//  DataViewModel.swift
//  CountDown
//
//  Created by Andrea Di Francia on 15/06/22.
//

import Foundation
import SwiftUI
import Combine

struct CountDownObject: Identifiable, Equatable, Codable {
    var id: String
    var title: String
    var subTitle: String
    var colorCard: String
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

   var isFinished: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case subTitle = "subTitle"
        case colorCard = "colorCard"
        case isConfirmed = "isConfirmed"
        case isPrefered = "isPrefered"
        case futureDate = "futureDate"
        case tags = "tags"
        case isCustom = "isCustom"
        case countdown = "countdown"
        case timer = "timer"
        case isFinished = "isFinished"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(subTitle, forKey: .subTitle)
        try container.encode(colorCard, forKey: .colorCard)
        try container.encode(isConfirmed, forKey: .isConfirmed)
        try container.encode(isPrefered, forKey: .isPrefered)
        try container.encode(futureDate, forKey: .futureDate)
        try container.encode(tags, forKey: .tags)
        try container.encode(isCustom, forKey: .isCustom)
        try container.encode(countdown, forKey: .countdown)
        try container.encode(timer, forKey: .timer)
        try container.encode(isFinished, forKey: .isFinished)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        subTitle = try container.decode(String.self, forKey: .subTitle)
        colorCard = try container.decode(String.self, forKey: .colorCard)
        isConfirmed = try container.decode(Bool.self, forKey: .isConfirmed)
        isPrefered = try container.decode(Bool.self, forKey: .isPrefered)
        futureDate = try container.decode(Date.self, forKey: .futureDate)
        tags = try container.decode([TAG].self, forKey: .tags)
        isCustom = try container.decode(Bool.self, forKey: .isCustom)
        try container.decode(DateComponents.self, forKey: .countdown)
        try container.decode(TimeCard.self, forKey: .timer)
        isFinished = try container.decode(Bool.self, forKey: .isFinished)
    }
    
    init(id: String, title: String, subTitle: String, colorCard: String, isConfirmed: Bool, futureDate: Date, isPrefered: Bool, tags: [TAG], isCustom: Bool = false) {
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
}

class CountDownPublisher: ObservableObject {
    @Published var items: [CountDownObject] = []
    @Published var customItems: [CountDownObject] = []
    
    @Published var itemsTest: [CountDownObject] = [CountDownObject(id: "0", title: "STRANGE THINGS", subTitle: "SEASON 4 VOLUME 1 RELEASE DATA", colorCard: "red", isConfirmed: false, futureDate: Calendar.current.date(from: DateComponents(year: 2022, month: 07, day: 01, hour: 0, minute: 0, second: 0))!, isPrefered: false, tags: [.tv]),
                                               CountDownObject(id: "1", title: "TRAVEL", subTitle: "GO TO IBIZA", colorCard: "red", isConfirmed: false, futureDate: Calendar.current.date(from: DateComponents(year: 2022, month: 06, day: 29, hour: 18, minute: 0, second: 0))!, isPrefered: true, tags: [.travel]),
                                               CountDownObject(id: "2", title: "ONE PUNCH MAN", subTitle: "SEASON 3 PREMIER DATA", colorCard:  "red", isConfirmed: false, futureDate: Calendar.current.date(from: DateComponents(year: 2022, month: 09, day: 13, hour: 0, minute: 0, second: 0))!, isPrefered: false, tags: [.tv]),
                                               CountDownObject(id: "3", title: "BETTER CALL SAUL", subTitle: "SEASON 6 VOLUME 2 RELEASE DATA", colorCard:  "red", isConfirmed: false, futureDate: Calendar.current.date(from: DateComponents(year: 2023, month: 11, day: 27, hour: 0, minute: 0, second: 0))!, isPrefered: false, tags: [.tv]),
                                               CountDownObject(id: "4", title: "SQUID GAME", subTitle: "SEASON 6 VOLUME 2 RELEASE DATA", colorCard: "red", isConfirmed: false, futureDate: Calendar.current.date(from: DateComponents(year: 2022, month: 11, day: 27, hour: 0, minute: 0, second: 0))!, isPrefered: false, tags: [.tv]),
                                               CountDownObject(id: "5", title: "NAPOLI VS GENOA", subTitle: "SERIE A 1a GIORNATA", colorCard: "red", isConfirmed: false, futureDate: Calendar.current.date(from: DateComponents(year: 2022, month: 08, day: 02, hour: 0, minute: 0, second: 0))!, isPrefered: false, tags: [.sport, .tv]),
                                               CountDownObject(id: "6", title: "NEW YEARS DAY", subTitle: "COUNT DOWN TO THE YEAR 2023", colorCard: "red", isConfirmed: false, futureDate: Calendar.current.date(from: DateComponents(year: 2022, month: 12, day: 31, hour: 23, minute: 59, second: 59))!, isPrefered: false, tags: [.event, .other])]
}

class DataViewModel: ObservableObject {
    static let shared = DataViewModel()
    
    private var subscriptions = Set<AnyCancellable>()

    @Published var listCountDownObject = CountDownPublisher()
    
    //WORK AROUND FOR PUSH OF COMPUTER PROPERTY
    @Published var updateUI = false
    
    @Published var arraytag: [OrderListType] = [OrderListType(tag: "All", isCheck: true),
                                     OrderListType(tag: TAG.other.title(), isCheck: false),
                                     OrderListType(tag: TAG.tv.title(), isCheck: false),
                                     OrderListType(tag: TAG.travel.title(), isCheck: false),
                                     OrderListType(tag: TAG.game.title(), isCheck: false),
                                     OrderListType(tag: TAG.event.title(), isCheck: false),
                                     OrderListType(tag: TAG.movies.title(), isCheck: false),
                                     OrderListType(tag: TAG.sport.title(), isCheck: false)]
    
    init() {
        receiceCountDown()
        
        subscribe()
    }
    
    private func subscribe() {
        DispatchQueue.main.async {
            self.checkUserNameAvailable()
                .removeDuplicates()
                .sink { [weak self] jsonItem in
                    guard let self = self else { return }
                    jsonItem.isEmpty ? print("❌ JSON VUOTO !") : print("✅ Lista JSON: \(jsonItem)")
                    self.listCountDownObject.items = jsonItem
                }
                .store(in: &self.subscriptions)
        }
    }

    func checkFinishTimer(id: String) -> Bool {
        updateUI.toggle()
        var returnElem: Bool = false
        
        let fullList = listCountDownObject.items + listCountDownObject.customItems
        fullList.enumerated().forEach { idx, elem in
            if elem.timer.days == 0,
               elem.timer.hours == 0,
               elem.timer.mins == 0,
               elem.timer.secs == 0 || elem.futureDate < Date() {
                if listCountDownObject.items.contains(where: { $0.id == fullList[idx].id }) {
                    let index = listCountDownObject.items.firstIndex(of: fullList[idx])
                    listCountDownObject.items[index ?? 0].isFinished = true
                    if id == listCountDownObject.items[index ?? 0].id {
                        returnElem = true
                    }
//                    debugPrint("⚠️ LISTA NORMALE -> Ho Trovato un elemento finito \( listCountDownObject.items[index ?? 0]) al posto \(String(describing: index))")
                } else {
                    let index = listCountDownObject.customItems.firstIndex(of: fullList[idx])
                    listCountDownObject.customItems[index ?? 0].isFinished = true
                    if id == listCountDownObject.customItems[index ?? 0].id {
                        returnElem = true
                    }
//                    debugPrint("⚠️ LISTA CUSTOM -> Ho Trovato un elemento finito \( listCountDownObject.customItems[index ?? 0]) al posto \(String(describing: index))")
                }
            }
        }
        
        return returnElem
    }
    
    func checkPrefered(findElem: String) -> Bool {
        updateUI.toggle()
        
        var returnElem: Bool = false
        
        if listCountDownObject.items.contains(where: { $0.id == findElem }) {
            listCountDownObject.items.enumerated().forEach({ idx, item in
                if item.id == findElem {
                    returnElem = item.isPrefered
//                    debugPrint("🥳 Lista Normale \(item.title) è un preferito -> \(item.isPrefered)")
                }
            })
        } else {
            //Controllo nei preferiti
            listCountDownObject.customItems.enumerated().forEach({ idx, item in
                if item.id == findElem {
                    returnElem =  item.isPrefered
//                    debugPrint("🥳 Lista Preferiti \(item.title) è un preferito -> \(item.isPrefered)")
                }
            })
        }
        
        return returnElem
    }
    
    private func encodeObject() {
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(listCountDownObject.items)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            print(jsonString)
        } catch {
            print(error)
        }
    }
    
    func saveCountDown(item: [CountDownObject]) {
        let userDefaults = UserDefaults.standard
        do {
            try userDefaults.setObject(item, forKey: "MyPersonalCountDown")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func receiceCountDown() {
        let userDefaults = UserDefaults.standard
        do {
            let myPersonalCountDown = try userDefaults.getObject(forKey: "MyPersonalCountDown", castTo: [CountDownObject].self)
            print("🟢 SCARICO I COUNTDOWN PERSONALI \(myPersonalCountDown)")
            listCountDownObject.customItems = myPersonalCountDown
        } catch {
            print("🟠 ERRORE COUNTDOWN PERSONALI \(error.localizedDescription)")
        }
    }
    
    //Ricevo il JSON dall'APP
    private func receiveJSON(callback: ([CountDownObject])->()) {
        let url = Bundle.main.url(forResource: "CountDownData", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        
        do {
            print("⚠️ Provo a scaricare JSON")
            let products = try decoder.decode([CountDownObject].self, from: data)
            callback(products)
        } catch {
            print("❌ ERRORE JSON type: \(error)")
            callback([])
        }
    }
    
// "http://napolirace.altervista.org/CountDownData.json"
    
    private func checkUserNameAvailable() -> AnyPublisher<[CountDownObject], Never> {
        guard let url = URL(string: "http://napolirace.altervista.org/CountDownData.json") else {
            return Just([]).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { data, response in
                do {
                    let decoder = JSONDecoder()
                    let userAvailableMessage = try decoder.decode([CountDownObject].self, from: data)
                    return userAvailableMessage
                } catch {
                    return []
                }
            }
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
}
