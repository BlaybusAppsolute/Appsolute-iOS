//
//  CollectionViewCell.swift
//  Appsolute
//
//  Created by 권민재 on 1/14/25.
//

import UIKit
import SnapKit

// MARK: - CollectionViewCell
class CollectionViewCell: UICollectionViewCell {
    static let identifier = "CollectionViewCell"
    
    private let titleLabel = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        contentView.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowRadius = 4
    }
    
    func configure(with title: String) {
        titleLabel.text = title
    }
}
