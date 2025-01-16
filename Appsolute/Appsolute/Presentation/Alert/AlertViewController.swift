//
//  AlertViewController.swift
//  Appsolute
//
//  Created by 권민재 on 1/15/25.
//

import UIKit
import SnapKit
import Then

class AlertViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(hex: "E7F1FE") // 배경색
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AlertCell.self, forCellWithReuseIdentifier: AlertCell.identifier)
        return collectionView
    }()
    
    // Dummy data
    private let alerts: [Alert] = [
        Alert(title: "신규 경험치 획득", description: "인사 평가가 도착했습니다.", date: "2025.01.04"),
        Alert(title: "신규 경험치 획득", description: "직무별 퀘스트를 완료하여 경험치를 획득했습니다. 어찌구 저찌구", date: "2025.01.04"),
        Alert(title: "신규 경험치 획득", description: "인사 평가가 도착했습니다.", date: "2025.01.04"),
        Alert(title: "신규 경험치 획득", description: "인사 평가가 도착했습니다.", date: "2025.01.04")
    ]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "E7F1FE")
        tabBarController?.tabBar.isHidden = true
        setupCustomBackButton()
        setupCollectionView()
    }
    
    // MARK: - Custom Back Button
    private func setupCustomBackButton() {
        let backButton = UIButton(type: .system).then {
            $0.setImage(UIImage(systemName: "chevron.left"), for: .normal) // 뒤로가기 화살표 아이콘
//            $0.setTitle(" 뒤로", for: .normal) // 텍스트 추가
            $0.setTitleColor(.black, for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            $0.addTarget(self, action: #selector(moveToHome), for: .touchUpInside)
        }
        
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10) // 상단 여백
            make.leading.equalToSuperview().offset(20) // 왼쪽 여백
            make.height.equalTo(40) // 버튼 높이
        }
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(60) // Back 버튼 아래
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    @objc private func moveToHome() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension AlertViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return alerts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlertCell.identifier, for: indexPath) as? AlertCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: alerts[indexPath.item])
        return cell
    }
    
    // 셀 크기 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        return CGSize(width: width, height: 170) // 높이는 100으로 고정
    }
}

// MARK: - AlertCell
class AlertCell: UICollectionViewCell {
    static let identifier = "AlertCell"
    
    // UI Components
    private let titleLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.textColor = .black
    }
    
    private let descriptionLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .gray
        $0.numberOfLines = 0
    }
    
    private let dateLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textColor = .lightGray
    }
    
    private let containerView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }
    
    // Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(dateLabel)
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10) // 셀 안쪽 여백
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(12)
        }
    }
    
    // Configure cell
    func configure(with alert: Alert) {
        titleLabel.text = alert.title
        descriptionLabel.text = alert.description
        dateLabel.text = alert.date
    }
}

// MARK: - Alert Model
struct Alert {
    let title: String
    let description: String
    let date: String
}
