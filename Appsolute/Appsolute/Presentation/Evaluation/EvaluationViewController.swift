//
//  EvaluationViewController.swift
//  Appsolute
//
//  Created by 권민재 on 1/14/25.
//
import UIKit
import SnapKit
import Then


class DropdownMenuView: UIView, UITableViewDataSource, UITableViewDelegate {
    private let tableView = UITableView()
    private let items: [String]
    var onSelect: ((String) -> Void)? // 선택된 항목을 전달하는 클로저

    init(items: [String]) {
        self.items = items
        super.init(frame: .zero)
        setupTableView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupTableView() {
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableView.backgroundColor = .white
        tableView.layer.cornerRadius = 8
        tableView.layer.masksToBounds = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DropdownCell")
    }

    // UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DropdownCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
        cell.textLabel?.textAlignment = .center
        return cell
    }

    // UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = items[indexPath.row]
        onSelect?(selectedItem) // 선택된 항목 전달
        self.removeFromSuperview() // 드롭다운 메뉴 숨김
    }
}


class EvaluationViewController: UIViewController {
    
    private var dropdownMenu: DropdownMenuView?
    private let viewModel = EvaluateViewModel()
    
    private var selectedYear: Int = 2025
    private var selectedPeriod: String = "FIRST_HALF"
    
    // MARK: - UI Components
    private let yearButton = UIButton().then {
        $0.setTitle("2025년 ▼", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 8
    }
    
    private let toggleSegment = UISegmentedControl(items: ["상반기", "하반기"]).then {
        $0.selectedSegmentIndex = 0
        $0.backgroundColor = .white
        $0.selectedSegmentTintColor = .black
        $0.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        $0.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        $0.addTarget(nil, action: #selector(toggleHalfYear), for: .valueChanged)
    }
    
    private let gradeCardView = UIView().then {
        $0.backgroundColor = UIColor(hex: "1073F4")
        $0.layer.cornerRadius = 12
    }
    
    private let gradeImageView = UIImageView().then {
        $0.image = UIImage(named: "유저 인사평가 등급-골드")
        $0.contentMode = .scaleAspectFit
    }
    
    private let gradeLabel = UILabel().then {
        $0.text = "나의 인사평가 등급: 골드"
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.textAlignment = .center
    }
    
    private let xpLabel = UILabel().then {
        $0.text = "획득 경험치: 3600XP"
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        $0.textAlignment = .center
    }
    
    private let tableView = UITableView().then {
        $0.separatorStyle = .none
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 18
        $0.layer.masksToBounds = true
        $0.isUserInteractionEnabled = false
    }
    
    private let grades = [
        ("브론즈", "0XP", "등급 기준 이미지 브론즈"),
        ("실버", "1500XP", "등급 기준 이미지 실버"),
        ("골드", "3000XP", "등급 기준 이미지 골드"),
        ("다이아", "4500XP", "등급 기준 이미지 다이아"),
        ("플래티넘", "6500XP", "등급 기준 이미지 플래티넘")
    ]
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundGradient()
        setupViews()
        setupConstraints()
        setupUI()
        configureTableView()
        setupYearButtonAction()
        fetchEvaluationData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupUI()
        setupUI()
        configureTableView()
        setupYearButtonAction()
        fetchEvaluationData()
    }
    private func fetchEvaluationData() {
        viewModel.fetchEvaluation(year: selectedYear, periodType: selectedPeriod)
        
        // ViewModel에서 데이터 처리
        viewModel.onSuccess = { [weak self] evaluates in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.updateGradeCard(with: evaluates.xp)
            }
        }
        
        viewModel.onError = { error in
            self.showAlert(title: "알림", message: "해당 기간의 인사평가가 없습니다.")
            print("❌ 데이터 로드 실패: \(error)")
        }
    }
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(confirmAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func setupYearButtonAction() {
        yearButton.addTarget(self, action: #selector(didTapYearButton), for: .touchUpInside)
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
        view.addSubview(toggleSegment)
        view.addSubview(gradeCardView)
        gradeCardView.addSubview(gradeImageView)
        gradeCardView.addSubview(gradeLabel)
        gradeCardView.addSubview(xpLabel)
        view.addSubview(tableView)
        
    
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        yearButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(100)
            make.height.equalTo(36)
        }
        
        toggleSegment.snp.makeConstraints { make in
            make.centerY.equalTo(yearButton.snp.centerY)
            make.trailing.equalToSuperview().offset(-20)
            make.width.equalTo(140)
            make.height.equalTo(36)
        }
        
        gradeCardView.snp.makeConstraints { make in
            make.top.equalTo(yearButton.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(195)
        }
        
        gradeImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.width.height.equalTo(86)
        }
        
        gradeLabel.snp.makeConstraints { make in
            make.top.equalTo(gradeImageView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
        }
        
        xpLabel.snp.makeConstraints { make in
            make.top.equalTo(gradeLabel.snp.bottom).offset(11)
            make.leading.trailing.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(gradeCardView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(58)
        }
    }
    func setupUI() {
        let user = UserManager.shared.getUser()
        switch user?.thisEvaluationXP ?? 0 {
        case 0..<1500:
            self.gradeImageView.image = UIImage(named: "유저 인사평가 등급-브론즈")
            self.gradeLabel.text = "나의 인사평가 등급: 브론즈"
            self.xpLabel.text = "획득경험치: \(user?.thisEvaluationXP ?? 0)"
        case 1500..<3000:
            self.gradeImageView.image = UIImage(named: "유저 인사평가 등급-실버")
            self.gradeLabel.text = "나의 인사평가 등급: 실버"
            self.xpLabel.text = "획득경험치: \(user?.thisEvaluationXP ?? 0)"
        case 3000..<4500:
            self.gradeImageView.image = UIImage(named: "유저 인사평가 등급-골드")
            self.gradeLabel.text = "나의 인사평가 등급: 골드"
            self.xpLabel.text = "획득경험치: \(user?.thisEvaluationXP ?? 0)"
        case 4500..<6500:
            self.gradeImageView.image = UIImage(named: "유저 인사평가 등급-다이아")
            self.gradeLabel.text = "나의 인사평가 등급: 다이아"
            self.xpLabel.text = "획득경험치: \(user?.thisEvaluationXP ?? 0)"
        default:
            self.gradeImageView.image = UIImage(named: "유저 인사평가 등급-플래티넘")
            self.gradeLabel.text = "나의 인사평가 등급: 플래티넘"
            self.xpLabel.text = "획득경험치: \(user?.thisEvaluationXP ?? 0)"
        }
    }
    
    private func updateGradeCard(with xp: Int) {
        switch xp {
        case 0..<1500:
            self.gradeImageView.image = UIImage(named: "유저 인사평가 등급-브론즈")
            self.gradeLabel.text = "나의 인사평가 등급: 브론즈"
            self.xpLabel.text = "획득 경험치: \(xp)"
        case 1500..<3000:
            self.gradeImageView.image = UIImage(named: "유저 인사평가 등급-실버")
            self.gradeLabel.text = "나의 인사평가 등급: 실버"
            self.xpLabel.text = "획득 경험치: \(xp)"
        case 3000..<4500:
            self.gradeImageView.image = UIImage(named: "유저 인사평가 등급-골드")
            self.gradeLabel.text = "나의 인사평가 등급: 골드"
            self.xpLabel.text = "획득 경험치: \(xp)"
        case 4500..<6500:
            self.gradeImageView.image = UIImage(named: "유저 인사평가 등급-다이아")
            self.gradeLabel.text = "나의 인사평가 등급: 다이아"
            self.xpLabel.text = "획득 경험치: \(xp)"
        default:
            self.gradeImageView.image = UIImage(named: "유저 인사평가 등급-플래티넘")
            self.gradeLabel.text = "나의 인사평가 등급: 플래티넘"
            self.xpLabel.text = "획득 경험치: \(xp)"
        }
    }
    
    // MARK: - Configure TableView
    private func configureTableView() {
        let headerView = UIView()
        headerView.backgroundColor = .white
        let titleLabel = UILabel().then {
            $0.text = "< 인사평가 등급 기준 >"
            $0.textColor = .black
            $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            $0.textAlignment = .center
        }

        headerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(20)
        }

        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 60)
        tableView.tableHeaderView = headerView

        tableView.dataSource = self
        tableView.rowHeight = 55
        tableView.register(GradeCell.self, forCellReuseIdentifier: GradeCell.identifier)
    }
    
    // MARK: - Toggle Half Year
    @objc private func toggleHalfYear(sender: UISegmentedControl) {
           selectedPeriod = sender.selectedSegmentIndex == 0 ? "FIRST_HALF" : "SECOND_HALF"
           fetchEvaluationData()
       }
}

// MARK: - UITableViewDataSource
extension EvaluationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return grades.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GradeCell.identifier, for: indexPath) as? GradeCell else {
            return UITableViewCell()
        }
        let grade = grades[indexPath.row]
        cell.configure(title: grade.0, xp: grade.1, imageName: grade.2)
        return cell
    }
}

