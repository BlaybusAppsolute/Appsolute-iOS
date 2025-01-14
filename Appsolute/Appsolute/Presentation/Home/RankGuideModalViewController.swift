//
//  RankGuideModalViewController.swift
//  Appsolute
//
//  Created by 권민재 on 1/14/25.
//


import UIKit
import SnapKit
import Then
class RankGuideModalViewController: UIViewController {
    
    // MARK: - UI Components
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let collectionView: UICollectionView
    private let closeButton = UIButton(type: .system)
    
    // 데이터
    private let rankData: [(imageName: String, title: String, xp: String)] = [
        ("1", "Lv.1 꿈틀이 씨앗-1", "0XP"),
        ("1", "Lv.2 꿈틀이 씨앗-2", "13,500XP"),
        ("2", "Lv.3 자라나는 새싹-1", "27,000XP"),
        ("2", "Lv.3 자라나는 새싹-2", "39,000XP"),
        ("3", "Lv.3 쑥쑥 잎사귀-1", "51,000XP"),
        ("3", "Lv.3 쑥쑥 잎사귀-2", "63,000XP"),
        ("3", "Lv.3 쑥쑥 잎사귀-3", "78,000XP"),
        ("4", "Lv.4 푸릇푸릇 초목-1", "93,000XP"),
        ("4", "Lv.4 푸릇푸릇 초목-2", "108,000XP"),
        ("5", "Lv.5 우뚝 나무-1", "126,000XP"),
        ("5", "Lv.5 우뚝 나무-2", "144,000XP"),
        ("6", "Lv.6 만개 꽃나무", "162,000XP")
    ]
    // MARK: - Init
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 60, height: 60)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        super.init(nibName: nil, bundle: nil)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(RankCell.self, forCellWithReuseIdentifier: RankCell.identifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        // 컨테이너 뷰
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 16
        containerView.clipsToBounds = true
        view.addSubview(containerView)
        
        // 타이틀 라벨
        titleLabel.text = "<등급 가이드>"
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = UIColor(hex: "0B52AD")
        titleLabel.textAlignment = .center
        containerView.addSubview(titleLabel)
        
        // 컬렉션 뷰
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = true
        //collectionView.backgroundColor = .blue
        containerView.addSubview(collectionView)
        
        // 닫기 버튼
        closeButton.setTitle("닫기", for: .normal)
        closeButton.setTitleColor(UIColor(hex: "0b52ad"), for: .normal)
        closeButton.backgroundColor = UIColor(hex: "dcebff")
        closeButton.layer.cornerRadius = 10
        closeButton.addTarget(self, action: #selector(dismissModal), for: .touchUpInside)
        containerView.addSubview(closeButton)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(46)
            make.top.equalToSuperview().inset(120)
            make.bottom.equalToSuperview().inset(216)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(106)
            make.height.equalTo(18)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(closeButton.snp.top).offset(40)
        }
        
        closeButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
    
    // MARK: - Actions
    @objc private func dismissModal() {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UICollectionView DataSource & Delegate
extension RankGuideModalViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rankData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RankCell.identifier, for: indexPath) as? RankCell else {
            return UICollectionViewCell()
        }
        let rank = rankData[indexPath.item]
        cell.configure(imageName: rank.imageName, title: rank.title, xp: rank.xp)
        return cell
    }
}

class RankCell: UICollectionViewCell {
    static let identifier = "RankCell"
    
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    private let titleLabel = UILabel().then {
        $0.textColor = UIColor(hex: "1073f4")
        $0.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
    }
    
    private let xpLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = UIColor.darkGray
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(xpLabel)
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(45)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(48)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(27)
            make.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        xpLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-8)
        }
    }
    
    func configure(imageName: String, title: String, xp: String) {
        imageView.image = UIImage(named: imageName)
        titleLabel.text = title
        xpLabel.text = xp
    }
}
