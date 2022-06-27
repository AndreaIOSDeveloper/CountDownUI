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
    private var isPreferitiSection: Bool = false
    
    init(isPreferitiSection: Bool) {
        self.isPreferitiSection = isPreferitiSection
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer(minLength: 40)
                if isPreferitiSection {
                    List(viewModel.listCountDownObject.customItems + viewModel.listCountDownObject.items.filter{$0.isPrefered == true}) { item in
                        CardTimer(object: item, idToPrefered: item.id)
                    }
                    .buttonStyle(PlainButtonStyle()) // Remove cell style
                } else {
                    List(viewModel.listCountDownObject.items.filter{$0.isCustom == false}) { item in
                        CardTimer(object: item, idToPrefered: item.id)
                    }
                    .buttonStyle(PlainButtonStyle()) // Remove cell style
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("My Count Down App").font(.headline)
                        let preferedList = viewModel.listCountDownObject.customItems + viewModel.listCountDownObject.items.filter{$0.isPrefered == true}
                        
                        Text("We found \(isPreferitiSection ? preferedList.count : viewModel.listCountDownObject.items.count) item").font(.subheadline)
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
                    } else {
                        Button(action: {
                            self.presentingModal = true
                        }) {
                            Image(systemName: "flowchart")
                                .foregroundColor(.black)
                        }
                        .sheet(isPresented: $presentingModal) { OrderListView(presentedAsModal: self.$presentingModal) }
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
