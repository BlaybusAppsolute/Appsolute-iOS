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
        $0.text = "| 일별 재무내역"
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

    // MARK: - Data
    private var allDetails: [DepartmentQuestDetailResponse.Detail] = [] // 전체 데이터를 저장

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        bindDateSelector()
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



        barChartView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
        detailsTitleLabel.snp.makeConstraints {
            $0.top.equalTo(barChartView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        detailsHeaderView.snp.makeConstraints {
            $0.top.equalTo(detailsTitleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }
        detailsContainerView.snp.makeConstraints {
            $0.top.equalTo(detailsHeaderView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(20)
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
    }

    private func createDetailRow(item: String, amount: String, isEven: Bool) -> UIView {
        let rowView = UIView()
        rowView.backgroundColor = isEven ? UIColor(hex: "e7f1fe") : UIColor(hex: "f6f6f6")

        let itemLabel = UILabel().then {
            $0.text = item
            $0.font = UIFont.systemFont(ofSize: 14)
            $0.textColor = UIColor(hex: "408FF6")
            $0.textAlignment = .center
        }

        let amountLabel = UILabel().then {
            $0.text = amount
            $0.font = UIFont.systemFont(ofSize: 14)
            $0.textColor = UIColor(hex: "408FF6")
            $0.textAlignment = .center
        }

        rowView.addSubview(itemLabel)
        rowView.addSubview(amountLabel)

        itemLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5)
        }

        amountLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5)
        }

        return rowView
    }

    // MARK: - Bind Date Selector
    private func bindDateSelector() {
        dateSelectorView.onDateSelected = { [weak self] selectedDate in
            guard let self = self else { return }
            self.updateDetailsView(for: selectedDate)
        }
    }

    // MARK: - Configure Method
    func configure(with details: [DepartmentQuestDetailResponse.Detail], gainedXP: Int, productivity: Double) {
        // 전체 데이터 저장
        allDetails = details

        // 기본 첫 번째 날짜로 초기화
        if let firstDate = details.first?.departmentQuestDetailDate {
            dateSelectorView.configureDates(details.map { $0.departmentQuestDetailDate })
            updateDetailsView(for: firstDate)
        }
    }

    private func updateDetailsView(for date: String) {
        // 해당 날짜의 데이터만 표시
        guard let detail = allDetails.first(where: { $0.departmentQuestDetailDate == date }) else { return }
        
        barChartView.configure(
            income: Int(detail.revenue),        // 수익을 BarChart의 income으로 사용
            expense: Int(detail.laborCost),    // 지출을 BarChart의 expense로 사용
            maxValue: max(Int(detail.revenue), Int(detail.laborCost)) // 최대값은 수익과 지출 중 큰 값
        )

        // 기존 행 제거
        detailsContainerView.subviews
            .filter { $0 != detailsHeaderView }
            .forEach { $0.removeFromSuperview() }

        // 새로운 행 추가
        let rowValues = [
            ("설계 용역비", "\(detail.designServiceFee)"),
            ("직원 급여", "\(detail.employeeSalary)"),
            ("퇴직 급여", "\(detail.retirementBenefit)"),
            ("사회 보험료", "\(detail.socialInsuranceBenefit)")
        ]

        var previousRow: UIView = detailsHeaderView
        rowValues.enumerated().forEach { index, value in
            let rowView = createDetailRow(item: value.0, amount: value.1, isEven: index % 2 == 0)
            detailsContainerView.addSubview(rowView)
            rowView.snp.makeConstraints {
                $0.top.equalTo(previousRow.snp.bottom)
                $0.leading.trailing.equalToSuperview()
                $0.height.equalTo(40)
            }
            previousRow = rowView
        }
    }
}
