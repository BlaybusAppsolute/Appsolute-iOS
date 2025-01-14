//
//  TotalXPCollectionViewCell.swift
//  Appsolute
//
//  Created by 권민재 on 1/14/25.
//
import UIKit 

class TotalXPCollectionViewCell: UICollectionViewCell {
    static let identifier = "TotalXPCollectionViewCell"
    
    private let totalXPView = TotalXPView(xp: 1500, subtitle: "Lv.4까지 7500XP 남았어요!") // TotalXPView 인스턴스
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(totalXPView)
        contentView.backgroundColor = .clear // 셀 배경 투명
    }
    
    private func setupConstraints() {
        totalXPView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8) // 셀 내부 패딩
        }
    }
    
    func configure(xp: Int, subtitle: String) {
        totalXPView.configure(xp: xp, subtitle: subtitle) // TotalXPView 업데이트
    }
}
