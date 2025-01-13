//
//  LoginViewController.swift
//  Appsolute
//
//  Created by 권민재 on 1/14/25.
//

import UIKit
import SnapKit
import Then

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "1073f4")
        
        setupViews()
        setupConstraints()
        adminLoginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        employeeLoginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - UI Components
    private let employeeLoginButton = UIButton().then {
        $0.setTitle("직원 로그인", for: .normal)
        $0.setTitleColor(UIColor(hex: "073066"), for: .normal)
        $0.backgroundColor = .white
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.layer.cornerRadius = 16
        $0.layer.masksToBounds = true
        
    }
    
    private let adminLoginButton = UIButton().then {
        $0.setTitle("관리자 로그인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = UIColor(hex: "073066")
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.layer.cornerRadius = 16
        $0.layer.masksToBounds = true
    }
    @objc func loginButtonTapped() {
        self.navigationController?.pushViewController(LoginInputViewController(), animated: true)
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.addSubview(employeeLoginButton)
        view.addSubview(adminLoginButton)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        employeeLoginButton.snp.makeConstraints { make in
            make.bottom.equalTo(adminLoginButton.snp.top).offset(-16)
            make.centerX.equalToSuperview()
            make.width.equalTo(353)
            make.height.equalTo(60)
        }
        
        adminLoginButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(79)
            make.centerX.equalToSuperview()
            make.width.equalTo(353)
            make.height.equalTo(60)
        }
    }
}
