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
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(hex: "DCEBFF") // 배경색
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
        view.backgroundColor = UIColor(hex: "DCEBFF")
        setupNavigationBar()
        setupCollectionView()
    }
    
    // MARK: - Setup
    private func setupNavigationBar() {
        title = "알림함"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(backTapped)
        )
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Actions
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension AlertViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
            make.edges.equalToSuperview()
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


