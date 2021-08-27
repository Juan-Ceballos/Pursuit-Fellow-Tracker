//
//  ScorecardView.swift
//  CodeWarsTracker
//
//  Created by Bienbenido Angeles on 8/24/21.
//

import UIKit
import SnapKit

public enum Section: CaseIterable {
    case fellow
    case staff
    
    var sectionTitle: String {
        switch self {
        case .fellow:
            return "Fellow"
        case .staff:
            return "Staff"
        }
    }
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
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerFooterSize, elementKind: "header", alignment: .top)
        
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0)
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
        label.numberOfLines = 3
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.text = "Weekly\nFellows:\nStaff:"
        return label
    }()
    
    public lazy var scoreboardMonthlyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBackground
        label.numberOfLines = 3
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.text = "Monthly\nFellows:\nStaff:"
        return label
    }()
    
    public lazy var scoreboardAllTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBackground
        label.numberOfLines = 3
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.text = "All Time\nFellows:\nStaff:"
        return label
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
        scoreboardContainerStackViewSubView1Contrainsts()
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
    
    private func scoreboardContainerStackViewSubView1Contrainsts(){
        for subview in scoreboardContainerStackView.arrangedSubviews{
//            subview.snp.makeConstraints { mkr in
//                mkr.width.equalToSuperview().offset(-8)
//            }
            subview.sizeToFit()
            subview.layoutIfNeeded()
        }
    }
    
    private func setupCollectionViewConstraints() {
        addSubview(cv)
        cv.snp.makeConstraints { (make) in
            make.top.equalTo(scoreboardContainerStackView.snp.bottom).offset(11)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
}
