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
        view.backgroundColor = .backgroundColor

        
    }
    
    
    
    
    private func setupView() {
        
    }
    
    private func setupLayout() {
        
    }
    
    
    
    //MARK: UI
    let profileImageView = UIImageView().then {
        $0.image = UIImage(named: "")
    }
    
    
    
    let nameLabel = UILabel().then {
        $0.text = "심유나"
        $0.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        $0.textColor = .black
    }
    let employeeIdLabel = UILabel().then {
        $0.text = "1231441"
        $0.textColor = .black
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
    }
    
    
    
    
    
    
    
    

    

}
