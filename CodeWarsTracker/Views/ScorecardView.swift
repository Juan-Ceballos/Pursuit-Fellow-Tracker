//
//  ScorecardView.swift
//  CodeWarsTracker
//
//  Created by Bienbenido Angeles on 8/24/21.
//

import UIKit
import SnapKit

public enum Section: String, CaseIterable {
    case fellow
    case staff
    case leaderBoard
    
    var sectionTitle: String {
        switch self {
        case .fellow:
            return "Fellow"
        case .staff:
            return "Staff"
        case .leaderBoard:
            return "LeaderBoard"
        }
    }
    
    var columnCount: Int {
        switch self {
        case .fellow, .staff:
            return 2
        case .leaderBoard:
            return 3
        }
    }
}

public enum Constants {
    static let badgeElementKind = "badge-element-kind"
    static let headerElementKind = "header-element-kind"
    static let footerElementKind = "footer-element-kind"
}

class ScoreCardView: UIView {
    
    public lazy var cv: UICollectionView = {
        let layout = createLayout()
        let mainCV = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        mainCV.backgroundColor = .systemBackground
        return mainCV
    }()
    
    private func createLayout() -> UICollectionViewLayout {
        let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.125))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize, elementKind: Constants.headerElementKind, alignment: .topLeading)
        let itemInsets: CGFloat = 8
        let groupInsets: CGFloat = 8
        
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: itemInsets, leading: itemInsets, bottom: itemInsets, trailing: itemInsets)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    public lazy var scoreboardContainerStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.spacing = 13
        stackview.distribution = .equalSpacing
        stackview.alignment = .center
        stackview.backgroundColor = .systemBlue
        stackview.addArrangedSubview(scoreboardLabel)
        stackview.addArrangedSubview(scoreboardDataStackView)
        stackview.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        stackview.isLayoutMarginsRelativeArrangement = true
        stackview.layer.cornerRadius = 8
        return stackview
    }()
    
    public lazy var scoreboardDataStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 13
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .systemBlue
        stackView.addArrangedSubview(scoreboardWeeklyLabel)
        stackView.addArrangedSubview(scoreboardMonthlyLabel)
        stackView.addArrangedSubview(scoreboardAllTimeLabel)
        return stackView
    }()
    
    public lazy var scoreboardLabel: UILabel = {
        let label = UILabel()
        label.text = "Score Board"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = .systemBackground
        label.backgroundColor = .systemBlue
        return label
    }()
    
    public lazy var scoreboardWeeklyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBackground
        label.numberOfLines = 5
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.text = "Weekly"
        return label
    }()
    
    public lazy var scoreboardMonthlyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBackground
        label.numberOfLines = 5
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.text = "Monthly"
        return label
    }()
    
    public lazy var scoreboardAllTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBackground
        label.numberOfLines = 5
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.text = "All Time"
        return label
    }()
    
    public lazy var segmentedControl: UISegmentedControl = {
        let sC = UISegmentedControl()
        sC.insertSegment(withTitle: "All", at: 0, animated: false)
        sC.insertSegment(withTitle: "7.1", at: 1, animated: false)
        sC.insertSegment(withTitle: "7.2", at: 2, animated: false)
        sC.insertSegment(withTitle: "8.1", at: 3, animated: false)
        sC.insertSegment(withTitle: "8.2", at: 4, animated: false)
        sC.selectedSegmentIndex = 0
        return sC
    }()
    
    public lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.barStyle = .default
        sb.enablesReturnKeyAutomatically = false
        return sb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        scoreboardContainerStackViewContrainsts()
        setupSearchBarConstraints()
        scoreboardContainerStackViewSubView1Contrainsts()
        setupSegmentedControlConstraints()
        setupCollectionViewConstraints()
    }
    
    private func scoreboardContainerStackViewContrainsts(){
        addSubview(scoreboardContainerStackView)
        scoreboardContainerStackView.snp.makeConstraints { mkr in
            mkr.centerX.equalToSuperview()
            mkr.top.equalTo(safeAreaLayoutGuide).offset(10)
            mkr.width.equalToSuperview().offset(-21)
        }
    }
    
    private func setupSearchBarConstraints() {
        addSubview(searchBar)
        searchBar.snp.makeConstraints { (make) in
            make.top.equalTo(scoreboardContainerStackView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
        }
    }
    
    private func scoreboardContainerStackViewSubView1Contrainsts(){
        for subview in scoreboardContainerStackView.arrangedSubviews{
            subview.sizeToFit()
            subview.layoutIfNeeded()
        }
    }
    
    private func setupSegmentedControlConstraints() {
        addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints { (make) in
            make.top.equalTo(searchBar.snp.bottom).offset(8)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.05)
        }
    }
    
    private func setupCollectionViewConstraints() {
        addSubview(cv)
        cv.snp.makeConstraints { (make) in
            make.top.equalTo(segmentedControl.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
    
}
