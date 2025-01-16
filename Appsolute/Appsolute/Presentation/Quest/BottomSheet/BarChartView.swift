//
//  BarChartView.swift
//  Appsolute
//
//  Created by 권민재 on 1/16/25.
//


import UIKit
import SnapKit

class BarChartView: UIView {
    
    // MARK: - UI Components
    private let incomeLabel = UILabel().then {
        $0.text = "수익"
        $0.font = .systemFont(ofSize: 17, weight: .bold)
        $0.textColor = .red
        $0.textAlignment = .right
        //$0.setUnderline()
    }
    
    private let expenseLabel = UILabel().then {
        $0.text = "지출"
        $0.font = .systemFont(ofSize: 17, weight: .bold)
        $0.textColor = .blue
        $0.textAlignment = .right
        //$0.setUnderline()
    }
    
    private let incomeBarContainer = UIView()
    private let expenseBarContainer = UIView()
    
    private let incomeValueLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.textColor = UIColor(hex: "#FF6B6B")
    }
    
    private let expenseValueLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.textColor = UIColor(hex: "#1073F4")
    }
    
    // Gradient Layers
    private let incomeGradientLayer = CAGradientLayer()
    private let expenseGradientLayer = CAGradientLayer()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        configureGradientLayers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupView() {
        addSubview(incomeLabel)
        addSubview(expenseLabel)
        addSubview(incomeBarContainer)
        addSubview(expenseBarContainer)
        addSubview(incomeValueLabel)
        addSubview(expenseValueLabel)
        
        incomeBarContainer.layer.addSublayer(incomeGradientLayer)
        expenseBarContainer.layer.addSublayer(expenseGradientLayer)
        
        incomeBarContainer.layer.cornerRadius = 6
        incomeBarContainer.clipsToBounds = true
        
        expenseBarContainer.layer.cornerRadius = 6
        expenseBarContainer.clipsToBounds = true
    }
    
    private func setupConstraints() {
        // 수익, 지출 Label
        incomeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(16)
        }
        
        expenseLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(incomeLabel.snp.bottom).offset(24)
        }
        
        // 수익 Bar
        incomeBarContainer.snp.makeConstraints { make in
            make.leading.equalTo(incomeLabel.snp.trailing).offset(16)
            make.centerY.equalTo(incomeLabel)
            make.height.equalTo(26)
            make.width.equalTo(0) // 초기 width는 0
        }
        
        incomeValueLabel.snp.makeConstraints { make in
            make.leading.equalTo(incomeBarContainer.snp.trailing).offset(8)
            make.centerY.equalTo(incomeBarContainer)
        }
        
        // 지출 Bar
        expenseBarContainer.snp.makeConstraints { make in
            make.leading.equalTo(expenseLabel.snp.trailing).offset(16)
            make.centerY.equalTo(expenseLabel)
            make.height.equalTo(26)
            make.width.equalTo(0) // 초기 width는 0
        }
        
        expenseValueLabel.snp.makeConstraints { make in
            make.leading.equalTo(expenseBarContainer.snp.trailing).offset(8)
            make.centerY.equalTo(expenseBarContainer)
        }
    }
    
    private func configureGradientLayers() {
        // Income Gradient (Red)
        incomeGradientLayer.colors = [
            UIColor(hex: "#FF6B6B").cgColor,
            UIColor(hex: "#FF3131").cgColor
        ]
        incomeGradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        incomeGradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)

        // Expense Gradient (Blue)
        expenseGradientLayer.colors = [
            UIColor(hex: "#B9D9FF").cgColor,
            UIColor(hex: "#1073F4").cgColor
        ]
        expenseGradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5) // 왼쪽에서 오른쪽
        expenseGradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5) // 오른쪽
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        incomeGradientLayer.frame = incomeBarContainer.bounds
        expenseGradientLayer.frame = expenseBarContainer.bounds
    }
    
    // MARK: - Update Data
    func configure(income: Int, expense: Int, maxValue: Int) {
        incomeValueLabel.text = "\(income)"
        expenseValueLabel.text = "\(expense)"
        
        let maxWidth = UIScreen.main.bounds.width - 150
        let incomeWidth = CGFloat(income) / CGFloat(maxValue) * maxWidth
        let expenseWidth = CGFloat(expense) / CGFloat(maxValue) * maxWidth
        
        incomeBarContainer.snp.updateConstraints { make in
            make.width.equalTo(incomeWidth)
        }
        
        expenseBarContainer.snp.updateConstraints { make in
            make.width.equalTo(expenseWidth)
        }
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
}

// MARK: - UILabel Extension for Underline
extension UILabel {
    func setUnderline() {
        guard let text = self.text else { return }
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: text.count))
        self.attributedText = attributedText
    }
}
