//
//  ListCard.swift
//  CountDown
//
//  Created by Andrea Di Francia on 15/06/22.
//

import Foundation
import SwiftUI

enum TypeSection {
    case home
    case preferiti
    case completati
}

struct ListCard: View {
    @StateObject private var viewModel = DataViewModel.shared
    @State var presentingModal = false
    @State var text = ""

    private var colorCard: Color = .red
    private var typeSection: TypeSection = .home
    
    init(typeSection: TypeSection) {
        self.typeSection = typeSection
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer(minLength: 40)
                switch typeSection {
                case .home:
                    let listHome = viewModel.listCountDownObject.customItems.filter{$0.isPrefered == false && $0.isFinished == false} +
                                   viewModel.listCountDownObject.items.filter{$0.isPrefered == false && $0.isFinished == false}
                    List(listHome) { item in
                        CardTimer(object: item, idToPrefered: item.id)
                    }
                    .buttonStyle(PlainButtonStyle()) // Remove cell style
                    .onAppear(perform: {
                        debugPrint("⚠️TAB PREFERITI")
                    })
                case .preferiti:
                    let listPreferiti = viewModel.listCountDownObject.customItems.filter{$0.isPrefered == true} + viewModel.listCountDownObject.items.filter{$0.isPrefered == true}
                    List(listPreferiti) { item in
                        CardTimer(object: item, idToPrefered: item.id)
                    }
                    .buttonStyle(PlainButtonStyle()) // Remove cell style
                    .onAppear(perform: {
                        debugPrint("⚠️TAB HOME")
                    })
                case .completati:
                    List(viewModel.listCountDownObject.customItems.filter{$0.isFinished == true} + viewModel.listCountDownObject.items.filter{$0.isFinished == true}) { item in
                        CardTimer(object: item, idToPrefered: item.id)
                    }
                    .buttonStyle(PlainButtonStyle()) // Remove cell style
                    .onAppear(perform: {
                        debugPrint("⚠️TAB COmpletati")
                    })
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("My Count Down App").font(.headline)
                        switch typeSection{
                        case .home:
                            let listHome = viewModel.listCountDownObject.customItems.filter{$0.isPrefered == false && $0.isFinished == false} +
                                           viewModel.listCountDownObject.items.filter{$0.isPrefered == false && $0.isFinished == false}
                            Text("We found \(listHome.count) item").font(.subheadline)
                        case .preferiti:
                            let listPreferiti = viewModel.listCountDownObject.customItems.filter{$0.isPrefered == true} + viewModel.listCountDownObject.items.filter{$0.isPrefered == true}
                            Text("We found \(listPreferiti.count) item").font(.subheadline)
                        case .completati:
                            let completeList = viewModel.listCountDownObject.customItems.filter{$0.isFinished == true} + viewModel.listCountDownObject.items.filter{$0.isFinished == true}
                            Text("We found \(completeList.count) item").font(.subheadline)
                        }
                    }
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    switch typeSection {
                    case .home:
                        Button(action: {
                            self.presentingModal = true
                        }) {
                            Image(systemName: "flowchart")
                                .foregroundColor(.black)
                        }
                        .sheet(isPresented: $presentingModal) { OrderListView(presentedAsModal: self.$presentingModal) }
                    case .preferiti:
                        Button(action: {
                            self.presentingModal = true
                        }) {
                            Image(systemName: "plus.circle")
                                .foregroundColor(.black)
                        }
                        .sheet(isPresented: $presentingModal) { AddNewTimerView(presentedAsModal: self.$presentingModal) }
                    case .completati:
                        Button(action: {  }) { Text("") }
                    }
                }
            }
        }
    }
}

struct ListCard_Previews: PreviewProvider {
    static var previews: some View {
        ListCard(typeSection: .home)
    }
}
