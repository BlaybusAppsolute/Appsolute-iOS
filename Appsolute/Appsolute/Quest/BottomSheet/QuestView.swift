//
//  QuestView.swift
//  Appsolute
//
//  Created by 권민재 on 1/10/25.
//

import UIKit
import SnapKit
import Then

class QuestView: UIView {
    
    let titleLabel = UILabel().then {
        $0.text = "| 퀘스트 달성내용"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    let progressView = UIView().then {
        $0.backgroundColor = UIColor(hex: "f6f6f8")
        $0.layer.cornerRadius = 12 
    }
    let dividerView = UIImageView().then {
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
        addSubview(titleLabel)
        addSubview(progressView)
        addSubview(dividerView)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
        }
        progressView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.height.equalTo(100)
        }
        dividerView.snp.makeConstraints {
            $0.top.equalTo(progressView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
