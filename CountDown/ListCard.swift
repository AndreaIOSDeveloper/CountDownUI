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
    @State var presentingHomeModal = false
    @State var presentingPreferitiModal = false
    @State private var nActiveFiltri: Int = 0
    @State private var searchText = ""
    
    let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    
    private var colorCard: Color = .red
    private var typeSection: TypeSection = .home
    
    init(typeSection: TypeSection) {
        // print("⚠️ LIST OBJECT: \(viewModel.listCountDownObject.items.isEmpty ? "🤬" : "🥳")")
        self.typeSection = typeSection
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer(minLength: 20)
                switch typeSection {
                case .home:
                    if viewModel.homeList.isEmpty {
                        if viewModel.isShowingLoader {
                            ProgressView(value:  viewModel.progress, total: 1)
                                .progressViewStyle(GaugeProgressStyle())
                                .frame(width: 100, height: 100)
                                .contentShape(Rectangle())
                            
                        } else {
                            Text(String(format: "There are no countdowns available.\n Check your network and try again soon"))
                                .font(.headline)
                                .padding()
                                .multilineTextAlignment(.center)
                            Button {
                                print("⚠️ Retry Button")
                                self.viewModel.progress = 0
                                self.viewModel.isShowingLoader = true
                                self.viewModel.retryToReceiveListOfCountDown()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    self.viewModel.isShowingLoader = false
                                    filterHomeList()
                                }
                                print("⚠️ LIST OBJECT: \(viewModel.listCountDownObject.items.isEmpty ? "🤬" : "🥳")")
                            } label: {
                                RetryView(title: "Retry", colorTag: .primary)
                            }
                        }
                        
                        Spacer()
                    } else {
                        var listFilterHome = (searchText.count != 0 && searchText != "") ? viewModel.homeList.filter{$0.title.contains(searchText.uppercased())} : viewModel.homeList

                        let sortedList = listFilterHome.sort(by: { $0.compareData < $1.compareData })
                        let sortededList = listFilterHome.sorted(by: { $0.compareData < $1.compareData })

                        List(sortededList) { item in
                            CardTimer(object: item, idToPrefered: item.id)
                        }
                        .buttonStyle(PlainButtonStyle()) // Remove cell style
                        .onAppear(perform: {
                            debugPrint("⚠️TAB HOME")
                            self.viewModel.isShowingLoader = true
                        })
                        .searchable(text: $searchText, prompt: "Search")
                    }
                case .preferiti:
                    let listPreferiti = viewModel.listCountDownObject.customItems.filter{$0.isPrefered == true} + viewModel.listCountDownObject.items.filter{$0.isPrefered == true}
                    
                    if listPreferiti.isEmpty {
                        if viewModel.isShowingLoader {
                            ProgressView(value: viewModel.progress, total: 1.0)
                                .progressViewStyle(GaugeProgressStyle())
                                .frame(width: 100, height: 100)
                                .contentShape(Rectangle())
                            
                        } else {
                            Text(String(format: "You have no favourite countdowns"))
                                .font(.headline)
                                .padding()
                                .multilineTextAlignment(.center)
                        }
                        Spacer()
                    } else {
                        List(listPreferiti) { item in
                            CardTimer(object: item, idToPrefered: item.id)
                        }
                        .buttonStyle(PlainButtonStyle()) // Remove cell style
                        .onAppear(perform: {
                            debugPrint("⚠️TAB PREFERITI")
                            self.viewModel.isShowingLoader = true
                            
                        })
                    }
                case .completati:
                    let listCompletati = viewModel.listCountDownObject.customItems.filter{$0.isFinished == true} + viewModel.listCountDownObject.items.filter{$0.isFinished == true}
                    
                    if listCompletati.isEmpty {
                        if viewModel.isShowingLoader {
                            ProgressView(value: viewModel.progress, total: 1.0)
                                .progressViewStyle(GaugeProgressStyle())
                                .frame(width: 100, height: 100)
                                .contentShape(Rectangle())
                        } else {
                            Text(String(format: "You have no completed countdowns"))
                                .font(.headline)
                                .padding()
                                .multilineTextAlignment(.center)
                        }
                        
                        Spacer()
                    } else {
                        List(listCompletati) { item in
                            CardTimer(object: item, idToPrefered: item.id)
                        }
                        .buttonStyle(PlainButtonStyle()) // Remove cell style
                        .onAppear(perform: {
                            debugPrint("⚠️TAB COMPLETATI")
                            self.viewModel.isShowingLoader = true
                        })
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("My Count Down App").font(.headline)
                        switch typeSection {
                        case .home:
                            Text("We found \(viewModel.homeList.count) item").font(.subheadline)
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
                            self.presentingHomeModal = true
                        }) {
                            Image(systemName: "flowchart")
                                .foregroundColor(.primary)
                        }
                        .sheet(isPresented: $presentingHomeModal) { OrderListView(presentedAsModal: self.$presentingHomeModal, nActiveFiltri: self.$nActiveFiltri) }
                        .overlay(Badge(count: nActiveFiltri))
                    case .preferiti:
                        Button(action: {
                            self.presentingPreferitiModal = true
                        }) {
                            Image(systemName: "plus.circle")
                                .foregroundColor(.primary)
                        }
                        .sheet(isPresented: $presentingPreferitiModal) { AddNewTimerView(presentedAsModal: self.$presentingPreferitiModal) }
                    case .completati:
                        Button(action: {  }) { Text("") }
                    }
                }
            }
        }
        .task {
            if typeSection == .home {
                print("⚠️ task ListCard")
                await viewModel.receiveListOfCountDown()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.viewModel.isShowingLoader = false
                self.filterHomeList()
            }
        }
        .onReceive(timer) { time in
            if viewModel.progress < 1 {
                withAnimation {
                    viewModel.progress += 0.2
                }
            }
        }
    }
    
    private func filterHomeList() {
        let listHome = viewModel.listCountDownObject.customItems.filter{$0.isPrefered == false && $0.isFinished == false} +
                       viewModel.listCountDownObject.items.filter{$0.isPrefered == false && $0.isFinished == false}
        let filter = viewModel.arraytag.filter{$0.isCheck == true && $0.tag != "All"}
        var filterListHome: [CountDownObject] = []
        var filterListHomeFilter: [CountDownObject] = []
        if filter.count != 0 {
            let stringFilter = filter.map{$0.tag}
            stringFilter.forEach { filter in
                filterListHomeFilter = listHome.filter { countDownObject in
                    countDownObject.tags.contains{$0.title() == filter}
                }
                filterListHomeFilter.forEach{filterListHome.append($0)}
            }
            viewModel.homeList = filterListHome
        } else {
            viewModel.homeList = listHome
        }
    }
}

struct ListCard_Previews: PreviewProvider {
    static var previews: some View {
        ListCard(typeSection: .home)
    }
}
