//
//  BasicTextField.swift
//  Foodics
//
//  Created by Ahmed Ramy on 10/1/20.
//  Copyright © 2020 Foodics. All rights reserved.
//

import UIKit.UIFont
import UIKit.UIImage
import SnapKit


public protocol TextFieldComponentUI where Self: UIView {
  var state: UITextField.State! { get set }
  var placeholder: String? { get set }
  var text: String? { get set }
  var helperText: String? { get set }
  var keyboardType: UIKeyboardType! { get set }
  var isSecureEntry: Bool! { get set }
  var leadingIconImage: UIImage? { get set }
  var trailingIconImage: UIImage? { get set }
  var onInput: ((String?) -> Void)? { get set }
  var onLeadingIconTap: VoidCallback? { get set }
  var onTrailingIconTap: VoidCallback? { get set }
}

class BasicTextField: UIView, TextFieldComponentUI {
  
  var state: UITextField.State! = .inactive {
    didSet {
      updateState()
    }
  }
  
  var placeholder: String? {
    didSet {
      self.textField.attributedPlaceholder = NSAttributedStringBuilder()
        .add(text: placeholder ?? "")
        .add(foregroundColor: R.color.textFieldPlaceholderTextColor() ?? .red)
        .build()
    }
  }
  
  var text: String? {
    didSet {
      self.textField.text = text
    }
  }
  
  var helperText: String? {
    didSet {
      self.hintLabel.text = helperText
    }
  }
  
  var keyboardType: UIKeyboardType! {
    didSet {
      self.textField.keyboardType = keyboardType
      if keyboardType == .emailAddress {
        respectsLanguageSemantics = false
      }
    }
  }
  
  var isSecureEntry: Bool! {
    didSet {
      self.textField.isSecureTextEntry = isSecureEntry
    }
  }
  
  var trailingIconImage: UIImage? {
    didSet {
      updateState()
    }
  }
  
  var leadingIconImage: UIImage? {
    didSet {
      updateState()
    }
  }
  
  var onLeadingIconTap: VoidCallback? {
    didSet {
      updateState()
    }
  }
  
  var onTrailingIconTap: VoidCallback? {
    didSet {
      updateState()
    }
  }
  
  var respectsLanguageSemantics: Bool = true {
    didSet {
      guard !respectsLanguageSemantics, self.textField.textAlignment != .center else { return }
      self.textField.textAlignment = .left
    }
  }
  
  var returnAction: VoidCallback?
  
  var onInput: ((String?) -> Void)?
  
  let borderView = UIView().then {
    $0.backgroundColor = R.color.textFieldBackgroundColor()
    $0.borderWidth = Dimensions.TextFields.borderWidth
    $0.borderColor = R.color.textFieldBorderColor()
    $0.cornerRadius = Dimensions.TextFields.cornerRadius
  }
  
  let textField = UITextField().then {
    $0.borderStyle = .none
    $0.setPlaceHolderTextColor(R.color.textFieldPlaceholderTextColor() ?? .red)
    $0.font = TextStyles.body
    $0.textColor = R.color.textFieldTextColor()
  }
  
  let hintLabel = UILabel().then {
    $0.textColor = R.color.textFieldHintColor()
    $0.font = TextStyles.caption2
  }
  
  let stackView = UIStackView().then {
    $0.alignment = .fill
    $0.axis = .vertical
    $0.distribution = .fill
    $0.spacing = 8
  }
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    initialize()
  }
  
  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    initialize()
  }
  
  func updateState() {
    switch state {
    case .inactive, .focused:
      hintLabel.textColor = R.color.textFieldHintColor()
      hintLabel.text = helperText
      borderView.borderColor = R.color.textFieldBorderColor()
      let direction: UITextField.Direction = UserSettingsService.shared.language.value ?? .english == .arabic ? .left : .right
      guard let desiredImage = direction == .right ? trailingIconImage : leadingIconImage else { return }
      let desiredAction = direction == .right ? onTrailingIconTap : onLeadingIconTap
      textField.icon(direction: direction, image: desiredImage,
                     tintColor: R.color.textFieldPrimaryIconColor() ?? .red,
                     action: desiredAction)
    case .error(let message):
      borderView.shake()
      borderView.borderColor = R.color.textFieldErrorBorderColor()
      hintLabel.textColor = R.color.textFieldErrorHintColor()
      hintLabel.text = message
      let direction: UITextField.Direction = UserSettingsService.shared.language.value ?? .english == .arabic ? .left : .right
      guard let desiredImage = direction == .right ? trailingIconImage : leadingIconImage else { return }
      let desiredAction = direction == .right ? onTrailingIconTap : onLeadingIconTap
      textField.icon(direction: direction, image: desiredImage,
                     tintColor: R.color.textFieldErrorIconColor() ?? .red,
                     action: desiredAction)
    case .disabled:
      // TODO: - Implement if needed
      break
    
    default:
      break
    }
  }
}

private extension BasicTextField {
  func initialize() {
    setupViews()
    setupConstraints()
    updateState()
  }
  
  func setupViews() {
    self.backgroundColor = .clear
    textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    textField.addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
    textField.addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
    textField.addTarget(self, action: #selector(editingDidEnd), for: .editingDidEndOnExit)
    textField.delegate = self
    addSubview(stackView)
    
    stackView.addArrangedSubview(borderView)
    stackView.addArrangedSubview(hintLabel)
    
    borderView.addSubview(textField)
  }
  
  func setupConstraints() {
    stackView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
    
    textField.snp.makeConstraints { (make) in
      make.top.bottom.equalToSuperview().inset(16)
      make.leading.trailing.equalToSuperview().inset(14)
    }
  }
  
  @objc func textDidChange() {
    onInput?(textField.text)
  }
  
  @objc func editingDidBegin() {
    state = .focused
  }
  
  @objc func editingDidEnd() {
    state = .inactive
  }
}

extension BasicTextField: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    returnAction?()
    return true
  }
}
