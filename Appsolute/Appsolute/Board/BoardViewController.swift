//
//  BoardViewController.swift
//  Appsolute
//
//  Created by 권민재 on 1/7/25.
//

import UIKit
import SnapKit

class BoardViewController: UIViewController {

    @IBOutlet var backgroundView: UIImageView!
    private let data: [BoardItem] = [
        BoardItem(title: "상반기 인사발령 안내", description: "2025년 상반기 정기 인사발령 안내", date: "2025.01.04", isNew: true),
        BoardItem(title: "복리후생 공지", description: "동호회 운영 지침 및 지원금 신청 방법 안내", date: "2025.01.04", isNew: true),
        BoardItem(title: "사내 시스템 임시 점검 안내", description: "1월 20일(토) 02:00-06:00 시스템 점검", date: "2024.12.18", isNew: false),
        BoardItem(title: "복리후생 공지", description: "동호회 운영 지침 및 지원금 신청 방법 안내", date: "2025.01.04", isNew: true),
        BoardItem(title: "복리후생 공지", description: "동호회 운영 지침 및 지원금 신청 방법 안내", date: "2025.01.04", isNew: true),
        BoardItem(title: "복리후생 공지", description: "동호회 운영 지침 및 지원금 신청 방법 안내", date: "2025.01.04", isNew: true),
        BoardItem(title: "복리후생 공지", description: "동호회 운영 지침 및 지원금 신청 방법 안내", date: "2025.01.04", isNew: true),
        BoardItem(title: "복리후생 공지", description: "동호회 운영 지침 및 지원금 신청 방법 안내", date: "2025.01.04", isNew: true)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        backgroundView.isUserInteractionEnabled = true
        setupNavigationBar()
        setupCustomBackButton()
        setupCollectionView()
        setupConstraints()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
        setupCustomBackButton()
        setupCollectionView()
        setupConstraints()
        
    }

 
    private func setupNavigationBar() {
        navigationController?.hidesBarsOnSwipe = true
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.clear
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 22, weight: .bold)
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
        collectionView.backgroundColor = .clear
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
