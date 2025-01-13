//
//  SubtitleLabel.swift
//  Appsolute
//
//  Created by 권민재 on 1/13/25.
//


import UIKit

class SubtitleLabel: UILabel {
    
    // 텍스트 인셋 (패딩 설정 가능)
    var textInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 20) {
        didSet {
            setNeedsDisplay() // 인셋 변경 시 레이아웃 갱신
        }
    }
    
    // 초기화
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStyle()
    }
    
    // 텍스트 인셋을 적용하여 텍스트를 그리기
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }
    
    // Intrinsic Content Size 업데이트 (패딩 포함 크기 계산)
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + textInsets.left + textInsets.right,
                      height: size.height + textInsets.top + textInsets.bottom)
    }
    
    // 기본 스타일 설정
    private func setupStyle() {
        font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        textColor = UIColor(hex: "1073F4")
        backgroundColor = UIColor(hex: "DCEBFF")
        layer.cornerRadius = 6
        clipsToBounds = true
        textAlignment = .left
    }
}
