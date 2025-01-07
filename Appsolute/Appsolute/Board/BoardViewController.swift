//
//  BoardViewController.swift
//  Appsolute
//
//  Created by 권민재 on 1/7/25.
//

import UIKit
import SnapKit

class BoardViewController: UIViewController {

    // MARK: - Properties
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16 // 셀 사이 간격
        layout.minimumInteritemSpacing = 0 // 행 간 간격
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16) // 컬렉션 뷰의 패딩
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: 120) // 셀 크기 설정
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()

    private let data: [BoardItem] = [
        BoardItem(title: "상반기 인사발령 안내", description: "2025년 상반기 정기 인사발령 안내", date: "2025.01.04", isNew: true),
        BoardItem(title: "복리후생 공지", description: "동호회 운영 지침 및 지원금 신청 방법 안내", date: "2025.01.04", isNew: true),
        BoardItem(title: "사내 시스템 임시 점검 안내", description: "1월 20일(토) 02:00-06:00 시스템 점검", date: "2024.12.18", isNew: false)
    ]

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupCollectionView()
        setupConstraints()
    }

    // MARK: - Setup
    private func setupNavigationBar() {
        title = "게시판"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBackground
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 18, weight: .bold)
        ]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    private func setupCollectionView() {
        collectionView.backgroundColor = UIColor(red: 240/255, green: 248/255, blue: 1, alpha: 1) // 배경 색상
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(BoardCollectionViewCell.self, forCellWithReuseIdentifier: BoardCollectionViewCell.identifier)
        view.addSubview(collectionView)
    }

    private func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension BoardViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoardCollectionViewCell.identifier, for: indexPath) as? BoardCollectionViewCell else {
            return UICollectionViewCell()
        }
        let item = data[indexPath.item]
        cell.configure(with: item)
        return cell
    }
}

// MARK: - BoardCollectionViewCell
class BoardCollectionViewCell: UICollectionViewCell {
    static let identifier = "BoardCollectionViewCell"

    // UI Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .darkGray
        label.numberOfLines = 0
        return label
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .lightGray
        return label
    }()

    private let newBadge: UILabel = {
        let label = UILabel()
        label.text = "NEW"
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .red
        label.backgroundColor = UIColor(red: 255/255, green: 240/255, blue: 240/255, alpha: 1)
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        backgroundColor = .white
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 6
        clipsToBounds = false

        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(newBadge)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(16)
        }

        dateLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            $0.leading.equalTo(titleLabel)
            $0.bottom.equalToSuperview().inset(16)
        }

        newBadge.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(20)
            $0.width.equalTo(40)
        }
    }

    func configure(with item: BoardItem) {
        titleLabel.text = item.title
        descriptionLabel.text = item.description
        dateLabel.text = item.date
        newBadge.isHidden = !item.isNew
    }
}

// MARK: - BoardItem Model
struct BoardItem {
    let title: String
    let description: String
    let date: String
    let isNew: Bool
}
