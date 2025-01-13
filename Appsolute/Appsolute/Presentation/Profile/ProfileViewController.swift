//
//  ProfileViewController.swift
//  Appsolute
//
//  Created by 권민재 on 1/12/25.
//
import UIKit
import SnapKit
import Then

class ProfileViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "DCEBFF")
        setupView()
        setupLayout()
        setupNavigation()
    }
    
    
    private func setupNavigation() {
        let navButton = UIButton().then {
            $0.setImage(UIImage(named: "back"), for: .normal)
            $0.addTarget(self, action: #selector(moveToHome), for: .touchUpInside)
        }
        view.addSubview(navButton)
        navButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(20)
            $0.leading.equalToSuperview().inset(20)
        }
    }
    @objc
    private func moveToHome() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setupView() {
        //profilebaseView.backgroundColor = .red
        view.addSubview(profilebaseView)
        view.addSubview(groupBaseView)
        view.addSubview(idBaseView)
    }
    
    private func setupLayout() {
        profilebaseView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(283)
        }
        groupBaseView.snp.makeConstraints {
            $0.top.equalTo(profilebaseView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(188)
        }
        idBaseView.snp.makeConstraints {
            $0.top.equalTo(groupBaseView.snp.bottom).offset(20)
            $0.leading.edges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
    }
    
    
    
    //MARK: UI
    let profilebaseView = UIView().then {
        $0.backgroundColor = .red//UIColor(hex: "DCEBFF")
    }
    let profileImageView = UIImageView().then {
        $0.image = UIImage(named: "")
    }
    let groupBaseView = UIView().then {
        $0.backgroundColor = .backgroundColor
    }
    let idBaseView = UIView().then {
        $0.backgroundColor = .backgroundColor
    }
    let editButton = UIButton()
    
    
    let logoutButton = UIButton().then {
        $0.backgroundColor = .white
        $0.setTitle("로그아웃", for: .normal)
        $0.layer.cornerRadius = 12
        $0.layer.masksToBounds = true
    }
    
    
    
   
}
