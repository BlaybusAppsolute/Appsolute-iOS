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
        view.backgroundColor = .backgroundColor
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
    
    
    
    //MARK: UI
    let profilebaseView = UIView().then {
        $0.backgroundColor = .white
    }
    let profileImageView = UIImageView().then {
        $0.image = UIImage(named: "")
    }
    let editButton = UIButton()
    
    
    let logoutButton = UIButton().then {
        $0.backgroundColor = .white
        $0.setTitle("로그아웃", for: .normal)
        $0.layer.cornerRadius = 12
        $0.layer.masksToBounds = true
    }
    
    
    
   
}
