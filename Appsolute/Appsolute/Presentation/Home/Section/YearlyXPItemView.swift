//
//  YearlyXPItemView.swift
//  Appsolute
//
//  Created by 권민재 on 1/12/25.
//
import UIKit
import SnapKit

class YearlyXPItemView: UIView {
    
    // MARK: - Initializer
    init(year: String, xp: Int) {
        super.init(frame: .zero)
        setupViews(year: year, xp: xp)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    private func setupViews(year: String, xp: Int) {
        let yearLabel = UILabel()
        yearLabel.text = year
        yearLabel.font = UIFont.systemFont(ofSize: 14)
        
        let xpLabel = UILabel()
        xpLabel.text = "\(xp)XP"
        xpLabel.font = UIFont.systemFont(ofSize: 14)
        xpLabel.textColor = .gray
        
        addSubview(yearLabel)
        addSubview(xpLabel)
        
        yearLabel.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
        }
        
        xpLabel.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview()
        }
    }
}
