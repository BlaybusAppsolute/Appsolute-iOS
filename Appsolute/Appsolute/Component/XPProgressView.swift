//
//  XPProgressView.swift
//  Appsolute
//
//  Created by 권민재 on 1/13/25.
//


import UIKit
import SnapKit
import Then

class XPProgressView: UIView {
    
    // MARK: - UI Components
    private let progressBarContainer = UIView().then {
        $0.backgroundColor = UIColor(hex: "E9ECEF") // 배경색 (회색)
        $0.layer.cornerRadius = 16 // 둥근 모서리
        $0.clipsToBounds = true
    }
    
    private let progressBar = UIView().then {
        $0.backgroundColor = UIColor(hex: "1073F4") // 진행 바 색상
        $0.layer.cornerRadius = 16 // 둥근 모서리
        $0.clipsToBounds = true
    }
    
    private let percentageLabel = UILabel().then {
        $0.text = "0XP" // 초기 값
        $0.textColor = .white // 텍스트 색상 (흰색)
        $0.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        $0.textAlignment = .center
    }
    
    private let minLabel = UILabel().then {
        $0.text = "0XP" // 최소값 레이블
        $0.textColor = UIColor(hex: "BDBDBD") // 텍스트 색상 (회색)
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textAlignment = .center
    }
    
    private let midLabel = UILabel().then {
        $0.text = "4500XP" // 중간값 레이블
        $0.textColor = UIColor(hex: "BDBDBD") // 텍스트 색상 (회색)
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textAlignment = .center
    }
    
    private let maxLabel = UILabel().then {
        $0.text = "9000XP" // 최대값 레이블
        $0.textColor = UIColor(hex: "BDBDBD") // 텍스트 색상 (회색)
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textAlignment = .center
    }
    
    let maxValueImageView = UIImageView().then {
        $0.image = UIImage(named: "4") // 오른쪽 아이콘
        $0.backgroundColor = UIColor(hex: "1073F4")
        $0.layer.cornerRadius = 22
        $0.clipsToBounds = true
        //$0.contentMode = .scaleAspectFit
    }
    
    // MARK: - Constraint Reference
    private var progressBarWidthConstraint: Constraint? // 진행 바의 너비 제약 조건

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        maxValueImageView.image = UIImage(named: AppKey.levelImage)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        // ProgressBar Container
        addSubview(progressBarContainer)
        progressBarContainer.addSubview(progressBar)
        progressBar.addSubview(percentageLabel)
        
        // Labels & Icon
        addSubview(minLabel)
        addSubview(midLabel)
        addSubview(maxLabel)
        addSubview(maxValueImageView)
        
        // Layout Constraints
        progressBarContainer.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(36) // 고정 높이
        }
        
        progressBar.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            progressBarWidthConstraint = make.width.equalTo(0).constraint // 초기 값 0%로 제약 저장
        }
        
        percentageLabel.snp.makeConstraints { make in
            make.trailing.equalTo(progressBar.snp.trailing).offset(-10)
            make.centerY.equalTo(progressBar)
        }
        
        minLabel.snp.makeConstraints { make in
            make.top.equalTo(progressBarContainer.snp.bottom).offset(8)
            make.leading.equalTo(progressBarContainer.snp.leading) // 진행 바의 왼쪽 끝에 센터로 정렬
        }
        
        midLabel.snp.makeConstraints { make in
            make.top.equalTo(progressBarContainer.snp.bottom).offset(8)
            make.centerX.equalTo(progressBarContainer)
        }
        
        maxLabel.snp.makeConstraints { make in
            make.top.equalTo(progressBarContainer.snp.bottom).offset(8)
            make.trailing.equalTo(progressBarContainer.snp.trailing)
        }
        
        maxValueImageView.snp.makeConstraints { make in
            make.centerY.equalTo(progressBarContainer) // 아이콘 세로 정렬
            make.trailing.equalTo(progressBarContainer.snp.trailing)
            make.width.height.equalTo(44)
        }
    }
    
    // MARK: - Update Progress
    func updateProgress(currentXP: Int, minXP: Int, midXP: Int, maxXP: Int) {
        // 동적 값 업데이트
        minLabel.text = "\(minXP)XP"
        midLabel.text = "\(midXP)XP"
        maxLabel.text = "\(maxXP)XP"
        percentageLabel.text = "\(currentXP)XP"
        
        // 퍼센트 계산
        let progressPercentage = CGFloat(currentXP - minXP) / CGFloat(maxXP - minXP)
        let clampedPercentage = max(0, min(progressPercentage, 1)) // 0 ~ 1 범위 제한
        
        // 진행 바 너비 업데이트
        DispatchQueue.main.async {
            guard self.progressBarContainer.frame.width > 0 else { return }
            let targetWidth = self.progressBarContainer.frame.width * clampedPercentage
            self.progressBarWidthConstraint?.update(offset: targetWidth)
            
            UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
            }
        }
    }
}
