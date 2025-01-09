//
//  QuestViewController.swift
//  Appsolute
//
//  Created by 권민재 on 1/9/25.
//


import UIKit
import SnapKit

class QuestViewController: UIViewController {

    // MARK: - Properties
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionHeadersPinToVisibleBounds = false
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .backgroundColor
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.identifier)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader")
        collectionView.register(QuestCardCell.self, forCellWithReuseIdentifier: QuestCardCell.identifier)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        setupViews()
        setupConstraints()
    }

    private func setupViews() {
        view.addSubview(collectionView)
    }

    private func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension QuestViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 0 : 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuestCardCell.identifier, for: indexPath) as! QuestCardCell
        if indexPath.section == 1 {
            cell.configure(
                badgeText: "월 퀘스트",
                title: "월간 퀘스트 \(indexPath.row + 1)",
                subtitle: "월 퀘스트 설명 \(indexPath.row + 1)",
                badgeColor: .systemBlue,
                buttonAction: { print("월 퀘스트 \(indexPath.row + 1) 클릭") }
            )
        } else {
            cell.configure(
                badgeText: "주차별 퀘스트",
                title: "주차 퀘스트 \(indexPath.row + 1)",
                subtitle: "주차 퀘스트 설명 \(indexPath.row + 1)",
                badgeColor: .systemGreen,
                buttonAction: { print("주차 퀘스트 \(indexPath.row + 1) 클릭") }
            )
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: 150)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: collectionView.frame.width, height: 120)
        } else {
            return CGSize(width: collectionView.frame.width, height: 40) //
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            if indexPath.section == 0 {
                
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.identifier, for: indexPath) as! HeaderView
                header.configure(
                    date: "2025.01",
                    weeks: [
                        ("1주차", ""),
                        ("2주차", ""),
                        ("3주차", "01.01 - 08"),
                        ("4주차", ""),
                        ("5주차", "")
                    ],
                    selectedWeek: 3,
                    onLeftButtonTap: { print("이전 달로 이동") },
                    onRightButtonTap: { print("다음 달로 이동") },
                    onWeekChanged: { selectedWeek in
                        print("선택된 주차: \(selectedWeek)")
                    }
                )
                return header
            } else {
                // 섹션별 헤더
                let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath)
                sectionHeader.backgroundColor = .clear
                
                let titleLabel = UILabel()
                titleLabel.text = indexPath.section == 1 ? "월 퀘스트" : "주차별 퀘스트"
                titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
                titleLabel.textColor = .darkGray
                sectionHeader.addSubview(titleLabel)
                
                titleLabel.snp.makeConstraints { make in
                    make.leading.equalToSuperview().offset(16)
                    make.centerY.equalToSuperview()
                }
                
                return sectionHeader
            }
        }
        return UICollectionReusableView()
    }
}
