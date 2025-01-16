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
    
    let questStatusBar = UIImageView().then {
        $0.image = UIImage(named: "mid_bar")
    }
    
    let dividerView = UIImageView().then {
        $0.image = UIImage(named: "divider")
    }
    
    // 숫자 레이블
    let minLabel = UILabel().then {
        $0.text = "0"
        $0.textColor = UIColor.gray
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textAlignment = .center
    }
    
   let midLabel = UILabel().then {
        $0.text = "4.3"
        $0.textColor = UIColor.gray
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        $0.textAlignment = .center
    }
    
   let maxLabel = UILabel().then {
        $0.text = "5.1"
        $0.textColor = UIColor.gray
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textAlignment = .center
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
        progressView.addSubview(questStatusBar)
        progressView.addSubview(minLabel)
        progressView.addSubview(midLabel)
        progressView.addSubview(maxLabel)
        addSubview(dividerView)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
        }
        
        progressView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.height.equalTo(100)
        }
        
        questStatusBar.snp.makeConstraints {
            $0.leading.trailing.equalTo(progressView).inset(16)
            $0.top.equalTo(progressView.snp.top).inset(20)
            $0.height.equalTo(36)
        }
        
        minLabel.snp.makeConstraints {
            $0.leading.equalTo(questStatusBar.snp.leading)
            $0.top.equalTo(questStatusBar.snp.bottom).offset(8)
        }
        
        midLabel.snp.makeConstraints {
            $0.centerX.equalTo(questStatusBar.snp.centerX)
            $0.top.equalTo(questStatusBar.snp.bottom).offset(8)
        }
        
        maxLabel.snp.makeConstraints {
            $0.trailing.equalTo(questStatusBar.snp.trailing)
            $0.top.equalTo(questStatusBar.snp.bottom).offset(8)
        }
        
        dividerView.snp.makeConstraints {
            $0.top.equalTo(progressView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
}
