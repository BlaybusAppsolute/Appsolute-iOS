//
//  ChangePasswordViewController.swift
//  Appsolute
//
//  Created by 권민재 on 1/15/25.
//
import UIKit
import SnapKit
import Then

class ChangePasswordViewController: UIViewController {
    
    // MARK: - Properties
    private let currentPasswordTextField = CustomTextField().then {
        $0.setPlaceholder("현재 비밀번호")
    }
    
    private let currentPasswordErrorLabel = UILabel().then {
        $0.text = "비밀번호가 틀렸습니다."
        $0.textColor = .red
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.isHidden = true // 기본적으로 숨김 처리
    }
    
    private let newPasswordTextField = CustomTextField().then {
        $0.setPlaceholder("새 비밀번호")
    }
    
    private let newPasswordHintLabel = UILabel().then {
        $0.text = "영문, 숫자, 특수문자 포함 8자 이상"
        $0.textColor = .gray
        $0.font = UIFont.systemFont(ofSize: 12)
    }
    
    private let confirmPasswordTextField = CustomTextField().then {
        $0.setPlaceholder("새 비밀번호 확인")
    }
    
    private let confirmPasswordErrorLabel = UILabel().then {
        $0.text = "비밀번호가 일치하지 않습니다."
        $0.textColor = .red
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.isHidden = true // 기본적으로 숨김 처리
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
            make.leading.equalTo(currentPasswordTextField)
        }
        
        newPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(currentPasswordErrorLabel.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        
        newPasswordHintLabel.snp.makeConstraints { make in
            make.top.equalTo(newPasswordTextField.snp.bottom).offset(4)
            make.leading.equalTo(newPasswordTextField)
        }
        
        confirmPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(newPasswordHintLabel.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        
        confirmPasswordErrorLabel.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(4)
            make.leading.equalTo(confirmPasswordTextField)
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
    }
    
    // MARK: - Actions
    @objc private func cancelTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func confirmTapped() {
        // 비밀번호 검증 로직 추가
        if currentPasswordTextField.getText()?.isEmpty == true {
            currentPasswordErrorLabel.isHidden = false
        } else {
            currentPasswordErrorLabel.isHidden = true
        }
        
        if newPasswordTextField.getText() != confirmPasswordTextField.getText() {
            confirmPasswordErrorLabel.isHidden = false
        } else {
            confirmPasswordErrorLabel.isHidden = true
        }
    }
}
