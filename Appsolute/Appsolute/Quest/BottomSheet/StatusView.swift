//
//  StatusView.swift
//  Appsolute
//
//  Created by 권민재 on 1/10/25.
//

import UIKit
import SnapKit
import Then

class StatusView: UIView {
    
    let expTitleLabel = UILabel().then {
        $0.text = "| 획득한 경험치"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    let expImageView = UIImageView().then {
        $0.image = UIImage(named: "exp")
    }
    
    
    let expLabel = UILabel().then {
        $0.text = "50XP"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    
    let productTitleLabel = UILabel().then {
        $0.text = "| 생산성"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    let productLabel = UILabel().then {
        $0.text = "4.762P"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    
    let dividerView1 = UIImageView().then {
        $0.image = UIImage(named: "divider")
    }
    let dividerView2 = UIImageView().then {
        $0.image = UIImage(named: "divider")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupViews() {
        addSubview(expLabel)
        addSubview(expTitleLabel)
        addSubview(expImageView)
        addSubview(dividerView1)
        addSubview(productTitleLabel)
        addSubview(productLabel)
        addSubview(dividerView2)
    }
    
    private func setupConstraints() {
        expTitleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
        }
        expLabel.snp.makeConstraints {
            $0.top.equalTo(expTitleLabel)
            $0.trailing.equalToSuperview().inset(16)
        }
        expImageView.snp.makeConstraints {
            $0.width.height.equalTo(22)
            $0.trailing.equalTo(expLabel.snp.leading).inset(10)
            $0.centerY.equalTo(expLabel)
            
        }
        dividerView1.snp.makeConstraints {
            $0.top.equalTo(expLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
