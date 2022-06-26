//
//  ListCard.swift
//  CountDown
//
//  Created by Andrea Di Francia on 15/06/22.
//

import Foundation
import SwiftUI

struct ListCard: View {
    @StateObject private var viewModel = DataViewModel.shared
    @State var presentingModal = false
    @State var text = ""

    private var colorCard: Color = .red
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private var isPreferitiSection: Bool = false
    
    init(isPreferitiSection: Bool) {
        self.isPreferitiSection = isPreferitiSection
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer(minLength: 40)
                if isPreferitiSection {
                    let preferedList = viewModel.listCountDownObject.customItems + viewModel.listCountDownObject.items.filter{$0.isPrefered == true}
                    List(preferedList) { item in
                        CardTimer(object: item, idToPrefered: item.id) { findElem in
                            viewModel.listCountDownObject.items.enumerated().forEach({ idx, item in
                                if item.id == findElem {
                                    viewModel.listCountDownObject.items[idx].isPrefered.toggle()
                                }
                            })
                            //Controllo nei preferiti
                            viewModel.listCountDownObject.customItems.enumerated().forEach({ idx, item in
                                if item.id == findElem {
                                    viewModel.listCountDownObject.customItems[idx].isPrefered.toggle()
                                }
                            })
                        }
                    }
                    .buttonStyle(PlainButtonStyle()) // Remove cell style
                    .onReceive(timer) { time in
                        viewModel.updateList()
                    }
                } else {
                    List(viewModel.listCountDownObject.items.filter{$0.isCustom == false}) { item in
                        CardTimer(object: item, idToPrefered: item.id)  { findElem in
                            viewModel.listCountDownObject.items.enumerated().forEach({ idx, item in
                                if item.id == findElem {
                                    viewModel.listCountDownObject.items[idx].isPrefered.toggle()
                                }
                            })
                            //Controllo nei preferiti
                            viewModel.listCountDownObject.customItems.enumerated().forEach({ idx, item in
                                if item.id == findElem {
                                    viewModel.listCountDownObject.customItems[idx].isPrefered.toggle()
                                }
                            })
                        }

                    }
                    .buttonStyle(PlainButtonStyle()) // Remove cell style
                    .onReceive(timer) { time in
                        viewModel.updateList()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    
                    VStack {
                        Text("COUNT DOWN APP").font(.headline)
                        let preferedList = viewModel.listCountDownObject.customItems + viewModel.listCountDownObject.items.filter{$0.isPrefered == true}
                        
                        Text("WE FOUND \(isPreferitiSection ? preferedList.count : viewModel.listCountDownObject.items.count) COUNTDOWNS").font(.subheadline)
                    }
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    if isPreferitiSection {
                        Button(action: {
                            self.presentingModal = true
                        }) {
                            Image(systemName: "plus.circle")
                                .foregroundColor(.black)
                        }
                        .sheet(isPresented: $presentingModal) { AddNewTimerView(presentedAsModal: self.$presentingModal) }
                    }
                }
            }
        }
    }
}

struct ListCard_Previews: PreviewProvider {
    static var previews: some View {
        ListCard(isPreferitiSection: false)
    }
}
