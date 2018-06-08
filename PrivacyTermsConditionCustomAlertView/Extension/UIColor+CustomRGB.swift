//
//  UIColor+CustomRGB.swift
//  PrivacyTermsConditionCustomAlertView
//
//  Created by Pawel Milek on 07/06/2018.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import UIKit

extension UIColor {
  
  static var separatorGray: UIColor {
    return colorRGB(component: (red: CGFloat(224), green: CGFloat(224), blue: CGFloat(224)))
  }
  
  static private func colorRGB(component: (red: CGFloat, green: CGFloat, blue: CGFloat), alpha: CGFloat = 1.0) -> UIColor {
    return UIColor(red: component.red/255, green: component.green/255, blue: component.blue/255, alpha: alpha)
  }
  
}
