//
//  EditProfileViewController.swift
//  Appsolute
//
//  Created by 권민재 on 1/13/25.
//

import UIKit
import SnapKit
import Then

class EditProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "dcebff")
        
        setupView()
        setupLayout()
        cancelButton.addTarget(self, action: #selector(popTapped), for: .touchUpInside)
    }
    
    private func setupView() {
        // Add subviews to the main view
        view.addSubview(profilebaseView)
        profilebaseView.addSubview(profileImageView)
        view.addSubview(nameLabel)
        view.addSubview(employeeIdLabel)
        view.addSubview(selectView)
        view.addSubview(cancelButton)
        view.addSubview(completeButton)
        
        // Add subviews to selectView (e.g., character selection icons)
        for (index, imageName) in characterImages.enumerated() {
            let imageView = UIImageView().then {
                $0.image = UIImage(named: imageName)
                $0.contentMode = .scaleAspectFit
                $0.layer.cornerRadius = 40
                $0.layer.masksToBounds = true
                $0.layer.borderWidth = index == selectedCharacterIndex ? 2 : 0
                $0.layer.borderColor = UIColor(hex: "1073F4").cgColor
            }
            selectView.addSubview(imageView)
            characterImageViews.append(imageView)
        }
    }
    
    private func setupLayout() {
        
        profilebaseView.snp.makeConstraints {
            $0.top.equalTo(cancelButton.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(133)
        }
        
        profileImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(122)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(profileImageView.snp.bottom).offset(12)
        }
        
        employeeIdLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
        }
        
        selectView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(employeeIdLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(completeButton.snp.top).offset(-54)
        }
        
        // Layout for character image views inside selectView
        let characterSize = 90
        let padding: CGFloat = 22

        for (index, imageView) in characterImageViews.enumerated() {
            let row = index / 3
            let col = index % 3
            
            imageView.snp.makeConstraints { make in
                make.width.height.equalTo(characterSize)
                make.top.equalToSuperview().offset((characterSize + Int(padding)) * row + 20) // row 간 간격 및 탑 오프셋 추가
                make.leading.equalToSuperview().offset((characterSize + Int(padding)) * col + 20) // column 간 간격 및 리딩 추가
            }
        }
        
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.width.height.equalTo(40)
        }
        
        completeButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(57)
            make.height.equalTo(51)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    @objc func popTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: Properties
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
        $0.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        $0.textColor = .black
    }
    
    let employeeIdLabel = UILabel().then {
        $0.text = "사번: 2022080101"
        $0.textColor = .gray
        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
    }
    
    let selectView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 20
        $0.layer.masksToBounds = true
    }
    
    let cancelButton = UIButton().then {
        $0.setImage(UIImage(named: "cancel"), for: .normal)
    }
    
    let completeButton = UIButton().then {
        $0.backgroundColor = UIColor(hex: "1073F4")
        $0.setTitle("캐릭터 수정 완료", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.layer.cornerRadius = 12
    }
    
    // MARK: Data
    let characterImages = ["프로필 사진-1", "프로필 사진-2", "프로필 사진-3", "프로필 사진-4", "프로필 사진-5", "프로필 사진-6", "프로필 사진-7", "프로필 사진"]
    var characterImageViews: [UIImageView] = []
    var selectedCharacterIndex: Int = 0
}
