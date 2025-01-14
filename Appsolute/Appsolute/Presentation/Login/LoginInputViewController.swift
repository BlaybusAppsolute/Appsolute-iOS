//
//  LoginInputViewController.swift
//  Appsolute
//
//  Created by 권민재 on 1/14/25.
//
import UIKit
import SnapKit
import Then

class LoginInputViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel = LoginViewModel()
    
    // MARK: - UI Components
    private let idTitleLabel = UILabel().then {
        $0.text = "ID"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.textColor = .black
    }
    
    private let idTextField = CustomTextField().then {
        $0.setPlaceholder("아이디를 입력하세요.")
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
        $0.layer.masksToBounds = true
    }
    
    private let idErrorLabel = UILabel().then {
        $0.text = "아이디가 옳지 않습니다."
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .red
        $0.isHidden = true
    }
    
    private let passwordTitleLabel = UILabel().then {
        $0.text = "비밀번호"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.textColor = .black
    }
    
    private let passwordTextField = CustomTextField().then {
        $0.setPlaceholder("비밀번호를 입력하세요.")
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
        $0.layer.masksToBounds = true
    }
    
    private let passwordErrorLabel = UILabel().then {
        $0.text = "비밀번호가 옳지 않습니다."
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .red
        $0.isHidden = true
    }
    
    private let confirmButton = UIButton().then {
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor(hex: "1073f4")
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.layer.cornerRadius = 16
        $0.layer.masksToBounds = true
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "DCEBFF")
        
        setupViews()
        setupConstraints()
        setupActions()
    }
    
    // MARK: - Setup
    private func setupViews() {
        view.addSubview(idTitleLabel)
        view.addSubview(idTextField)
        view.addSubview(idErrorLabel)
        view.addSubview(passwordTitleLabel)
        view.addSubview(passwordTextField)
        view.addSubview(passwordErrorLabel)
        view.addSubview(confirmButton)
    }
    
    private func setupConstraints() {
        idTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(44)
            make.leading.equalToSuperview().offset(20)
        }
        
        idTextField.snp.makeConstraints { make in
            make.top.equalTo(idTitleLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(56)
        }
        
        idErrorLabel.snp.makeConstraints { make in
            make.top.equalTo(idTextField.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(20)
        }
        
        passwordTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(idErrorLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTitleLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(56)
        }
        
        passwordErrorLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(20)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(70)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(56)
        }
    }
    
    private func setupActions() {
        confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
    }
    private func navigateToTabBar() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil) // 스토리보드 파일 이름
        guard let tabBarVC = storyboard.instantiateViewController(withIdentifier: "TabbarViewController") as? TabbarViewController else {
            print("TabbarViewController를 찾을 수 없습니다.")
            return
        }
        
        tabBarVC.modalPresentationStyle = .fullScreen
        present(tabBarVC, animated: true)
    }

    
    @objc private func confirmButtonTapped() {
        guard let userId = idTextField.getText(), !userId.isEmpty else {
            showError(message: "아이디를 입력하세요.", for: idErrorLabel)
            return
        }
        
        guard let password = passwordTextField.getText(), !password.isEmpty else {
            showError(message: "비밀번호를 입력하세요.", for: passwordErrorLabel)
            return
        }
        
        idErrorLabel.isHidden = true
        passwordErrorLabel.isHidden = true
        
        viewModel.login(
            userId: userId,
            password: password,
            onSuccess: { [weak self] response in
                DispatchQueue.main.async {
                    AppKey.token = response.jwtToken
                    self?.navigateToTabBar()
                }
            },
            onFailure: { [weak self] errorMessage in
                DispatchQueue.main.async {
                    self?.handleLoginError(message: errorMessage)
                }
            }
        )
    }
    
    private func showError(message: String, for label: UILabel) {
        label.text = message
        label.isHidden = false
    }
    
    private func handleLoginError(message: String) {
        if message.contains("아이디") {
            showError(message: message, for: idErrorLabel)
        } else if message.contains("비밀번호") {
            showError(message: message, for: passwordErrorLabel)
        } else {
            let alert = UIAlertController(title: "오류", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            present(alert, animated: true)
        }
    }
    
    private func showSuccess(message: String) {
        let alert = UIAlertController(title: "성공", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}
