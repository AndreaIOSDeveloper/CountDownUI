//
//  AddNewTimerView.swift
//  CountDown
//
//  Created by Di Francia, Andrea (Contractor) on 26/06/22.
//

import Foundation
import SwiftUI

struct AddNewTimerView: View {
    @StateObject private var viewModel = DataViewModel.shared

    @Binding var presentedAsModal: Bool
    @State var title: String = ""
    @State var description: String = ""
    @State private var previewIndex = ""
    @State private var previewColorIndex = ""
    @State private var customDataCountDown = Date()
    
    let previewOptions: [String] = [TAG.tv.title(), TAG.movies.title(), TAG.sport.title(), TAG.event.title(), TAG.game.title(), TAG.travel.title(), TAG.other.title()]
    let previewColorsOptions: [String] = ["🔴 Red", "🟠 Orange","🟡 Yellow", "🟢 Green", "⚫️ Black", "🔵 Blue", "🟣 Pink"]
    let tomorrow = Date.now.addingTimeInterval(TimeInterval.infinity)
    
    init(presentedAsModal: Binding<Bool>) {
        self._presentedAsModal = presentedAsModal
  
    }
    
    private func createNotification() {
        let center = UNUserNotificationCenter.current()
        
        //Step-2 Create the notification content
        let content = UNMutableNotificationContent()
        content.title = "Notification for \(title)"
        content.body = "Your count down is finish !"
        content.sound = UNNotificationSound.default
        
        //Step-3 Create the notification trigger
        // let date = Date().addingTimeInterval(5)
        let dateComponent = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second], from: customDataCountDown)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        
        //Step-4 Create a request
        let uuid = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)
        
        //Step-5 Register with Notification Center
        center.add(request) { error in
            if error != nil {
                debugPrint("❌ Error create notification \(error!)")
            }
        }
        
        let newCountDown = CountDownObject(id: "P_\(viewModel.listCountDownObject.customItems.count)", title: title, subTitle: description, colorCard: previewColorIndex, isConfirmed: false, futureDate: customDataCountDown, isPrefered: true, tags: [TAG.enumFromString(string: previewIndex)], isCustom: true)
        viewModel.listCountDownObject.customItems.append(newCountDown)
        viewModel.saveCountDown(item: viewModel.listCountDownObject.customItems)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Title:")) {
                    TextField("insert title", text: $title)
                }
                
                Section(header: Text("Description:")) {
                    TextField("insert description", text: $description)
                }
                
                Section(header: Text("TAG:")) {
                    VStack {
                        Picker("Please choose a Tags:", selection: $previewIndex) {
                            ForEach(previewOptions, id: \.self) {
                                Text($0)
                            }
                        }
//                        .pickerStyle(.wheel)
                    }
                }
                
                Section(header: Text("Color Card:")) {
                    VStack {
                        Picker("Please choose a color:", selection: $previewColorIndex) {
                            ForEach(previewColorsOptions, id: \.self) {
                                Text($0)
                            }
                        }
//                        .pickerStyle(.wheel)
                    }
                }
                
                Section(header: Text("Select Date:")) {
                    VStack {
                        DatePicker(selection: $customDataCountDown, in: ...tomorrow, displayedComponents: [.date, .hourAndMinute]) {
                            Text("Select a date")
                        }
                        
//                        Text("Date is \(birthDate.formatted(date: .long, time: .omitted))")
                    }
                }
                
                Section(header: Text("Warning: some field are mandatory")) {
                    HStack{
                        LargeButton(title: "Cancel",
                                    backgroundColor: .white,
                                    foregroundColor: .black) {
                            self.presentedAsModal = false
                        }
                        
                        Spacer()
                        
                        LargeButton(title: "Save",
                                    backgroundColor: .black) {
                            self.presentedAsModal = false
                            createNotification()
                        }
                    }
                }
            }
        }
    }
}

struct AddNewTimerView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewTimerView(presentedAsModal: .constant(true))
    }
}
