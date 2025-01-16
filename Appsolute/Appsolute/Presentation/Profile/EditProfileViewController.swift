//
//  EditProfileViewController.swift
//  Appsolute
//
//  Created by 권민재 on 1/13/25.
//

//import UIKit
//import SnapKit
//import Then
//
//class EditProfileViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = UIColor(hex: "dcebff")
//        profileImageView.image = UIImage(named: AppKey.profileImage)
//        nameLabel.text = UserManager.shared.getUser()?.userName
//        employeeIdLabel.text = UserManager.shared.getUser()?.employeeNumber
//        setupView()
//        setupLayout()
//        cancelButton.addTarget(self, action: #selector(popTapped), for: .touchUpInside)
//    }
//    
//    private func setupView() {
//        // Add subviews to the main view
//        view.addSubview(profilebaseView)
//        profilebaseView.addSubview(profileImageView)
//        view.addSubview(nameLabel)
//        view.addSubview(employeeIdLabel)
//        view.addSubview(selectView)
//        view.addSubview(cancelButton)
//        view.addSubview(completeButton)
//        
//        // Add subviews to selectView (e.g., character selection icons)
//        for (index, imageName) in characterImages.enumerated() {
//            let imageView = UIImageView().then {
//                $0.image = UIImage(named: imageName)
//                $0.contentMode = .scaleAspectFit
//                $0.layer.cornerRadius = 40
//                $0.layer.masksToBounds = true
//                $0.layer.borderWidth = index == selectedCharacterIndex ? 2 : 0
//                $0.layer.borderColor = UIColor(hex: "1073F4").cgColor
//            }
//            selectView.addSubview(imageView)
//            characterImageViews.append(imageView)
//        }
//    }
//    
//    private func setupLayout() {
//        
//        profilebaseView.snp.makeConstraints {
//            $0.top.equalTo(cancelButton.snp.bottom)
//            $0.centerX.equalToSuperview()
//            $0.size.equalTo(133)
//        }
//        
//        profileImageView.snp.makeConstraints {
//            $0.center.equalToSuperview()
//            $0.size.equalTo(122)
//        }
//        
//        nameLabel.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.top.equalTo(profileImageView.snp.bottom).offset(12)
//        }
//        
//        employeeIdLabel.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.top.equalTo(nameLabel.snp.bottom).offset(8)
//        }
//        
//        selectView.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.top.equalTo(employeeIdLabel.snp.bottom).offset(20)
//            make.leading.trailing.equalToSuperview().inset(20)
//            make.bottom.equalTo(completeButton.snp.top).offset(-54)
//        }
//        
//        // Layout for character image views inside selectView
//        let characterSize = 90
//        let padding: CGFloat = 22
//
//        for (index, imageView) in characterImageViews.enumerated() {
//            let row = index / 3
//            let col = index % 3
//            
//            imageView.snp.makeConstraints { make in
//                make.width.height.equalTo(characterSize)
//                make.top.equalToSuperview().offset((characterSize + Int(padding)) * row + 20) // row 간 간격 및 탑 오프셋 추가
//                make.leading.equalToSuperview().offset((characterSize + Int(padding)) * col + 20) // column 간 간격 및 리딩 추가
//            }
//        }
//        
//        cancelButton.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
//            make.trailing.equalToSuperview().offset(-10)
//            make.width.height.equalTo(40)
//        }
//        
//        completeButton.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.bottom.equalToSuperview().inset(57)
//            make.height.equalTo(51)
//            make.leading.trailing.equalToSuperview().inset(20)
//        }
//    }
//    @objc func popTapped() {
//        self.navigationController?.popViewController(animated: true)
//    }
//    
//    // MARK: Properties
//    let profilebaseView = UIView().then {
//        $0.layer.cornerRadius = 133/2
//        $0.layer.masksToBounds = true
//        $0.backgroundColor = .white
//    }
//    let profileImageView = UIImageView().then {
//        $0.image = UIImage(named: "프로필 사진")
//        $0.contentMode = .scaleAspectFill
//        $0.layer.cornerRadius = 50 // 반원 형태
//        $0.layer.masksToBounds = true
//    }
//    
//    let nameLabel = UILabel().then {
//        $0.text = "심유나"
//        $0.font = UIFont.systemFont(ofSize: 24, weight: .bold)
//        $0.textColor = .black
//    }
//    
//    let employeeIdLabel = UILabel().then {
//        $0.text = "사번: 2022080101"
//        $0.textColor = .gray
//        $0.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
//    }
//    
//    let selectView = UIView().then {
//        $0.backgroundColor = .white
//        $0.layer.cornerRadius = 20
//        $0.layer.masksToBounds = true
//    }
//    
//    let cancelButton = UIButton().then {
//        $0.setImage(UIImage(named: "cancel"), for: .normal)
//    }
//    
//    let completeButton = UIButton().then {
//        $0.backgroundColor = UIColor(hex: "1073F4")
//        $0.setTitle("캐릭터 수정 완료", for: .normal)
//        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
//        $0.layer.cornerRadius = 12
//    }
//    
//    // MARK: Data
//    let characterImages = ["프로필 사진-1", "프로필 사진-2", "프로필 사진-3", "프로필 사진-4", "프로필 사진-5", "프로필 사진-6", "프로필 사진-7", "프로필 사진-8","프로필 사진-9"]
//    var characterImageViews: [UIImageView] = []
//    var selectedCharacterIndex: Int = 0
//}
import UIKit
import SnapKit
import Then

class EditProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "dcebff")
        profileImageView.image = UIImage(named: deselectImages[selectedCharacterIndex]) // 초기 프로필 이미지 설정
        nameLabel.text = UserManager.shared.getUser()?.userName
        employeeIdLabel.text = UserManager.shared.getUser()?.employeeNumber
        setupView()
        setupLayout()
        cancelButton.addTarget(self, action: #selector(popTapped), for: .touchUpInside)
        completeButton.addTarget(self, action: #selector(completeTapped), for: .touchUpInside)
    }
    
    private func setupView() {
        view.addSubview(profilebaseView)
        profilebaseView.addSubview(profileImageView)
        view.addSubview(nameLabel)
        view.addSubview(employeeIdLabel)
        view.addSubview(selectView)
        view.addSubview(cancelButton)
        view.addSubview(completeButton)
        
        // 버튼 추가
        for (index, deselectImage) in deselectImages.enumerated() {
            let button = UIButton().then {
                $0.setImage(UIImage(named: index == selectedCharacterIndex ? selectedImages[index] : deselectImage), for: .normal)
                $0.tag = index
                
            }
            button.addTarget(self, action: #selector(characterTapped(_:)), for: .touchUpInside)
            selectView.addSubview(button)
            characterButtons.append(button)
        }
    }
    
    private func setupLayout() {
        profilebaseView.snp.makeConstraints {
            $0.top.equalTo(cancelButton.snp.bottom).offset(20)
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
        
        let characterSize: CGFloat = 90
        let padding: CGFloat = 22

        for (index, button) in characterButtons.enumerated() {
            let row = index / 3
            let col = index % 3
            
            button.snp.makeConstraints { make in
                make.width.height.equalTo(characterSize)
                make.top.equalToSuperview().offset((characterSize + padding) * CGFloat(row) + 20)
                make.leading.equalToSuperview().offset((characterSize + padding) * CGFloat(col) + 20)
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
    
    @objc private func characterTapped(_ sender: UIButton) {
        // 기존 선택된 버튼을 deselect로 변경
        let previousSelectedIndex = selectedCharacterIndex
        let previousButton = characterButtons[previousSelectedIndex]
        previousButton.setImage(UIImage(named: deselectImages[previousSelectedIndex]), for: .normal)
        previousButton.layer.borderWidth = 0
        
        // 새로 선택된 버튼을 select로 변경
        selectedCharacterIndex = sender.tag
        let selectedButton = characterButtons[selectedCharacterIndex]
        selectedButton.setImage(UIImage(named: selectedImages[selectedCharacterIndex]), for: .normal)
        
        // 프로필 이미지는 deselect 상태로 반영
        profileImageView.image = UIImage(named: deselectImages[selectedCharacterIndex])
    }
    
    @objc private func completeTapped() {
        // AppKey.profileImage 업데이트
        AppKey.profileImage = deselectImages[selectedCharacterIndex]
        print("✅ AppKey.profileImage 업데이트: \(AppKey.profileImage)")
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func popTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: Properties
    let profilebaseView = UIView().then {
        $0.layer.cornerRadius = 133 / 2
        $0.layer.masksToBounds = true
        $0.backgroundColor = .white
    }
    let profileImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 61 // 반원 형태
        $0.layer.masksToBounds = true
    }
    
    let nameLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        $0.textColor = .black
    }
    
    let employeeIdLabel = UILabel().then {
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
    let deselectImages = ["프로필 사진-1", "프로필 사진-2", "프로필 사진-3", "프로필 사진-4", "프로필 사진-5", "프로필 사진-6", "프로필 사진-7", "프로필 사진-8", "프로필 사진-9"]
    let selectedImages = ["프로필 사진 선택-1", "프로필 사진 선택-2", "프로필 사진 선택-3", "프로필 사진 선택-4", "프로필 사진 선택-5", "프로필 사진 선택-6", "프로필 사진 선택-7", "프로필 사진 선택-8", "프로필 사진 선택-9"]
    var characterButtons: [UIButton] = []
    var selectedCharacterIndex: Int = 0
}
