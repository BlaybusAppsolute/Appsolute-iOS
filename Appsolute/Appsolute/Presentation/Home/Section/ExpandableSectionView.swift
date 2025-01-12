//
//  ExpandableSectionView.swift
//  Appsolute
//
//  Created by 권민재 on 1/12/25.
//
import UIKit
import SnapKit

class ExpandableSectionView: UIView {
    
    private let headerButton = UIButton(type: .system)
    private let stackView = UIStackView()
    
    init(title: String, isExpanded: Bool, contentViews: [UIView], onToggle: @escaping () -> Void) {
        super.init(frame: .zero)
        setupViews(title: title, isExpanded: isExpanded, contentViews: contentViews, onToggle: onToggle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(title: String, isExpanded: Bool, contentViews: [UIView], onToggle: @escaping () -> Void) {
        headerButton.setTitle("\(title) \(isExpanded ? "▼" : "▲")", for: .normal)
        headerButton.setTitleColor(.black, for: .normal)
        headerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        headerButton.addAction(UIAction { _ in onToggle() }, for: .touchUpInside)
        
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.isHidden = !isExpanded
        
        addSubview(headerButton)
        addSubview(stackView)
        
        headerButton.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(headerButton.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        for view in contentViews {
            stackView.addArrangedSubview(view)
        }
    }
}
