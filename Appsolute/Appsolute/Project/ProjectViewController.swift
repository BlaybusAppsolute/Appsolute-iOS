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
        BoardItem(title: "상반기 인사발령 안내", description: "2025년 상반기 정기 인사발령 안내", date: "2025.01.04", isNew: true),
        BoardItem(title: "복리후생 공지", description: "동호회 운영 지침 및 지원금 신청 방법 안내", date: "2025.01.04", isNew: true),
        BoardItem(title: "사내 시스템 임시 점검 안내", description: "1월 20일(토) 02:00-06:00 시스템 점검", date: "2024.12.18", isNew: false)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupCustomBackButton()
        setupCollectionView()
        setupConstraints()
    }

 
    private func setupNavigationBar() {
        title = "전사 프로젝트 내역"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.clear
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 18, weight: .bold)
        ]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
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
        collectionView.backgroundColor = UIColor(red: 240/255, green: 248/255, blue: 1, alpha: 1)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProjectCell.self, forCellWithReuseIdentifier: ProjectCell.identifier)
        view.addSubview(collectionView)
    }

    private func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
    //MARK: UI
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: 120)
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
