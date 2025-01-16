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

    let dateSelectorView = DateSelectorView()

    let outcomeView = UIView().then {
        $0.backgroundColor = UIColor(hex: "e7f1fe")
        $0.layer.cornerRadius = 12
    }
    
    let barChartView = BarChartView()
    

    private let detailsTitleLabel = UILabel().then {
        $0.text = "< 지출 상세내역 >"
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.textColor = UIColor(hex: "1a73e8")
        $0.textAlignment = .center
    }

    private let detailsContainerView = UIView().then {
        $0.layer.cornerRadius = 8
        $0.backgroundColor = UIColor(hex: "ffffff")
        $0.layer.borderWidth = 1.5
        $0.layer.borderColor = UIColor(hex: "408FF6").cgColor
    }

    private let detailsHeaderView = UIView().then {
        $0.backgroundColor = UIColor(hex: "1a73e8")
        $0.layer.cornerRadius = 8
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    private let headerLabels: [UILabel] = [
        UILabel().then {
            $0.text = "지출 항목"
            $0.font = UIFont.boldSystemFont(ofSize: 14)
            $0.textColor = .white
            $0.textAlignment = .center
        },
        UILabel().then {
            $0.text = "금액"
            $0.font = UIFont.boldSystemFont(ofSize: 14)
            $0.textColor = .white
            $0.textAlignment = .center
        }
    ]

    private let detailsRows: [[String]] = [
        ["인건비", "4"],
        ["직원급여", "1"],
        ["퇴직급여", "1"],
        ["4대 보험료", "1"],
        ["설계용역비", "1"]
    ]

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        barChartView.configure(income: 10, expense: 8, maxValue: 20)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(titleLabel)
        addSubview(dateSelectorView)
        addSubview(outcomeView)

        outcomeView.addSubview(detailsTitleLabel)
        outcomeView.addSubview(detailsContainerView)
        outcomeView.addSubview(barChartView)
        detailsContainerView.addSubview(detailsHeaderView)
        headerLabels.forEach { detailsHeaderView.addSubview($0) }


        // Create rows dynamically
        detailsRows.enumerated().forEach { index, row in
            let rowView = createDetailRow(item: row[0], amount: row[1], isEven: index % 2 == 1)
            detailsContainerView.addSubview(rowView)
        }
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(20)
        }

        dateSelectorView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.height.equalTo(60)
        }

        outcomeView.snp.makeConstraints {
            $0.top.equalTo(dateSelectorView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(450)
        }


        detailsTitleLabel.snp.makeConstraints {
            $0.top.equalTo(outcomeView.snp.top).offset(117)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        detailsContainerView.snp.makeConstraints {
            $0.top.equalTo(detailsTitleLabel.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview().inset(20)
            $0.bottom.equalTo(detailsContainerView.snp.bottom).inset(20)
        }
        barChartView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(detailsHeaderView.snp.bottom).inset(20)
        }

        detailsHeaderView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }

        headerLabels[0].snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5)
        }

        headerLabels[1].snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5)
        }

        // Create row constraints
        var previousRow: UIView = detailsHeaderView
        for rowView in detailsContainerView.subviews.filter({ $0 !== detailsHeaderView }) {
            rowView.snp.makeConstraints {
                $0.top.equalTo(previousRow.snp.bottom)
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(40)
            }
            previousRow = rowView
        }
    }

    private func createDetailRow(item: String, amount: String, isEven: Bool) -> UIView {
        let rowView = UIView()
        rowView.backgroundColor = isEven ? UIColor(hex: "e7f1fe") : UIColor(hex: "f6f6f6")
        rowView.layer.borderWidth = 1
        rowView.layer.borderColor = UIColor(hex: "d6e4fd").cgColor

        let itemLabel = UILabel().then {
            $0.text = item
            $0.font = UIFont.systemFont(ofSize: 14)
            $0.textColor = UIColor(hex: "408FF6")
            $0.textAlignment = .center
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor(hex: "B5D4FC").cgColor
        }

        let amountLabel = UILabel().then {
            $0.text = amount
            $0.font = UIFont.systemFont(ofSize: 14)
            $0.textColor = UIColor(hex: "408FF6")
            $0.textAlignment = .center
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor(hex: "B5D4FC").cgColor
        }

        rowView.addSubview(itemLabel)
        rowView.addSubview(amountLabel)

        itemLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5)
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
        }

        amountLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5)
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
        }

        return rowView
    }
  

    private func applyGradient(to view: UIView, colors: [CGColor]) {
          // 기존 GradientLayer 제거
          view.layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }

          let gradientLayer = CAGradientLayer()
          gradientLayer.colors = colors
          gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
          gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
          gradientLayer.frame = view.bounds
          gradientLayer.cornerRadius = view.layer.cornerRadius
          view.layer.insertSublayer(gradientLayer, at: 0)
      }
}
