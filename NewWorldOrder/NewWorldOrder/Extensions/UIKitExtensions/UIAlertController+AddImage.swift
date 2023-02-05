//
//  UIAlertController+AddImage.swift
//  scdatingclub-ios
//
//  Created by Adam Novak on 2023/01/07.
//

import UIKit

extension UIAlertController {

    func addImage(image: UIImage) {
        
        let maxSize = CGSize(width: 246, height: 350)
        
        let imgSize = image.size
        var ratio:CGFloat!
        ratio = maxSize.width / imgSize.width
        
        if (imgSize.height > maxSize.height){
            let heightRatio = maxSize.height / imgSize.height
            ratio = min(heightRatio, ratio)
        }
        
        let scaleSize = CGSize(width: imgSize.width*ratio, height: imgSize.height*ratio)
        var resizedImage = image.imageWithSize(scaleSize)
        
        if (imgSize.height > imgSize.width) {
            let left = (maxSize.width - resizedImage.size.width) / 2
            resizedImage = resizedImage.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: -left, bottom: 0, right: 0))
        }
        
        let imgAction = UIAlertAction(title: "", style: .default, handler: nil)
        imgAction.isEnabled = false
        imgAction.setValue(resizedImage.withRenderingMode(.alwaysOriginal), forKey: "image")
        
        self.addAction(imgAction)
    }

}
