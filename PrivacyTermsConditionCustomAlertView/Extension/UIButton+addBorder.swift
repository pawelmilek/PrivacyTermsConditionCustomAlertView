//
//  UIButton+addBorder.swift
//  PrivacyTermsConditionCustomAlertView
//
//  Created by Pawel Milek on 07/06/2018.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import UIKit

enum UIButtonBorderSide {
  case top
  case bottom
  case left
  case right
}


extension UIButton {
  
  func addBorder(at side: UIButtonBorderSide, with color: UIColor, width: CGFloat) {
    let border = CALayer()
    border.backgroundColor = color.cgColor
    
    switch side {
    case .top:
      border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: width)
      
    case .bottom:
      border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
      
    case .left:
      border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
      
    case .right:
      border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
    }
    
    self.layer.addSublayer(border)
  }
}
