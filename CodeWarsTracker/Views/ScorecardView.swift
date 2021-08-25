//
//  ScorecardView.swift
//  CodeWarsTracker
//
//  Created by Bienbenido Angeles on 8/24/21.
//

import UIKit
import SnapKit

class ScoreCardView: UIView {
    
//    public lazy var scoreboardCardContainerView:UIView = {
//        let view = UIView()
//        view.backgroundColor = .systemBlue
//        return view
//    }()
    
    public lazy var scoreboardContainerStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.spacing = 8
        stackview.backgroundColor = .systemBlue
        stackview.addArrangedSubview(scoreboardLabel)
        stackview.addArrangedSubview(scoreboardDataStackView)
        return stackview
    }()
    
    public lazy var scoreboardDataStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        stackView.backgroundColor = .systemBlue
        stackView.addArrangedSubview(scoreboardWeeklyLabel)
        stackView.addArrangedSubview(scoreboardMonthlyLabel)
        stackView.addArrangedSubview(scoreboardAllTimeLabel)
        return stackView
    }()
    
    public lazy var scoreboardLabel: UILabel = {
        let label = UILabel()
        label.text = "Score Board"
        label.textColor = .systemBackground
        return label
    }()
    
    public lazy var scoreboardWeeklyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBackground
        label.numberOfLines = 3
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    public lazy var scoreboardMonthlyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBackground
        label.numberOfLines = 3
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    public lazy var scoreboardAllTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBackground
        label.numberOfLines = 3
        label.font = UIFont.preferredFont(forTextStyle: .body)
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
    }
    
    private func scoreboardContainerStackViewContrainsts(){
        addSubview(scoreboardContainerStackView)
        scoreboardContainerStackView.snp.makeConstraints { mkr in
            mkr.centerX.equalToSuperview()
            mkr.edges.equalTo(self).offset(8)
            mkr.size.height.lessThanOrEqualTo(self).multipliedBy(0.2)
        }
    }
}
