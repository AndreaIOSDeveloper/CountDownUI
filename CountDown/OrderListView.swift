//
//  OrderListView.swift
//  CountDown
//
//  Created by Di Francia, Andrea (Contractor) on 27/06/22.
//

import Foundation
import SwiftUI

struct OrderListView: View {
    @StateObject private var viewModel = DataViewModel.shared

    @Binding var presentedAsModal: Bool
   
    var array: [TAG] = [.other, .tv, .travel, .game, .event, .sport, .movies]
    init(presentedAsModal: Binding<Bool>) {
        self._presentedAsModal = presentedAsModal
  
    }
    
    var body: some View {
        Section(header: Text("Order list in base of tag")) {
            
            List(array) { item in
                Text(item.title())
            }
        }
    }
}

struct  OrderListView_Previews: PreviewProvider {
    static var previews: some View {
        OrderListView(presentedAsModal: .constant(true))
    }
}
