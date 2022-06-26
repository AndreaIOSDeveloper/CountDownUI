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
    @State private var birthDate = Date()
    
    let previewOptions: [String] = [TAG.tv.title(), TAG.movies.title(), TAG.sport.title(), TAG.event.title(), TAG.game.title(), TAG.travel.title(), TAG.other.title()]
    let tomorrow = Date.now.addingTimeInterval(TimeInterval.infinity)
    
    init(presentedAsModal: Binding<Bool>) {
        self._presentedAsModal = presentedAsModal
  
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
                
                Section(header: Text("Select Date:")) {
                    VStack {
                        DatePicker(selection: $birthDate, in: ...tomorrow, displayedComponents: .date) {
                            Text("Select a date")
                        }
                        
//                        Text("Date is \(birthDate.formatted(date: .long, time: .omitted))")
                    }
                }
                
                Section(header: Text("Warning: some field are mandatory")) {
                    HStack{
                        Button("Cancel") { self.presentedAsModal = false }
                        
                        Spacer()
                        
                        Button("Save") {
                            let newCountDown = CountDownObject(id: "P_\(viewModel.listCountDownObject.customItems.count)", title: title, subTitle: description, colorCard: .blue, isConfirmed: false, futureDate: birthDate, isPrefered: true, tags: [TAG.enumFromString(string: previewIndex)], isCustom: true)
                            viewModel.listCountDownObject.customItems.append(newCountDown)
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
