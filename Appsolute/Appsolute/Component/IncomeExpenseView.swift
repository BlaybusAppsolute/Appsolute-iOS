//
//  IncomeExpenseView.swift
//  Appsolute
//
//  Created by 권민재 on 1/13/25.
//


import UIKit
import SnapKit
import Then

class IncomeExpenseView: UIView {
    
    // MARK: - UI Components
    private let incomeLabel = UILabel().then {
        $0.text = "수익"
        $0.textColor = .red
        $0.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    private let expenseLabel = UILabel().then {
        $0.text = "지출"
        $0.textColor = .blue
        $0.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    private let incomeBar = UIView().then {
        $0.backgroundColor = .red
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }
    
    private let expenseBar = UIView().then {
        $0.backgroundColor = .blue
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }
    
    private let incomeValueLabel = UILabel().then {
        $0.text = "0" // 초기값
        $0.textColor = .red
        $0.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    private let expenseValueLabel = UILabel().then {
        $0.text = "0" // 초기값
        $0.textColor = .blue
        $0.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Setup Methods
    private func setupView() {
        addSubview(incomeLabel)
        addSubview(expenseLabel)
        addSubview(incomeBar)
        addSubview(expenseBar)
        addSubview(incomeValueLabel)
        addSubview(expenseValueLabel)
    }
    
    private func setupLayout() {
        // 수익/지출 라벨
        incomeLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().offset(16)
        }
        
        expenseLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalTo(incomeLabel.snp.bottom).offset(16)
        }
        
        // 수익 바
        incomeBar.snp.makeConstraints {
            $0.leading.equalTo(incomeLabel.snp.trailing).offset(16)
            $0.centerY.equalTo(incomeLabel.snp.centerY)
            $0.height.equalTo(20)
            $0.width.equalTo(0) // 초기값: 0
        }
        
        // 지출 바
        expenseBar.snp.makeConstraints {
            $0.leading.equalTo(expenseLabel.snp.trailing).offset(16)
            $0.centerY.equalTo(expenseLabel.snp.centerY)
            $0.height.equalTo(20)
            $0.width.equalTo(0) // 초기값: 0
        }
        
        // 수익/지출 값 라벨
        incomeValueLabel.snp.makeConstraints {
            $0.leading.equalTo(incomeBar.snp.trailing).offset(8)
            $0.centerY.equalTo(incomeBar.snp.centerY)
        }
        
        expenseValueLabel.snp.makeConstraints {
            $0.leading.equalTo(expenseBar.snp.trailing).offset(8)
            $0.centerY.equalTo(expenseBar.snp.centerY)
        }
    }
    
    // MARK: - Public Method to Update Values
    func configure(income: Int, expense: Int) {
        // 수익 값 업데이트
        incomeValueLabel.text = "\(income)"
        incomeBar.snp.updateConstraints {
            $0.width.equalTo(CGFloat(income) * 10) // 길이를 동적으로 설정
        }
        
        // 지출 값 업데이트
        expenseValueLabel.text = "\(expense)"
        expenseBar.snp.updateConstraints {
            $0.width.equalTo(CGFloat(expense) * 10) // 길이를 동적으로 설정
        }
        
        // 애니메이션 적용
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
}
