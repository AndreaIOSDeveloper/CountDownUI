//
//  ListCard.swift
//  CountDown
//
//  Created by Andrea Di Francia on 15/06/22.
//

import Foundation
import SwiftUI

struct ListCard: View {
    @StateObject private var viewModel = DataViewModel()

    private var colorCard: Color = .red
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init(colorCard: Color = .red) {
        self.colorCard = colorCard
        
        // $viewModel.listCountDownObject.items.forEach { $item in
        //     debugPrint($item)
        //     item.colorCard = colorCard
        // }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer(minLength: 40)
                List ($viewModel.listCountDownObject.items) { $item in
                    CardTimer(object: item)
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
                        Text("WE FOUND \(viewModel.listCountDownObject.items.count) COUNTDOWNS").font(.subheadline)
                    }
                }
            }
        }
    }
}

struct ListCard_Previews: PreviewProvider {
    static var previews: some View {
        ListCard()
    }
}
