//
//  CustomHeaderView.swift
//  Appsolute
//
//  Created by 권민재 on 1/12/25.
//
import UIKit
import SnapKit
import Then

protocol CustomHeaderViewDelegate: AnyObject {
    func didTapGuideButton()
}

class CustomHeaderView: UIView {
    
    weak var delegate: CustomHeaderViewDelegate?
    
    private let backgroundImageView = UIImageView().then {
        $0.image = UIImage(named: "레벨01")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.isUserInteractionEnabled = true
        
    }
    
    override func layoutSubviews() {
            super.layoutSubviews()
            
            let cornerRadius: CGFloat = 16
            
            // 아래쪽 두 모서리에만 둥근 코너를 적용
            let path = UIBezierPath(roundedRect: backgroundImageView.bounds,
                                    byRoundingCorners: [.bottomLeft, .bottomRight],
                                    cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
            
            let maskLayer = CAShapeLayer()
            maskLayer.path = path.cgPath
            backgroundImageView.layer.mask = maskLayer
        }
    let levelContainerView = UIView().then {
        $0.backgroundColor = UIColor(hex: "1073F4")
        $0.layer.cornerRadius = 18
        $0.clipsToBounds = true
    }
    let levelTitleLabel = UILabel().then {
        $0.text = "Lv.1 꿈틀이 씨앗"
        $0.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        $0.textColor = .white
        $0.textAlignment = .left
    }
    let guideButton = UIButton().then {
        $0.backgroundColor = UIColor(hex: "408FF6")
        $0.setTitle("레벨 가이드", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        $0.layer.cornerRadius = 16
        $0.clipsToBounds = true
        
    }
    let profileButton = UIButton().then {
        $0.setImage(UIImage(named: "내정보"), for: .normal)
    }
    let alertButton = UIButton().then {
        $0.setImage(UIImage(named: "알림-기본"), for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .backgroundColor
        setupViews()
        guideButton.addTarget(self, action: #selector(guideButtonTapped), for: .touchUpInside)
        
        //levelContainerView.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func setupViews() {
        addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        addSubview(levelContainerView)
        addSubview(profileButton)
        addSubview(alertButton)
        levelContainerView.addSubview(levelTitleLabel)
        levelContainerView.addSubview(guideButton)
        
        profileButton.snp.makeConstraints {
            $0.height.equalTo(44)
            $0.width.equalTo(54)
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalToSuperview()
        }
        alertButton.snp.makeConstraints {
            $0.width.equalTo(44)
            $0.height.equalTo(44)
            $0.trailing.equalToSuperview().inset(20)
            $0.top.equalToSuperview()
        }
        
        
        levelContainerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(20)
            $0.height.equalTo(64)
        }
        levelTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(levelContainerView.snp.leading).inset(20)
            $0.centerY.equalTo(levelContainerView.snp.centerY)
            $0.trailing.equalTo(guideButton.snp.leading).offset(5)
        }
        
        guideButton.snp.makeConstraints {
            $0.width.equalTo(83)
            $0.height.equalTo(32)
            $0.trailing.equalTo(levelContainerView.snp.trailing).inset(20)
            $0.centerY.equalTo(levelContainerView.snp.centerY)
        }
    }
    
    @objc private func guideButtonTapped() {
            delegate?.didTapGuideButton() // Delegate 호출
    }
}
