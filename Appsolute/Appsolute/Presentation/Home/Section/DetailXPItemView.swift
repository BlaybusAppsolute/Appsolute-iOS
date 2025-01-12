//
//  DetailXPItemView.swift
//  Appsolute
//
//  Created by 권민재 on 1/12/25.
//
import UIKit
import SnapKit

class DetailXPItemView: UIView {
    
    // MARK: - Initializer
    init(title: String, value: String) {
        super.init(frame: .zero)
        setupViews(title: title, value: value)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    private func setupViews(title: String, value: String) {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = UIFont.systemFont(ofSize: 14)
        valueLabel.textColor = .gray
        
        addSubview(titleLabel)
        addSubview(valueLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
        }
        
        valueLabel.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview()
        }
    }
}
