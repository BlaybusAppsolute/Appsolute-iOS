//
//  CurrentYearXPCollectionViewCell.swift
//  Appsolute
//
//  Created by 권민재 on 1/14/25.
//
import UIKit 

class CurrentYearXPCollectionViewCell: UICollectionViewCell {
    static let identifier = "CurrentYearXPCollectionViewCell"
    
    

    
    private let currentYearXPView = CurrentYearXPView(
        xp: 0, percentage: 0, subtitle: "", details: []
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(currentYearXPView)
        currentYearXPView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configure(xp: Int, percentage: Int, subtitle: String, details: [(String, Int)]) {
        currentYearXPView.configure(xp: xp, percentage: percentage, subtitle: subtitle, details: details)
    }
}
