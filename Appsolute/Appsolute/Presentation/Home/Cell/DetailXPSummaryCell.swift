//
//  DetailXPSummaryCell.swift
//  Appsolute
//
//  Created by 권민재 on 1/14/25.
//
import UIKit
import SnapKit
import Then

protocol CellExpansionDelegate: AnyObject {
    func didTapExpandButton(in cell: UICollectionViewCell)
}

class DetailXPSummaryCell: UICollectionViewCell {
    static let identifier = "DetailXPSummaryCell"
    var isExpanded = false
    weak var delegate: CellExpansionDelegate?
    
    
    // MARK: - UI 요소 선언
    private let titleLabel = UILabel().then {
        $0.text = "전년도 획득 경험치"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = UIColor(hex: "0b52ad")
    }
    
    private let toggleButton = UIButton().then {
            $0.setTitle("펼치기", for: .normal)
            $0.setTitleColor(.systemBlue, for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    }
    
    
    
    private let expView = UIImageView().then {
        $0.image = UIImage(named: "")
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
    
    // MARK: - 초기화
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(hex: "dcebff")
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI 설정
    private func setupViews() {
        // 기본 UI 요소 추가
        contentView.addSubview(titleLabel)
        contentView.addSubview(toggleButton)
        contentView.addSubview(expView)
        contentView.addSubview(progressContainer)
        progressContainer.addSubview(progressBar)
        progressContainer.addSubview(subtitleLabel)
        
        // 레이아웃 설정
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(20)
        }
        toggleButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(16)
            make.width.equalTo(80)
            make.height.equalTo(30)
        }
        
        
        expView.snp.makeConstraints { make in
            make.size.equalTo(22)
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalTo(titleLabel)
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
    }
    
    // MARK: - Configure
    func configure(xp: Int, percentage: Int, subtitle: String) {
        // 데이터 업데이트
        subtitleLabel.text = subtitle
        progressBar.updateProgress(to: CGFloat(percentage))
    }
    private func setupActions() {
        toggleButton.addTarget(self, action: #selector(toggleButtonTapped), for: .touchUpInside)
    }
    
    @objc private func toggleButtonTapped() {
        delegate?.didTapExpandButton(in: self)
    }
    
    func toggleExpansion(animated: Bool) {
        if isExpanded {
            toggleButton.setTitle("접기", for: .normal)
            // 펼쳐진 상태 UI
        } else {
            toggleButton.setTitle("펼치기", for: .normal)
            // 접힌 상태 UI
        }
        
        if animated {
            UIView.animate(withDuration: 0.3) {
                self.layoutIfNeeded()
            }
        }
    }
    
}
