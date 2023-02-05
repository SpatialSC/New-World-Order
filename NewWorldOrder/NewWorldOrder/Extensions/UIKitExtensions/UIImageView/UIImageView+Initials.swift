//
//  UIImageView+Initials.swift
//  mist-ios
//
//  Created by Adam Monterey on 8/7/22.
//

import UIKit

public extension UIImageView {

    func addInitials(initials: String, font: UIFont, textColor: UIColor, backgroundColor: UIColor? = nil) {
        if let color = backgroundColor {
            image = color.image(.init(width: self.frame.size.width * 2, height: self.frame.size.height * 2))
        }
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height))
        label.tag = 943
        label.center = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
        label.textAlignment = .center
        label.text = initials
        label.font = font
        label.textColor = textColor
        self.addSubview(label)
    }
    
    func removeInitials() {
        viewWithTag(943)?.removeFromSuperview()
    }
    
    func becomeInitialsImage(first: String, last: String?) {
//        frame.size = .init(width: 45, height: 45)
        
        var initials = ""
        if let firstChar = first.uppercased().first {
            initials = String(firstChar)
        }
        if let last, let lastChar = last.uppercased().first {
            initials += "\(lastChar)"
        }
        
        addInitials(initials: initials,
                    font: AppFont.medium.size(20),
                    textColor: .customWhite,
                    backgroundColor: .systemGray)
    }
}


