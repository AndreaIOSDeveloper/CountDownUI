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
                        CardTimer(object: item) {
                            viewModel.listCountDownObject.items.enumerated().forEach { index, itemSel in
                                if itemSel == item {
                                    viewModel.listCountDownObject.items[index].preferedDidTap()
                                    debugPrint("⚠️DidTap on: \(viewModel.listCountDownObject.items[index])")
                                }
                            }
                        }
                    }
                    .buttonStyle(PlainButtonStyle()) // Remove cell style
                    .onReceive(timer) { time in
                        viewModel.updateTime()
                    }
                } else {
                    List(viewModel.listCountDownObject.items) { item in
                        CardTimer(object: item) {
                            viewModel.listCountDownObject.items.enumerated().forEach { index, itemSel in
                                if itemSel == item {
                                    viewModel.listCountDownObject.items[index].preferedDidTap()
                                    debugPrint("⚠️DidTap on: \(viewModel.listCountDownObject.items[index])")
                                }
                            }
                        }
                    }
                    .buttonStyle(PlainButtonStyle()) // Remove cell style
                    .onReceive(timer) { time in
                        viewModel.updateTime()
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("COUNT DOWN APP").font(.headline)
                        Text("WE FOUND \(isPreferitiSection ? viewModel.listCountDownObject.items.count : viewModel.listCountDownObject.items.filter{$0.isPrefered == isPreferitiSection}.count) COUNTDOWNS").font(.subheadline)
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
