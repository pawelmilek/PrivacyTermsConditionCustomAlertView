//
//  PrivacyTermsAlertControllerCode.swift
//  PrivacyTermsConditionCustomAlertView
//
//  Created by Pawel Milek on 07/06/2018.
//  Copyright © 2018 Pawel Milek. All rights reserved.
//

import UIKit

class PrivacyTermsAlertControllerCode: UIViewController {
  private lazy var alertView: UIView = {
    let view = UIView(frame: .zero)
    
    view.layer.cornerRadius = 15
    view.backgroundColor = .white
    view.translatesAutoresizingMaskIntoConstraints = false
    view.widthAnchor.constraint(equalToConstant: 320).isActive = true
    view.heightAnchor.constraint(equalToConstant: 260).isActive = true
    return view
  }()
  
  private lazy var titleLabel: UILabel = {
    let label = UILabel(frame: .zero)
    let titleDescription = "Terms and Conditions"
    
    label.text = titleDescription
    label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
    label.textAlignment = .center
    label.numberOfLines = 1
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private lazy var cancelButton: UIButton = {
    let button = UIButton(frame: .zero)
    let title = "Cancel"
    let normalTitle = NSAttributedString(string: title, attributes: [.foregroundColor: UIColor.blue, .font: UIFont.systemFont(ofSize: 15, weight: .regular)])
    let highlightedTitle = NSAttributedString(string: title, attributes: [.foregroundColor: UIColor.lightGray, .font: UIFont.systemFont(ofSize: 15, weight: .regular)])
    
    button.setAttributedTitle(normalTitle, for: .normal)
    button.setAttributedTitle(highlightedTitle, for: .highlighted)
    button.addTarget(self, action: #selector(onTapCancelButton), for: .touchUpInside)
    return button
  }()
  
  private lazy var agreeButton: UIButton = {
    let button = UIButton(frame: .zero)
    let title = "Agree"
    let normalTitle = NSAttributedString(string: title, attributes: [.foregroundColor: UIColor.blue, .font: UIFont.systemFont(ofSize: 15, weight: .regular)])
    let disabledTitle = NSAttributedString(string: title, attributes: [.foregroundColor: UIColor.gray, .font: UIFont.systemFont(ofSize: 15, weight: .regular)])
    let highlightedTitle = NSAttributedString(string: title, attributes: [.foregroundColor: UIColor.lightGray, .font: UIFont.systemFont(ofSize: 15, weight: .regular)])
    
    button.setAttributedTitle(normalTitle, for: .normal)
    button.setAttributedTitle(disabledTitle, for: .disabled)
    button.setAttributedTitle(highlightedTitle, for: .highlighted)
    button.addTarget(self, action: #selector(onTapAgreeButton), for: .touchUpInside)
    button.isEnabled = false
    return button
  }()
  
  private lazy var buttonsStackView: UIStackView = {
    let stackView = UIStackView()
    
    stackView.axis = .horizontal
    stackView.alignment = .fill
    stackView.distribution = .fillEqually
    stackView.spacing = 0
    stackView.backgroundColor = .blue
    stackView.addArrangedSubview(cancelButton)
    stackView.addArrangedSubview(agreeButton)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    return stackView
  }()
  
  private lazy var firstTermDescriptionLabel: UILabel = {
    let label = UILabel(frame: .zero)
    let firstTermsMessage = "I Agree to the License Terms and Privacy Policy"
    
    label.text = firstTermsMessage
    label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
    label.textAlignment = .left
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    label.heightAnchor.constraint(equalToConstant: 36).isActive = true
    
    return label
  }()
  
  private lazy var secondTermDescriptionLabel: UILabel = {
    let label = UILabel(frame: .zero)
    let secondTermsMessage = "I Agree to the iOS, iCloud and Game Center Terms and Conditions and the Apple Privacy Policy"
    
    label.text = secondTermsMessage
    label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
    label.textAlignment = .left
    label.numberOfLines = 0
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private lazy var firstTermsSwitch: UISwitch = {
    let switchButton = UISwitch(frame: .zero)
    
    switchButton.tag = 0
    switchButton.addTarget(self, action: #selector(onTapSwitchButton(_:)), for: .valueChanged)
    switchButton.translatesAutoresizingMaskIntoConstraints = false
    switchButton.widthAnchor.constraint(equalToConstant: 49).isActive = true
    
    return switchButton
  }()
  
  private lazy var secondTermsSwitch: UISwitch = {
    let switchButton = UISwitch(frame: .zero)
    
    switchButton.tag = 1
    switchButton.addTarget(self, action: #selector(onTapSwitchButton(_:)), for: .valueChanged)
    switchButton.translatesAutoresizingMaskIntoConstraints = false
    switchButton.widthAnchor.constraint(equalToConstant: 49).isActive = true
    return switchButton
  }()

  
  private var selectedTerms = [[PrivacyTermsKey.firstTerms: false], [PrivacyTermsKey.secondTerms: false]] {
    didSet {
      let firstTerms = selectedTerms.first?[PrivacyTermsKey.firstTerms] ?? false
      let secondTerms = selectedTerms.last?[PrivacyTermsKey.secondTerms] ?? false
      agreeButton.isEnabled = (firstTerms && secondTerms)
    }
  }
  
  weak var delegate: PrivacyTermsAlertControllerDelegate?
  
  
  init() {
    super.init(nibName: nil, bundle: nil)
    providesPresentationContextTransitionStyle = true
    definesPresentationContext = true
    modalPresentationStyle = .overCurrentContext
    modalTransitionStyle = .crossDissolve
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
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
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    agreeButton.addBorder(at: .top, with: .separatorGray, width: 1)
    cancelButton.addBorder(at: .top, with: .separatorGray, width: 1)
    cancelButton.addBorder(at: .right, with: .separatorGray, width: 1)
  }
}


// MARK: - Private - Setup
private extension PrivacyTermsAlertControllerCode {
  
  func setup() {
    setViewsConstraints()
  }
  
  func setupStyle() {
    setDimViewBackground()
  }
  
  func setupLayout() {
    animatePresention()
  }
  
}

// MARK: - Private - Set views constraints
private extension PrivacyTermsAlertControllerCode {
  
  func setViewsConstraints() {
    view.addSubview(alertView)
    alertView.addSubview(titleLabel)
    alertView.addSubview(buttonsStackView)
    alertView.addSubview(firstTermsSwitch)
    alertView.addSubview(firstTermDescriptionLabel)
    alertView.addSubview(secondTermsSwitch)
    alertView.addSubview(secondTermDescriptionLabel)
    
    alertView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    
    titleLabel.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 5).isActive = true
    titleLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 5).isActive = true
    titleLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -5).isActive = true
    
    buttonsStackView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor).isActive = true
    buttonsStackView.trailingAnchor.constraint(equalTo: alertView.trailingAnchor).isActive = true
    buttonsStackView.bottomAnchor.constraint(equalTo: alertView.bottomAnchor).isActive = true
    
    firstTermsSwitch.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 5).isActive = true
    firstTermsSwitch.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 36).isActive = true
    
    firstTermDescriptionLabel.leadingAnchor.constraint(equalTo: firstTermsSwitch.trailingAnchor, constant: 10).isActive = true
    firstTermDescriptionLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -10).isActive = true
    firstTermDescriptionLabel.centerYAnchor.constraint(equalTo: firstTermsSwitch.centerYAnchor).isActive = true
    
    secondTermsSwitch.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 5).isActive = true
    secondTermsSwitch.topAnchor.constraint(equalTo: firstTermsSwitch.bottomAnchor, constant: 35).isActive = true
    
    secondTermDescriptionLabel.leadingAnchor.constraint(equalTo: secondTermsSwitch.trailingAnchor, constant: 10).isActive = true
    secondTermDescriptionLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -10).isActive = true
    secondTermDescriptionLabel.centerYAnchor.constraint(equalTo: secondTermsSwitch.centerYAnchor).isActive = true
  }
  
}


// MARK: - Private - Set dim view background
private extension PrivacyTermsAlertControllerCode {
  
  func setDimViewBackground() {
    view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
  }
  
}


// MARK: - Private - Set buttons target-action
private extension PrivacyTermsAlertControllerCode {
  
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
extension PrivacyTermsAlertControllerCode {
  
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
