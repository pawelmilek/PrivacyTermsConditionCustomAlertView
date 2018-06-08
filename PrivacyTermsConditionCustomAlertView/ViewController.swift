//
//  ViewController.swift
//  PrivacyTermsConditionCustomAlertView
//
//  Created by Pawel Milek on 07/06/2018.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  
  @IBAction func testCustomAlertCreatedInCodeTapped(_ sender: UIButton) {
    let customAlert = PrivacyTermsAlertControllerCode()
    customAlert.delegate = self
    present(customAlert, animated: true, completion: nil)
  }
  
  
  @IBAction func testCustomAlertTapped(_ sender: UIButton) {
    let customAlert = PrivacyTermsAlertController()
    customAlert.delegate = self
    present(customAlert, animated: true, completion: nil)
  }
  
}


// MARK: PrivacyTermsConditionAlertControllerDelegate protocol
extension ViewController: PrivacyTermsAlertControllerDelegate {
  
  func didPressAgreeButton(with selectedTerms: [[PrivacyTermsKey: Bool]]) {
    // TODO: Handle action
    print("didPressAgreeButton")
  }
  
  func didPressCancelButton() {
    // TODO: Handle action
    print("didPressCancelButton")
  }
  
}
