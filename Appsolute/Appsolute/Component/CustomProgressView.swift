//
//  CustomProgressView.swift
//  Appsolute
//
//  Created by 권민재 on 1/13/25.
//

import UIKit
import SnapKit
import Then

class CustomProgressView: UIView {
    
    // MARK: - UI Components
    private let progressBarContainer = UIView().then {
        $0.backgroundColor = UIColor(hex: "E9ECEF") // 배경색 (회색)
        $0.layer.cornerRadius = 16 // 둥근 모서리
        $0.clipsToBounds = true
    }
    
    private let progressBar = UIView().then {
        $0.backgroundColor = UIColor(hex: "ffa800") // 진행 바 색상 (주황색)
        $0.layer.cornerRadius = 16 // 둥근 모서리
        $0.clipsToBounds = true
    }
    
    private let percentageLabel = UILabel().then {
        $0.text = "0%" // 초기 퍼센트 값
        $0.textColor = .white // 텍스트 색상 (흰색)
        $0.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        $0.textAlignment = .center
    }
    
    private let minLabel = UILabel().then {
        $0.text = "0%" // 최소값 레이블
        $0.textColor = UIColor(hex: "BDBDBD") // 텍스트 색상 (회색)
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textAlignment = .center
    }
    
    private let midLabel = UILabel().then {
        $0.text = "50%" // 중간값 레이블
        $0.textColor = UIColor(hex: "BDBDBD") // 텍스트 색상 (회색)
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textAlignment = .center
    }
    
    private let maxLabel = UILabel().then {
        $0.text = "100%" // 최대값 레이블
        $0.textColor = UIColor(hex: "BDBDBD") // 텍스트 색상 (회색)
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textAlignment = .center
    }
    
    // MARK: - Constraint Reference
    private var progressBarWidthConstraint: Constraint? // 진행 바의 너비 제약 조건

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        
        // Labels
        addSubview(minLabel)
        addSubview(midLabel)
        addSubview(maxLabel)
        
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
            make.centerY.equalTo(progressBar)
            make.trailing.equalTo(progressBar.snp.trailing).offset(-10)
        }
        
        minLabel.snp.makeConstraints { make in
            make.top.equalTo(progressBarContainer.snp.bottom).offset(6)
            make.leading.equalTo(progressBarContainer.snp.leading) // 진행 바의 왼쪽 끝에 센터로 정렬
        }
        
        midLabel.snp.makeConstraints { make in
            make.top.equalTo(progressBarContainer.snp.bottom).offset(6)
            make.centerX.equalTo(progressBarContainer)
        }
        
        maxLabel.snp.makeConstraints { make in
            make.top.equalTo(progressBarContainer.snp.bottom).offset(6)
            make.trailing.equalTo(progressBarContainer.snp.trailing) // 진행 바의 오른쪽 끝에 센터로 정렬
        }
    }
    
    // MARK: - Update Progress
    func updateProgress(to percentage: CGFloat) {
        let clampedPercentage = max(0, min(percentage, 100)) // 0 ~ 100 범위 제한
        percentageLabel.text = "\(Int(clampedPercentage))%"
        
        // 레이아웃 업데이트는 레이아웃이 완료된 이후에 수행
        DispatchQueue.main.async {
            guard self.progressBarContainer.frame.width > 0 else { return }
            let targetWidth = self.progressBarContainer.frame.width * (clampedPercentage / 100)
            self.progressBarWidthConstraint?.update(offset: targetWidth)
            
            UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
            }
        }
    }
}
