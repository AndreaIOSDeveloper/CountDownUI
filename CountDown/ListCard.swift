//
//  ListCard.swift
//  CountDown
//
//  Created by Andrea Di Francia on 15/06/22.
//

import Foundation
import SwiftUI

struct ListCard: View {
    @State var items: [CountDownObject]
    @StateObject private var viewModel = DataViewModel()
    @Binding private var viewModelBinding: DataViewModel
    
    private var colorCard: Color = .red
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private var isPreferitiSection: Bool = false

    init(data: Binding<DataViewModel>, model: DataViewModel, isPreferitiSection: Bool) {
        self._viewModelBinding = data
        self.isPreferitiSection = isPreferitiSection
        
        items = isPreferitiSection ? model.listCountDownObject.items.filter{$0.isPrefered == true} : model.listCountDownObject.items
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer(minLength: 40)
                List(items) { item in
                    CardTimer(object: item) {
                        items.enumerated().forEach { index, itemSel in
                            if itemSel == item {
                                viewModel.listCountDownObject.items[index].preferedDidTap()
                                debugPrint("DidTap on: \(item)")
                                debugPrint("⚠️DidTap on: \(viewModel.listCountDownObject.items[index])")
                            }
                        }
                        
                        viewModel.listCountDownObject.items = items
                    }
                }
                .buttonStyle(PlainButtonStyle()) // Remove cell style
                .onReceive(timer) { time in
                    viewModel.updateTime()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("COUNT DOWN APP").font(.headline)
                        Text("WE FOUND \(items.count) COUNTDOWNS").font(.subheadline)
                    }
                }
            }
        }
    }
}

struct ListCard_Previews: PreviewProvider {
    static var previews: some View {
        ListCard(data: .constant(DataViewModel()), model: DataViewModel(), isPreferitiSection: false)
    }
}
