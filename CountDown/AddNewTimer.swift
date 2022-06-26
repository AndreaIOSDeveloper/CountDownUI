//
//  AddNewTimer.swift
//  CountDown
//
//  Created by Di Francia, Andrea (Contractor) on 26/06/22.
//

import Foundation
import SwiftUI

struct AddNewTimer: View {
    @Binding var presentedAsModal: Bool

    @StateObject private var viewModel = DataViewModel.shared
    
    var body: some View {
        Button("dismiss") { self.presentedAsModal = false }
    }
}

struct AddNewTimer_Previews: PreviewProvider {
    static var previews: some View {
        AddNewTimer(presentedAsModal: .constant(true))
    }
}
