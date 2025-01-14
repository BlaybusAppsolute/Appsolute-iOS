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
        self.hidesBottomBarWhenPushed = true
        setupView()
        setupNavigation()
        setupLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
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
        view.addSubview(profilebaseView)
        profilebaseView.addSubview(profileImageView)
        view.addSubview(nameLabel)
        view.addSubview(numberLabel)
        view.addSubview(editButton)
        
        view.addSubview(groupBaseView)
        groupBaseView.addSubview(departmentLabel)
        groupBaseView.addSubview(departmentValueLabel)
        groupBaseView.addSubview(teamLabel)
        groupBaseView.addSubview(teamValueLabel)
        groupBaseView.addSubview(levelLabel)
        groupBaseView.addSubview(levelValueLabel)
        
        view.addSubview(idBaseView)
        idBaseView.addSubview(idLabel)
        idBaseView.addSubview(idValueLabel)
        idBaseView.addSubview(passwordLabel)
        idBaseView.addSubview(passwordValueLabel)
        idBaseView.addSubview(passwordEditButton)
        idBaseView.addSubview(logoutButton)
    }

    private func setupLayout() {
        profilebaseView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(98)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(133)
        }
        
        profileImageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.size.equalTo(122)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(profilebaseView.snp.bottom).offset(25)
            $0.centerX.equalTo(profilebaseView)
        }
        
        numberLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(13)
            $0.centerX.equalTo(profilebaseView)
        }
        
        editButton.snp.makeConstraints {
            $0.size.equalTo(30)
            $0.trailing.equalTo(profileImageView.snp.trailing).offset(15)
            $0.bottom.equalTo(profileImageView.snp.bottom).offset(15)
        }
        
        groupBaseView.snp.makeConstraints {
            $0.top.equalTo(numberLabel.snp.bottom).offset(26)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(188)
        }
        
        departmentLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        departmentValueLabel.snp.makeConstraints {
            $0.centerY.equalTo(departmentLabel)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        teamLabel.snp.makeConstraints {
            $0.top.equalTo(departmentLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        teamValueLabel.snp.makeConstraints {
            $0.centerY.equalTo(teamLabel)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        levelLabel.snp.makeConstraints {
            $0.top.equalTo(teamLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        levelValueLabel.snp.makeConstraints {
            $0.centerY.equalTo(levelLabel)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        idBaseView.snp.makeConstraints {
            $0.top.equalTo(groupBaseView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(100)
        }
        
        idLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        idValueLabel.snp.makeConstraints {
            $0.centerY.equalTo(idLabel)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(idLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        passwordValueLabel.snp.makeConstraints {
            $0.centerY.equalTo(passwordLabel)
            $0.trailing.equalTo(passwordEditButton.snp.leading).offset(-10)
        }
        
        passwordEditButton.snp.makeConstraints {
            $0.centerY.equalTo(passwordValueLabel)
            $0.trailing.equalToSuperview().inset(20)
            $0.size.equalTo(CGSize(width: 40, height: 20))
        }
        
        logoutButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(20)
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(51)
        }
    }
    
    //MARK: UI
    let profilebaseView = UIView().then {
        $0.layer.cornerRadius = 133/2
        $0.layer.masksToBounds = true
        $0.backgroundColor = .white
    }
    let profileImageView = UIImageView().then {
        $0.image = UIImage(named: "프로필 사진")
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 50 // 반원 형태
        $0.layer.masksToBounds = true
    }
    
    let nameLabel = UILabel().then {
        $0.text = "심유나"
        $0.font = .systemFont(ofSize: 24, weight: .bold)
    }
    let numberLabel = UILabel().then {
        $0.text = "사번: 20293494"
        $0.font = .systemFont(ofSize: 18, weight: .semibold)
    }
    
    
    let groupBaseView = UIView().then {
        $0.backgroundColor = UIColor(hex: "e7f1fe")
        $0.layer.cornerRadius = 12
    }
    let idBaseView = UIView().then {
        $0.backgroundColor = UIColor(hex: "e7f1fe")
        $0.layer.cornerRadius = 12
    }
    let editButton = UIButton().then {
        $0.setImage(UIImage(named: "edit"), for: .normal)
        $0.layer.cornerRadius = 15
        $0.backgroundColor = UIColor(hex: "e7f1fe")
    }
    let logoutButton = UIButton().then {
        $0.backgroundColor = .white
        $0.setTitle("로그아웃", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.layer.cornerRadius = 12
        $0.layer.masksToBounds = true
    }
    let departmentLabel = UILabel().then {
        $0.text = "소속"
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
    }

    let departmentValueLabel = UILabel().then {
        $0.text = "음성 2센터"
        $0.font = .systemFont(ofSize: 16)
    }

    let teamLabel = UILabel().then {
        $0.text = "직무그룹"
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
    }

    let teamValueLabel = UILabel().then {
        $0.text = "1팀"
        $0.font = .systemFont(ofSize: 16)
    }

    let levelLabel = UILabel().then {
        $0.text = "레벨"
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
    }

    let levelValueLabel = UILabel().then {
        $0.text = "Lv. 3 쏙쏙 일사구"
        $0.font = .systemFont(ofSize: 16)
    }

    let idLabel = UILabel().then {
        $0.text = "아이디"
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
    }

    let idValueLabel = UILabel().then {
        $0.text = "sim_yuna123"
        $0.font = .systemFont(ofSize: 16)
    }

    let passwordLabel = UILabel().then {
        $0.text = "비밀번호"
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
    }

    let passwordValueLabel = UILabel().then {
        $0.text = "11••••"
        $0.font = .systemFont(ofSize: 16)
    }

    let passwordEditButton = UIButton().then {
        $0.setTitle("수정", for: .normal)
        $0.setTitleColor(.blue, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14)
    }
}
