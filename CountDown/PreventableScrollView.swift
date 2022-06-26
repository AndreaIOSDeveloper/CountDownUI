//
//  PreventableScrollView.swift
//  CountDown
//
//  Created by Di Francia, Andrea (Contractor) on 26/06/22.
//

import Foundation
import SwiftUI

struct PreventableScrollView<Content>: View where Content: View {
    @Binding var canScroll: Bool
    var content: () -> Content
    
    var body: some View {
        if canScroll {
            ScrollView(.vertical, showsIndicators: false, content: content)
        } else {
            content()
        }
    }
}
