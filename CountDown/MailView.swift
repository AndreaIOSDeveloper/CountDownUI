//
//  MailView.swift
//  CountDown
//
//  Created by Di Francia, Andrea (Contractor) on 12/07/22.
//

import Foundation
import SwiftUI
import MessageUI

struct MailComposeViewController: UIViewControllerRepresentable {
    
    var toRecipients: [String]
    var mailBody: String
    
    var didFinish: ()->()
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<MailComposeViewController>) -> MFMailComposeViewController {
        
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = context.coordinator
        mail.setToRecipients(self.toRecipients)
        mail.setMessageBody(self.mailBody, isHTML: true)
        
        return mail
    }
    
    final class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        
        var parent: MailComposeViewController
        
        init(_ mailController: MailComposeViewController) {
            self.parent = mailController
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            parent.didFinish()
            controller.dismiss(animated: true)
        }
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: UIViewControllerRepresentableContext<MailComposeViewController>) {
        
    }
}

struct MailView: View {
    @State private var showingMail = false
    
    var body: some View {
        VStack {
            Button("Contact us") {
                self.showingMail.toggle()
            }
        }
        .sheet(isPresented: $showingMail) {
            MailComposeViewController(toRecipients: ["andrea.difrancia92@gmail.com"], mailBody: "I wanted to report...") {
                // Did finish action
            }
        }
    }
}
