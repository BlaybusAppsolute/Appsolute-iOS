//
//  DailyFinanceView.swift
//  Appsolute
//
//  Created by 권민재 on 1/10/25.
//UIColor(hex: "e7f1fe")

import UIKit
import SnapKit
import Then

class DailyFinanceView: UIView {
    // MARK: - UI Components

    private let titleLabel = UILabel().then {
        $0.text = "| 1월 3주차 일별 재무내역"
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.textColor = .black
    }

    // 날짜와 수익/지출을 감싸는 컨테이너 뷰
    private let financeContainerView = UIView().then {
        $0.backgroundColor = UIColor(hex: "e7f1fe")
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(hex: "E6E6E6").cgColor
        $0.clipsToBounds = true
    }

    // 날짜 버튼을 담는 스택뷰
    private let dateStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.distribution = .fillEqually // 버튼 크기 균등 분배
        $0.alignment = .fill
    }

    private let incomeLabel = UILabel().then {
        $0.text = "수익"
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        $0.textColor = .red
    }

    private let expenseLabel = UILabel().then {
        $0.text = "지출"
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        $0.textColor = .blue
    }

    private let incomeProgressBar = UIView().then {
        $0.backgroundColor = .red
    }

    private let expenseProgressBar = UIView().then {
        $0.backgroundColor = .blue
    }

    private let incomeValueLabel = UILabel().then {
        $0.text = "10"
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.textColor = .red
    }

    private let expenseValueLabel = UILabel().then {
        $0.text = "8"
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.textColor = .blue
    }

    private let detailsContainerView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor(hex: "E6E6E6").cgColor
        $0.clipsToBounds = true
    }

    private let detailsTitleLabel = UILabel().then {
        $0.text = "< 지출 상세내역 >"
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.textColor = .mainBlue
        $0.textAlignment = .center
    }

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Views

    private func setupViews() {
        // 전체 뷰 설정
        layer.cornerRadius = 16
        layer.masksToBounds = true

        // Add subviews
        addSubview(titleLabel)
        addSubview(financeContainerView)
        financeContainerView.addSubview(dateStackView)
        financeContainerView.addSubview(incomeLabel)
        financeContainerView.addSubview(incomeProgressBar)
        financeContainerView.addSubview(incomeValueLabel)
        financeContainerView.addSubview(expenseLabel)
        financeContainerView.addSubview(expenseProgressBar)
        financeContainerView.addSubview(expenseValueLabel)
        addSubview(detailsContainerView)
        detailsContainerView.addSubview(detailsTitleLabel)
    }

    // MARK: - Setup Constraints

    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(16)
        }

        financeContainerView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        // 날짜 스택뷰
        dateStackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(60)
        }

        incomeLabel.snp.makeConstraints {
            $0.top.equalTo(dateStackView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }

        incomeProgressBar.snp.makeConstraints {
            $0.top.equalTo(incomeLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(8)
        }

        incomeValueLabel.snp.makeConstraints {
            $0.centerY.equalTo(incomeProgressBar)
            $0.trailing.equalTo(incomeProgressBar.snp.trailing)
        }

        expenseLabel.snp.makeConstraints {
            $0.top.equalTo(incomeProgressBar.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }

        expenseProgressBar.snp.makeConstraints {
            $0.top.equalTo(expenseLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(8)
        }

        expenseValueLabel.snp.makeConstraints {
            $0.centerY.equalTo(expenseProgressBar)
            $0.trailing.equalTo(expenseProgressBar.snp.trailing)
        }

        // financeContainerView 동적 높이 설정
        financeContainerView.snp.makeConstraints {
            $0.bottom.equalTo(expenseProgressBar.snp.bottom).offset(16)
        }

        detailsContainerView.snp.makeConstraints {
            $0.top.equalTo(financeContainerView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().offset(-16)
        }

        detailsTitleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(16)
        }
    }

    // MARK: - Dynamic Content

    func configureDates(with dates: [String], selectedDate: String) {
        dateStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

        for date in dates.prefix(7) {
            let button = UIButton().then {
                $0.setTitle(date, for: .normal)
                $0.setTitleColor(date == selectedDate ? .white : .systemBlue, for: .normal)
                $0.backgroundColor = date == selectedDate ? .systemBlue : .clear
                $0.layer.cornerRadius = 8
                $0.layer.borderColor = UIColor.systemBlue.cgColor
                $0.layer.borderWidth = 1
            }
            dateStackView.addArrangedSubview(button)
        }
    }

    func configureDetails(with data: [[String: String]]) {
        detailsContainerView.subviews.filter { $0 != detailsTitleLabel }.forEach { $0.removeFromSuperview() }

        var previousView: UIView = detailsTitleLabel
        for entry in data {
            let row = createRow(item: entry["항목"] ?? "", amount: entry["금액"] ?? "")
            detailsContainerView.addSubview(row)

            row.snp.makeConstraints {
                $0.top.equalTo(previousView.snp.bottom).offset(8)
                $0.leading.trailing.equalToSuperview().inset(16)
                $0.height.equalTo(40)
            }

            previousView = row
        }
    }

    private func createRow(item: String, amount: String) -> UIView {
        let row = UIView()

        let itemLabel = UILabel().then {
            $0.text = item
            $0.font = UIFont.systemFont(ofSize: 14)
            $0.textColor = .black
        }

        let amountLabel = UILabel().then {
            $0.text = amount
            $0.font = UIFont.systemFont(ofSize: 14)
            $0.textColor = .black
            $0.textAlignment = .right
        }

        row.addSubview(itemLabel)
        row.addSubview(amountLabel)

        itemLabel.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview()
        }

        amountLabel.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview()
        }

        return row
    }
}
