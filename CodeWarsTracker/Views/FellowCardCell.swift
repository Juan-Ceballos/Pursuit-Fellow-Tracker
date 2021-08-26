//
//  fellowCardCell.swift
//  CodeWarsTracker
//
//  Created by Juan Ceballos on 8/26/21.
//

import UIKit
import SnapKit

class FellowCardCell: UICollectionViewCell {
    
    static let reuseIdentifier = "fellowCardCell"
    
    public lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Default"
        label.textColor = .black
        label.backgroundColor = .systemGreen
        return label
    }()
    
    public lazy var honorLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    public lazy var clanLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    public lazy var nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    public lazy var pointsThisWeekLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    public lazy var pointsThisMonthLabel: UILabel = {
        let label = UILabel()
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
    
    private func commonInit()   {
        setupUsernameLabelConstraints()
        setupHonorLabelConstraints()
        setupClanLabelConstraints()
        setupNameLabelConstraints()
        setupPointsThisWeekLabelConstraints()
        setupPointsThisMonthLabelConstraints()
    }
    
    private func setupUsernameLabelConstraints() {
        addSubview(usernameLabel)
        usernameLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(8)
        }
    }
    
    private func setupHonorLabelConstraints() {
        addSubview(honorLabel)
        honorLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(usernameLabel.snp.bottom).offset(8)
        }
    }
    
    private func setupClanLabelConstraints() {
        addSubview(clanLabel)
        clanLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(honorLabel.snp.bottom).offset(8)
        }
    }
    
    private func setupNameLabelConstraints() {
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(clanLabel.snp.bottom).offset(8)
        }
    }
    
    private func setupPointsThisWeekLabelConstraints() {
        addSubview(pointsThisWeekLabel)
        pointsThisWeekLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
        }
    }
    
    private func setupPointsThisMonthLabelConstraints() {
        addSubview(pointsThisMonthLabel)
        pointsThisMonthLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(pointsThisWeekLabel.snp.bottom).offset(8)
        }
    }
    
}
