//
//  OrderListView.swift
//  CountDown
//
//  Created by Di Francia, Andrea (Contractor) on 27/06/22.
//

import Foundation
import SwiftUI

struct OrderListType: Hashable {
    var tag: String
    var isCheck: Bool
}

struct OrderListView: View {
    @StateObject private var viewModel = DataViewModel.shared

    @Binding var presentedAsModal: Bool
    @Binding var nActiveFiltri: Int

    @State private var selection = Set<String>()
    @State private var removeAllCheck = false
    
    init(presentedAsModal: Binding<Bool>, nActiveFiltri: Binding<Int>) {
        self._presentedAsModal = presentedAsModal
        self._nActiveFiltri = nActiveFiltri
    }
    
    var body: some View {
        Spacer()
        Section(header: Text("Select tag for order your count down list")) {
            List(viewModel.arraytag, id: \.self, selection: $selection) { item in
                Button {
                    DispatchQueue.main.async {
                        viewModel.arraytag.enumerated().forEach { idx, newitem in
                            if newitem == item {
                                if newitem != viewModel.arraytag.first {
                                    viewModel.arraytag[0].isCheck = false
                                    removeAllCheck = false
                                    viewModel.arraytag[idx].isCheck = !viewModel.arraytag[idx].isCheck
                                } else {
                                    removeAllCheck = true
                                    viewModel.arraytag[idx].isCheck = true
                                }
                            }
                            
                            if removeAllCheck && idx != 0 {
                                viewModel.arraytag[idx].isCheck = false
                            }
                        }
                        
                        nActiveFiltri = viewModel.arraytag.filter{$0.isCheck == true && $0.tag != "All"}.count
                    }
                } label: {
                    HStack {
                        Text(item.tag)
                            .foregroundColor(.primary)
                        Spacer()
                        if item.isCheck {
                            Image(systemName: "checkmark")
                                .foregroundColor(.primary)
                        }
                    }
                }
            }
            
            LargeButton(title: "Save",
                        backgroundColor: .black) {
                self.presentedAsModal = false
            }
            Spacer()
        }
    }
}

struct  OrderListView_Previews: PreviewProvider {
    static var previews: some View {
        OrderListView(presentedAsModal: .constant(true), nActiveFiltri: .constant(0))
    }
}
