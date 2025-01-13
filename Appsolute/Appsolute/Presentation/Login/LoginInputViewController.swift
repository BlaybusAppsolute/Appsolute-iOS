//
//  LoginInputViewController.swift
//  Appsolute
//
//  Created by 권민재 on 1/14/25.
//
import UIKit
import SnapKit
import Then

class CustomTextField: UIView {
    
    // MARK: - UI Components
    private let textField = UITextField().then {
        $0.font = UIFont.systemFont(ofSize: 20)
        $0.textColor = .black
        $0.borderStyle = .none
        $0.clearButtonMode = .never // 기본 Clear 버튼 비활성화
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
    }
    
    private let clearButton = UIButton().then {
        $0.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        $0.tintColor = UIColor.lightGray
        $0.isHidden = true // 기본적으로 숨김
    }
    
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
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
    
    // MARK: - State Handlers
    @objc private func textFieldDidChange() {
        // 입력 내용에 따라 Clear 버튼 표시
        clearButton.isHidden = textField.text?.isEmpty ?? true
    }
    
    
    
    @objc private func clearText() {
        // 텍스트 삭제 및 Clear 버튼 숨김
        textField.text = ""
        clearButton.isHidden = true
    }
    
    // MARK: - Public Methods
    func setPlaceholder(_ placeholder: String) {
        textField.placeholder = placeholder
    }
    
    func getText() -> String {
        return textField.text ?? ""
    }
}

class LoginInputViewController: UIViewController {
    
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
        $0.isHidden = true // 기본적으로 숨김
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
}
