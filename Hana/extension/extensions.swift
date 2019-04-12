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

extension UIColor {
  convenience init(red: Int, green: Int, blue: Int) {
    assert(red >= 0 && red <= 255, "Invalid red component")
    assert(green >= 0 && green <= 255, "Invalid green component")
    assert(blue >= 0 && blue <= 255, "Invalid blue component")
    
    self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
  }
  
  convenience init(rgb: Int) {
    self.init(
      red: (rgb >> 16) & 0xFF,
      green: (rgb >> 8) & 0xFF,
      blue: rgb & 0xFF
    )
  }
  
  
  struct appColor {
    static let defaultAndroidColor = UIColor(rgb: 0x6200EE)
    static let Primary = UIColor(rgb: 0x673AB7)
    static let PrimaryDark = UIColor(rgb: 0x512DA8)
    static let PrimaryLight = UIColor(rgb: 0xD1C4E9)
    static let PrimaryText = UIColor(rgb: 0x212121)
    static let Accent = UIColor(rgb: 0xFF5722)
    static let SecondaryText = UIColor(rgb: 0x757575)
    static let Divider = UIColor(rgb: 0xBDBDBD)
  }
}
