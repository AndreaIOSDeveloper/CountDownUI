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
                    List(viewModel.listCountDownObject.items.filter{$0.isPrefered == true}) { item in
                        CardTimer(object: item, nElem: Int(item.id) ?? 0)
                    }
                    .buttonStyle(PlainButtonStyle()) // Remove cell style
                    .onReceive(timer) { time in
                        viewModel.updateList()
                    }
                } else {
                    List(viewModel.listCountDownObject.items) { item in
                        CardTimer(object: item, nElem: Int(item.id) ?? 0)
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
                        Text("WE FOUND \(isPreferitiSection ? viewModel.listCountDownObject.items.filter{$0.isPrefered == true}.count : viewModel.listCountDownObject.items.count) COUNTDOWNS").font(.subheadline)
                    }
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                
                    Button(action: {
                        self.presentingModal = true
                    }) {
                        Image(systemName: "plus.circle")
                                .foregroundColor(.black)
                    }
                    .sheet(isPresented: $presentingModal) { AddNewTimer(presentedAsModal: self.$presentingModal) }
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
