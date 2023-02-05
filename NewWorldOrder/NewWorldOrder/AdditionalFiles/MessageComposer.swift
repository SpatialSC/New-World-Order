//
//  MessageComposer.swift
//  scdatingclub-ios
//
//  Created by Adam Novak on 2023/01/16.
//

import MessageUI

class MessageComposer: NSObject, MFMessageComposeViewControllerDelegate {

    var messageComposeVC: MFMessageComposeViewController!
    
    // A wrapper function to indicate whether or not a text message can be sent from the user's device
    func canSendText() -> Bool {
        return MFMessageComposeViewController.canSendText()
    }

    // Configures and returns a MFMessageComposeViewController instance
    func configuredMessageComposeViewController(recipients: [String], body: String) -> MFMessageComposeViewController {
        messageComposeVC = MFMessageComposeViewController()
        messageComposeVC.messageComposeDelegate = self  //  Make sure to set this property to self, so that the controller can be dismissed!
        messageComposeVC.recipients = recipients
        messageComposeVC.body = body
                
//        let sendButton = UIButton(frame: CGRect(x: 10, y: 22, width: 100, height: 40))
//        sendButton.setTitle("Schedule", for: .normal)
//        sendButton.setTitleColor(.systemBlue, for: .normal)
//        sendButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
//        sendButton.addTarget(self, action: #selector(scheduleButtonPressed), for: .touchUpInside)
//        messageComposeVC.view.addSubview(sendButton)
        return messageComposeVC
    }

    // MFMessageComposeViewControllerDelegate callback - dismisses the view controller when the user is finished with it
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        if result == .cancelled {
            controller.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func scheduleButtonPressed() {
        messageComposeVC.present(UIViewController(), animated: true)
    }
    
}
