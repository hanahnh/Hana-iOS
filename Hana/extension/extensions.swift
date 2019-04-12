//
//  extensions.swift
//  Hana
//
//  Created by 김연준 on 12/04/2019.
//  Copyright © 2019 hanahnh. All rights reserved.
//

import Foundation

import UIKit

extension UIImage {
  func resized(newSize:CGSize) -> UIImage {
    UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)
    self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage!
  }
}
