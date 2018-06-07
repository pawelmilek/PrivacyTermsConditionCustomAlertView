//
//  PrivacyTermsConditionAlertViewController.swift
//  PrivacyTermsConditionCustomAlertView
//
//  Created by Pawel Milek on 07/06/2018.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import UIKit

class PrivacyTermsAlertController: UIViewController {
  @IBOutlet weak var alertView: UIView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var cancelButton: UIButton!
  @IBOutlet weak var agreeButton: UIButton!
  @IBOutlet weak var firstTermDescriptionLabel: UILabel!
  @IBOutlet weak var secondTermDescriptionLabel: UILabel!
  @IBOutlet weak var firstTermsSwitch: UISwitch!
  @IBOutlet weak var secondTermsSwitch: UISwitch!
  
  private let titleDescription = "Terms and Conditions"
  private let firstTermsMessage = "I Agree to the License Terms and Privacy Policy"
  private let secondTermsMessage = "I Agree to the iOS, iCloud and Game Center Terms and Conditions and the Apple Privacy Policy"
  
  private var selectedTerms = [[PrivacyTermsKey.firstTerms: false], [PrivacyTermsKey.secondTerms: false]] {
    didSet {
      let firstTerms = selectedTerms.first?[PrivacyTermsKey.firstTerms] ?? false
      let secondTerms = selectedTerms.last?[PrivacyTermsKey.secondTerms] ?? false
      agreeButton.isEnabled = (firstTerms && secondTerms)
    }
  }
  
  weak var delegate: PrivacyTermsAlertControllerDelegate?
  
  
  convenience init() {
    self.init(nibName: "PrivacyTermsAlertController", bundle: nil)
    providesPresentationContextTransitionStyle = true
    definesPresentationContext = true
    modalPresentationStyle = .overCurrentContext
    modalTransitionStyle = .crossDissolve
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupStyle()
    setupLayout()
  }
}


// MARK: - Private - Setup
private extension PrivacyTermsAlertController {
  
  func setup() {
    firstTermsSwitch.tag = 0
    secondTermsSwitch.tag = 1
    firstTermsSwitch.addTarget(self, action: #selector(onTapSwitchButton(_:)), for: .valueChanged)
    secondTermsSwitch.addTarget(self, action: #selector(onTapSwitchButton(_:)), for: .valueChanged)
    
    cancelButton.addTarget(self, action: #selector(onTapCancelButton), for: .touchUpInside)
    agreeButton.addTarget(self, action: #selector(onTapAgreeButton), for: .touchUpInside)
    agreeButton.isEnabled = false
  }
  
  func setupStyle() {
     let alertViewGrayColor = UIColor(red: 224.0/255.0, green: 224.0/255.0, blue: 224.0/255.0, alpha: 1)
    alertView.layer.cornerRadius = 15
    alertView.backgroundColor = .white
    view.backgroundColor = UIColor.black.withAlphaComponent(0.4)

    cancelButton.addBorder(at: .top, with: alertViewGrayColor, width: 1)
    cancelButton.addBorder(at: .right, with: alertViewGrayColor, width: 1)
    agreeButton.addBorder(at: .top, with: alertViewGrayColor, width: 1)
  }
  
  func setupLayout() {
    alertView.alpha = 0
    alertView.frame.origin.y = alertView.frame.origin.y + 100
    
    UIView.animate(withDuration: 0.4) {
      self.alertView.alpha = 1
      self.alertView.frame.origin.y = self.alertView.frame.origin.y - 100
    }
  }
  
}


// MARK: - Actions
extension PrivacyTermsAlertController {
  
  @objc func onTapCancelButton() {
    delegate?.didPressCancelButton()
    self.dismiss(animated: true, completion: nil)
  }
  
  @objc func onTapAgreeButton() {
    delegate?.didPressAgreeButton(with: selectedTerms)
    self.dismiss(animated: true, completion: nil)
  }
  
  @objc func onTapSwitchButton(_ sender: UISwitch) {
    let key = (sender.tag == 0 ? PrivacyTermsKey.firstTerms : PrivacyTermsKey.secondTerms)
    selectedTerms[sender.tag][key] = sender.isOn
  }
  
}
