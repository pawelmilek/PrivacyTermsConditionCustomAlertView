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
    setTermsAndTitleDescription()
    setTargetActionForButtonsAndSwitches()
  }
  
  func setupStyle() {
    setAlertViewStyle()
    setDimViewBackground()
    setButtonsBorder()
  }
  
  func setupLayout() {
    disableAgreeButton()
    animatePresention()
  }
  
}


// MARK: - Private - Set Target-Action for buttons and switches
private extension PrivacyTermsAlertController {
  
  func setTargetActionForButtonsAndSwitches() {
    firstTermsSwitch.addTarget(self, action: #selector(onTapSwitchButton(_:)), for: .valueChanged)
    secondTermsSwitch.addTarget(self, action: #selector(onTapSwitchButton(_:)), for: .valueChanged)
    firstTermsSwitch.tag = 0
    secondTermsSwitch.tag = 1
    
    cancelButton.addTarget(self, action: #selector(onTapCancelButton), for: .touchUpInside)
    agreeButton.addTarget(self, action: #selector(onTapAgreeButton), for: .touchUpInside)
  }
  
}


// MARK: - Private - Set alert view style
private extension PrivacyTermsAlertController {
  
  func setTermsAndTitleDescription() {
    titleLabel.text = titleDescription
    firstTermDescriptionLabel.text = firstTermsMessage
    secondTermDescriptionLabel.text = secondTermsMessage
  }
  
  
  func setAlertViewStyle() {
    alertView.layer.cornerRadius = 15
    alertView.backgroundColor = .white
  }
  
}


// MARK: - Private - Set dim view background
private extension PrivacyTermsAlertController {
  
  func setDimViewBackground() {
    view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
  }
  
}


// MARK: - Private - Set buttons style
private extension PrivacyTermsAlertController {
  
  func setButtonsBorder() {
    cancelButton.addBorder(at: .top, with: .separatorGray, width: 0.5)
    cancelButton.addBorder(at: .right, with: .separatorGray, width: 0.5)
    agreeButton.addBorder(at: .top, with: .separatorGray, width: 0.5)
  }
  
  func disableAgreeButton() {
    agreeButton.isEnabled = false
  }
  
}



// MARK: - Private - Animate presention
private extension PrivacyTermsAlertController {
  
  func animatePresention() {
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
