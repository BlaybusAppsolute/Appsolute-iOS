//
//  CustomTextField.swift
//  Appsolute
//
//  Created by 권민재 on 1/14/25.
//


import UIKit
import SnapKit
import Then

class CustomTextField: UIView {
    
    // MARK: - UI Components
    let textField = UITextField().then {
        $0.font = UIFont.systemFont(ofSize: 20)
        $0.textColor = .black
        $0.borderStyle = .none
        $0.clearButtonMode = .never
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
    }
    
    private let clearButton = UIButton().then {
        $0.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        $0.tintColor = UIColor.lightGray
        $0.isHidden = true
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
        self.backgroundColor = .white
        setupViews()
        setupConstraints()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupViews() {
        addSubview(textField)
        addSubview(clearButton)
    }
    
    private func setupConstraints() {
        textField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalTo(clearButton.snp.leading).offset(-10)
            make.top.bottom.equalToSuperview().inset(10)
        }
        
        clearButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
    }
    
    private func setupActions() {
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        clearButton.addTarget(self, action: #selector(clearText), for: .touchUpInside)
    }
    
    @objc private func textFieldDidChange() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.clearButton.isHidden = self.textField.text?.isEmpty ?? true
        }
    }
    
    @objc private func clearText() {
        textField.text = ""
        clearButton.isHidden = true
    }
    
    // MARK: - Public Methods
    func setPlaceholder(_ placeholder: String) {
        textField.placeholder = placeholder
    }
    
    func getText() -> String? {
        return textField.text
    }
    
    func setText(_ text: String?) {
        textField.text = text
        textFieldDidChange()
    }
    
    func setKeyboardType(_ type: UIKeyboardType) {
        textField.keyboardType = type
    }
    
    func setSecureTextEntry(_ isSecure: Bool) {
        textField.isSecureTextEntry = isSecure
    }
}
