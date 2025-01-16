//
//  ChangePasswordViewController.swift
//  Appsolute
//
//  Created by 권민재 on 1/15/25.
//
import UIKit
import SnapKit
import Then
import Moya

class ChangePasswordViewController: UIViewController {
    
    // MARK: - Properties
    private let currentPasswordTextField = CustomTextField().then {
        $0.setPlaceholder("현재 비밀번호")
    }
    
    private let currentPasswordErrorLabel = UILabel().then {
        $0.text = "현재 비밀번호가 틀렸습니다."
        $0.textColor = .red
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.numberOfLines = 0
        $0.alpha = 0 // 기본적으로 숨김 처리
    }
    
    private let newPasswordTextField = CustomTextField().then {
        $0.setPlaceholder("새 비밀번호")
    }
    
    private let newPasswordHintLabel = UILabel().then {
        $0.text = "영문, 숫자, 특수문자 포함 8자 이상"
        $0.textColor = .gray
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    
    private let newPasswordErrorLabel = UILabel().then {
        $0.text = "비밀번호는 영문, 숫자, 특수문자를 포함한 8자 이상이어야 합니다."
        $0.textColor = .red
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.numberOfLines = 0
        $0.alpha = 0 // 기본적으로 숨김 처리
    }
    
    private let confirmPasswordTextField = CustomTextField().then {
        $0.setPlaceholder("새 비밀번호 확인")
    }
    
    private let confirmPasswordErrorLabel = UILabel().then {
        $0.text = "비밀번호가 일치하지 않습니다."
        $0.textColor = .red
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.numberOfLines = 0
        $0.alpha = 0 // 기본적으로 숨김 처리
    }
    
    private let cancelButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.setTitleColor(UIColor(hex: "1073f4"), for: .normal)
        $0.backgroundColor = UIColor(hex: "cbe0fd")
        $0.layer.cornerRadius = 10
    }
    
    private let confirmButton = UIButton().then {
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor(hex: "1073F4")
        $0.layer.cornerRadius = 10
    }
    
    private let provider = MoyaProvider<UserAPI>() // Moya provider

    // MARK: - Lifecycle
    override func viewDidLoad() {
        title = "비밀번호 변경"
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "DCEBFF")
        
        setupView()
        setupLayout()
        setupActions()
    }
    
    // MARK: - Setup
    private func setupView() {
        view.addSubview(currentPasswordTextField)
        view.addSubview(currentPasswordErrorLabel)
        view.addSubview(newPasswordTextField)
        view.addSubview(newPasswordHintLabel)
        view.addSubview(newPasswordErrorLabel)
        view.addSubview(confirmPasswordTextField)
        view.addSubview(confirmPasswordErrorLabel)
        view.addSubview(cancelButton)
        view.addSubview(confirmButton)
    }
    
    private func setupLayout() {
        currentPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(54)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        
        currentPasswordErrorLabel.snp.makeConstraints { make in
            make.top.equalTo(currentPasswordTextField.snp.bottom).offset(4)
            make.leading.trailing.equalTo(currentPasswordTextField)
        }
        
        newPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(currentPasswordErrorLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        
        newPasswordHintLabel.snp.makeConstraints { make in
            make.top.equalTo(newPasswordTextField.snp.bottom).offset(4)
            make.leading.trailing.equalTo(newPasswordTextField)
        }
        
        newPasswordErrorLabel.snp.makeConstraints { make in
            make.top.equalTo(newPasswordHintLabel.snp.bottom).offset(4)
            make.leading.trailing.equalTo(newPasswordTextField)
        }
        
        confirmPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(newPasswordErrorLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        
        confirmPasswordErrorLabel.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(4)
            make.leading.trailing.equalTo(confirmPasswordTextField)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(279)
            make.height.equalTo(50)
            make.width.equalTo(170)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(cancelButton)
            make.height.equalTo(50)
            make.width.equalTo(170)
        }
    }
    
    private func setupActions() {
        cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        confirmButton.addTarget(self, action: #selector(confirmTapped), for: .touchUpInside)
        
        // Add text editing observers
        currentPasswordTextField.textField.addTarget(self, action: #selector(validateFields), for: .editingChanged)
        newPasswordTextField.textField.addTarget(self, action: #selector(validateFields), for: .editingChanged)
        confirmPasswordTextField.textField.addTarget(self, action: #selector(validateFields), for: .editingChanged)
    }
    
    // MARK: - Actions
    @objc private func cancelTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func confirmTapped() {
        guard let currentPassword = currentPasswordTextField.getText(),
              let newPassword = newPasswordTextField.getText(),
              let confirmPassword = confirmPasswordTextField.getText() else { return }
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            
            // Validate inputs on a background thread
            let isValid = self.validateInputs(currentPassword: currentPassword, newPassword: newPassword, confirmPassword: confirmPassword)
            
            DispatchQueue.main.async {
                if isValid {
                    // Call API on the main thread after validation
                    self.changePassword(newPassword: newPassword)
                }
            }
        }
    }
    
    @objc private func validateFields() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            
            guard let newPassword = self.newPasswordTextField.getText(),
                  let confirmPassword = self.confirmPasswordTextField.getText() else { return }
            
            let isNewPasswordValid = self.isValidPassword(newPassword)
            let isPasswordMatching = newPassword == confirmPassword
            
            DispatchQueue.main.async {
                // Update UI on the main thread
                self.newPasswordErrorLabel.alpha = isNewPasswordValid ? 0 : 1
                self.confirmPasswordErrorLabel.alpha = isPasswordMatching ? 0 : 1
            }
        }
    }
    
    private func validateInputs(currentPassword: String, newPassword: String, confirmPassword: String) -> Bool {
        var isValid = true
        
        if !isValidPassword(newPassword) {
            DispatchQueue.main.async {
                self.showError(self.newPasswordErrorLabel)
            }
            isValid = false
        } else {
            DispatchQueue.main.async {
                self.hideError(self.newPasswordErrorLabel)
            }
        }
        
        if newPassword != confirmPassword {
            DispatchQueue.main.async {
                self.showError(self.confirmPasswordErrorLabel)
            }
            isValid = false
        } else {
            DispatchQueue.main.async {
                self.hideError(self.confirmPasswordErrorLabel)
            }
        }
        
        return isValid
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*?&#])[A-Za-z\\d$@$!%*?&#]{8,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: password)
    }
    
    private func changePassword(newPassword: String) {
        provider.request(.password(token: AppKey.token ?? "", password: newPassword)) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    if (200...299).contains(response.statusCode) {
                        self.showAlert(message: "비밀번호가 변경되었습니다.") {
                            self.navigationController?.popViewController(animated: true)
                        }
                    } else {
                        self.showAlert(message: "비밀번호 변경 실패. 상태 코드: \(response.statusCode)")
                    }
                case .failure(let error):
                    self.showAlert(message: "비밀번호 변경 실패: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func showError(_ label: UILabel) {
        UIView.animate(withDuration: 0.25) {
            label.alpha = 1
        }
    }
    
    private func hideError(_ label: UILabel) {
        UIView.animate(withDuration: 0.25) {
            label.alpha = 0
        }
    }
    
    private func showAlert(message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default) { _ in
            completion?()
        })
        present(alert, animated: true)
    }
}
