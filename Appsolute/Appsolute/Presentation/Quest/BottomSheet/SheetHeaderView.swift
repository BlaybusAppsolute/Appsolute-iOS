//
//  SheetHeaderView.swift
//  Appsolute
//
//  Created by 권민재 on 1/10/25.
//

import UIKit
import SnapKit


class SheetHeaderView: UIView {
    
    let badgeLabel: UILabel = {
        let label = UILabel()
        label.text = "직무별"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.backgroundColor = UIColor(hex: "cdfff2")
        label.textColor = UIColor(hex: "008d6e")
        label.layer.cornerRadius = 8
        label.textAlignment = .center
        label.clipsToBounds = true
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "직무별 퀘스트명 어쩌구"
        label.font = UIFont.boldSystemFont(ofSize: 23)
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(badgeLabel)
        addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        badgeLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(20)
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(28)
            make.width.equalTo(70)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(badgeLabel.snp.bottom).offset(10)
            make.leading.equalTo(badgeLabel.snp.leading)
        }
    }
}
