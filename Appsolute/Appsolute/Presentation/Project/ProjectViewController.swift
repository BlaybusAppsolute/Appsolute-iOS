//
//  ProjectViewController.swift
//  Appsolute
//
//  Created by 권민재 on 1/8/25.
//

import UIKit
import SnapKit

class ProjectViewController: UIViewController {

    private let data: [BoardItem] = [
        BoardItem(boardId: 1, title: "상반기 인사발령 안내", content: "2025년 상반기 정기 인사발령 안내", createdAt: "2025.01.04"),
            BoardItem(boardId: 2, title: "복리후생 공지", content: "동호회 운영 지침 및 지원금 신청 방법 안내", createdAt: "2025.01.04"),
            BoardItem(boardId: 3, title: "사내 시스템 임시 점검 안내", content: "1월 20일(토) 02:00-06:00 시스템 점검", createdAt: "2024.12.18")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupCustomBackButton()
        setupCollectionView()
        setupConstraints()
        setupBackgroundGradient()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        setupCustomBackButton()
        setupCollectionView()
        setupConstraints()
        setupBackgroundGradient()
    }
    private func setupBackgroundGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(hex: "#B5D4FC").cgColor,
            UIColor(hex: "#E7F1FE").cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.frame = view.bounds // 전체 화면에 그라데이션
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

 
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .clear // NavigationBar 투명하게 설정
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 18, weight: .bold)
        ]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.isTranslucent = true // 투명 효과 활성화
    }
    private func setupCustomBackButton() {
    
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
        
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.setBackIndicatorImage(UIImage(systemName: "chevron.backward"), transitionMaskImage: UIImage(systemName: "chevron.backward"))
        appearance.backButtonAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.clear
        ]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    private func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProjectCell.self, forCellWithReuseIdentifier: ProjectCell.identifier)
        view.addSubview(collectionView)
    }

    private func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    
    //MARK: UI
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: 161)
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
}


extension ProjectViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProjectCell.identifier, for: indexPath) as? ProjectCell else {
            return UICollectionViewCell()
        }
        let item = data[indexPath.item]
        cell.configure(with: item)
        return cell
    }

}