// MARK: - GradeCell
class GradeCell: UITableViewCell {
    static let identifier = "GradeCell"
    
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.textColor = .black
    }
    private let xpLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        $0.textAlignment = .right
        $0.textColor = .black
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
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
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(20)
            make.centerY.equalToSuperview()
        }
        
        xpLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
    }
    
    func configure(title: String, xp: String, imageName: String) {
        iconImageView.image = UIImage(named: imageName)
        titleLabel.text = title
        xpLabel.text = xp
    }
}
extension EvaluationViewController {
    @objc private func didTapYearButton() {
           if let dropdown = dropdownMenu {
               UIView.animate(withDuration: 0.3, animations: {
                   dropdown.alpha = 0
               }) { _ in
                   dropdown.removeFromSuperview()
                   self.dropdownMenu = nil
               }
               return
           }
           
           let dropdown = DropdownMenuView(items: ["2025년", "2024년"])
           dropdown.onSelect = { [weak self] selectedYear in
               guard let self = self else { return }
               self.selectedYear = Int(selectedYear.dropLast(1)) ?? 2025
               self.yearButton.setTitle("\(selectedYear) ▼", for: .normal)
               self.fetchEvaluationData() // 데이터 갱신
           }
           
           view.addSubview(dropdown)
           dropdown.snp.makeConstraints { make in
               make.top.equalTo(yearButton.snp.bottom).offset(8)
               make.leading.equalTo(yearButton.snp.leading)
               make.width.equalTo(yearButton.snp.width)
               make.height.equalTo(100)
           }
           
           dropdownMenu = dropdown
       }
}

