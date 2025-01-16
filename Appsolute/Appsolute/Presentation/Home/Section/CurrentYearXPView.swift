//
//  CurrentYearXPView.swift
//  Appsolute
//
//  Created by 권민재 on 1/12/25.
//
import UIKit
import SnapKit
import Then

class CurrentYearXPView: UIView {
    
    // MARK: - UI 요소 선언
    private let titleLabel = UILabel().then {
        $0.text = "금년도 획득 경험치:"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = UIColor.black
    }
    
    private let xpLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = .black
    }
    private let expView = UIImageView().then {
        $0.image = UIImage(named: "exp")
    }
    
    private let progressContainer = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 21
        $0.layer.masksToBounds = true
    }
    
    private let progressBar = CustomProgressView()
    
    private let subtitleLabel = SubtitleLabel().then {
        $0.text = "⬆️ 올헤 획득한 경험치 / 올해 획득 가능한 경험치 값이에요"
    }
    
    private let detailsContainer = UIView().then {
        $0.backgroundColor = UIColor.white
        $0.layer.cornerRadius = 18
        $0.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowOpacity = 0.2
        $0.layer.shadowRadius = 4
    }
    
    private let detailTitleLabel = UILabel().then {
        $0.text = "| 획득 상세내역"
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.textAlignment = .left
        $0.textColor = .black
    }
    
    private let totalLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 18)
        $0.text = "총계:"
        $0.textColor = UIColor.black
    }
    
    private let totalXPLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 18)
        $0.textColor = .black
    }
    
    private var detailItems: [(titleLabel: UILabel, valueLabel: UILabel)] = []
    
    // MARK: - 초기화
    init(xp: Int, percentage: Int, subtitle: String, details: [(String, Int)]) {
        super.init(frame: .zero)
        setupViews()
        configure(xp: xp, percentage: percentage, subtitle: subtitle, details: details)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupViews (초기 뷰 구성)
    private func setupViews() {
        // 기본 UI 요소 추가
        addSubview(titleLabel)
        addSubview(xpLabel)
        addSubview(expView)
        addSubview(progressContainer)
        progressContainer.addSubview(progressBar)
        progressContainer.addSubview(subtitleLabel)
        addSubview(detailsContainer)
        detailsContainer.addSubview(detailTitleLabel)
        detailsContainer.addSubview(totalLabel)
        detailsContainer.addSubview(totalXPLabel)
        
        // 레이아웃 설정
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(20)
        }
        
        xpLabel.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.trailing.equalToSuperview().inset(20)
        }
        
        expView.snp.makeConstraints { make in
            make.size.equalTo(22)
            make.trailing.equalTo(xpLabel.snp.leading).offset(-8)
            make.centerY.equalTo(xpLabel)
        }
        
        progressContainer.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(137)
        }
        
        progressBar.snp.makeConstraints { make in
            make.top.equalTo(progressContainer.snp.top).inset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(56)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(progressBar.snp.bottom).offset(13)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(28)
        }
        
        detailsContainer.snp.makeConstraints { make in
            make.top.equalTo(progressContainer.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        detailTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    // MARK: - Configure (데이터 업데이트)
    func configure(xp: Int, percentage: Int, subtitle: String, details: [(String, Int)]) {
        // 데이터 업데이트
        xpLabel.text = "\(xp)XP"
        subtitleLabel.text = subtitle
        totalXPLabel.text = "\(details.reduce(0) { $0 + $1.1 })XP"
        progressBar.updateProgress(to: CGFloat(percentage))
        
        // 이전 추가된 레이블 제거
        detailItems.forEach { $0.titleLabel.removeFromSuperview(); $0.valueLabel.removeFromSuperview() }
        detailItems.removeAll()
        
        // 새로운 상세 항목 추가
        addDetailLabels(details)
    }
    
    // MARK: - Add Detail Labels
    private func addDetailLabels(_ details: [(String, Int)]) {
        var lastView: UIView = detailTitleLabel
        
        for detail in details {
            let titleLabel = UILabel().then {
                $0.text = detail.0
                $0.font = UIFont.systemFont(ofSize: 14)
                $0.textColor = UIColor.darkGray
            }
            
            let valueLabel = UILabel().then {
                $0.text = "\(detail.1)XP"
                $0.font = UIFont.systemFont(ofSize: 14)
                $0.textColor = UIColor.black
            }
            
            detailsContainer.addSubview(titleLabel)
            detailsContainer.addSubview(valueLabel)
            
            // 레이아웃 설정
            titleLabel.snp.makeConstraints { make in
                make.top.equalTo(lastView.snp.bottom).offset(8)
                make.leading.equalToSuperview().offset(20)
            }
            
            valueLabel.snp.makeConstraints { make in
                make.centerY.equalTo(titleLabel)
                make.trailing.equalToSuperview().inset(20)
            }
            
            lastView = titleLabel
            detailItems.append((titleLabel, valueLabel))
        }
        let expImage = UIImageView().then {
            $0.image = UIImage(named: "exp")
        }
        detailsContainer.addSubview(expImage)
        
        // 총계 레이블 위치 설정
        totalLabel.snp.remakeConstraints { make in
            make.top.equalTo(lastView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
        }
        
        totalXPLabel.snp.remakeConstraints { make in
            make.centerY.equalTo(totalLabel)
            make.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20) // 하단 간격 추가
        }
        expImage.snp.makeConstraints { make in
            make.trailing.equalTo(totalXPLabel.snp.leading).offset(-8)
            make.size.equalTo(22)
            make.centerY.equalTo(totalXPLabel)
        }
    }
}
