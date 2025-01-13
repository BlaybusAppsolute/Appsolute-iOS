//
//  EvaluationViewController.swift
//  Appsolute
//
//  Created by 권민재 on 1/14/25.
//

import UIKit
import SnapKit
import Then

class EvaluationViewController: UIViewController {

    // MARK: - UI Components
    private let yearButton = UIButton().then {
        $0.setTitle("2025년 ▼", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
    }
    
    private let toggleContainer = UIView()
    private let firstHalfButton = UIButton().then {
        $0.setTitle("상반기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = .black
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        $0.layer.cornerRadius = 8
    }
    private let secondHalfButton = UIButton().then {
        $0.setTitle("하반기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .white
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        $0.layer.cornerRadius = 8
    }
    
    private let gradeCardView = UIView().then {
        $0.backgroundColor = UIColor(hex: "1073F4")
        $0.layer.cornerRadius = 12
    }
    
    private let gradeImageView = UIImageView().then {
        $0.image = UIImage(named: "gold") // 등급 이미지
        $0.contentMode = .scaleAspectFit
    }
    
    private let gradeLabel = UILabel().then {
        $0.text = "나의 인사평가 등급: 골드"
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.textAlignment = .center
    }
    
    private let xpLabel = UILabel().then {
        $0.text = "획득 경험치: 3600PX"
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        $0.textAlignment = .center
    }
    
    private let gradeListTitleLabel = UILabel().then {
        $0.text = "< 인사평가 등급 기준 >"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.textAlignment = .center
    }
    
    private let gradeTableView = UITableView().then {
        $0.separatorStyle = .none
        $0.isScrollEnabled = false
    }
    
    private let grades = [
        ("브론즈", "0XP", "bronze"),
        ("실버", "1500XP", "silver"),
        ("골드", "3000XP", "gold"),
        ("다이아", "4500XP", "diamond"),
        ("플래티넘", "6500XP", "platinum")
    ]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "인사평가"
        setupBackgroundGradient()
        setupViews()
        setupConstraints()
        
        gradeTableView.dataSource = self
        gradeTableView.register(GradeCell.self, forCellReuseIdentifier: GradeCell.identifier)
    }
    
    // MARK: - Setup Gradient Background
    private func setupBackgroundGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(hex: "#B5D4FC").cgColor,
            UIColor(hex: "#E7F1FE").cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.addSubview(yearButton)
        view.addSubview(toggleContainer)
        toggleContainer.addSubview(firstHalfButton)
        toggleContainer.addSubview(secondHalfButton)
        view.addSubview(gradeCardView)
        gradeCardView.addSubview(gradeImageView)
        gradeCardView.addSubview(gradeLabel)
        gradeCardView.addSubview(xpLabel)
        view.addSubview(gradeListTitleLabel)
        view.addSubview(gradeTableView)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        yearButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(100)
            make.height.equalTo(36)
        }
        
        toggleContainer.snp.makeConstraints { make in
            make.centerY.equalTo(yearButton.snp.centerY)
            make.trailing.equalToSuperview().offset(-20)
            make.width.equalTo(140)
            make.height.equalTo(36)
        }
        
        firstHalfButton.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        
        secondHalfButton.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        
        gradeCardView.snp.makeConstraints { make in
            make.top.equalTo(yearButton.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(160)
        }
        
        gradeImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.width.height.equalTo(80)
        }
        
        gradeLabel.snp.makeConstraints { make in
            make.top.equalTo(gradeImageView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
        }
        
        xpLabel.snp.makeConstraints { make in
            make.top.equalTo(gradeLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview()
        }
        
        gradeListTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(gradeCardView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
        }
        
        gradeTableView.snp.makeConstraints { make in
            make.top.equalTo(gradeListTitleLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(300)
        }
    }
}

// MARK: - UITableViewDataSource
extension EvaluationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return grades.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GradeCell.identifier, for: indexPath) as! GradeCell
        let grade = grades[indexPath.row]
        cell.configure(title: grade.0, xp: grade.1, imageName: grade.2)
        return cell
    }
}

// MARK: - Custom UITableViewCell
class GradeCell: UITableViewCell {
    static let identifier = "GradeCell"
    
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    }
    private let xpLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        $0.textAlignment = .right
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(xpLabel)
    }
    
    private func setupConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
        }
        
        xpLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    func configure(title: String, xp: String, imageName: String) {
        titleLabel.text = title
        xpLabel.text = xp
        iconImageView.image = UIImage(named: imageName)
    }
}
