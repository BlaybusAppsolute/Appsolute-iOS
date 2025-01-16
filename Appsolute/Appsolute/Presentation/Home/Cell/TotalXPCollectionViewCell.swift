//
//  TotalXPCollectionViewCell.swift
//  Appsolute
//
//  Created by 권민재 on 1/14/25.
//
import UIKit 

class TotalXPCollectionViewCell: UICollectionViewCell {
    static let identifier = "TotalXPCollectionViewCell"
    
    private let totalXPView = TotalXPView()
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
            make.edges.equalToSuperview() // 셀 내부 패딩
        }
    }
    
    func configure(user: User, levelInfo: LevelInfo) {
        totalXPView.configure(user: user, levelInfo: levelInfo)
    }
}
