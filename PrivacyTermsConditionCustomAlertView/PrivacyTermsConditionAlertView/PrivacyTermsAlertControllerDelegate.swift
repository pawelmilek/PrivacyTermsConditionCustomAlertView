//
//  PrivacyTermsAlertControllerDelegate.swift
//  PrivacyTermsConditionCustomAlertView
//
//  Created by Pawel Milek on 07/06/2018.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import UIKit

protocol PrivacyTermsAlertControllerDelegate: class {
  func didPressAgreeButton(with selectedTerms: [[PrivacyTermsKey: Bool]])
  func didPressCancelButton()
}
