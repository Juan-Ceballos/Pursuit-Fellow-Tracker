//
//  fellowCardCell.swift
//  CodeWarsTracker
//
//  Created by Juan Ceballos on 8/26/21.
//

import UIKit
import SnapKit

class UserCardCell: UICollectionViewCell {
    
    override func layoutSubviews() {
        self.layer.cornerRadius = 8
    }
    
    static let reuseIdentifier = "userCardCell"
    
    public lazy var bannerView: UIView = {
        let bView = UIView()
        bView.backgroundColor = .systemYellow
        bView.addSubview(staffTextLabel)
        staffTextLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        return bView
    }()
    
    public lazy var staffTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Staff"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    public lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBackground
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    public lazy var honorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBackground
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    public lazy var clanLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBackground
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    public lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBackground
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    public lazy var pointsThisWeekLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBackground
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    public lazy var pointsThisMonthLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBackground
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.lineBreakMode = .byCharWrapping
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
        setupBannerViewConstraints()
        setupNameLabelConstraints()
        setupUsernameLabelConstraints()
        setupClanLabelConstraints()
        setupPointsThisWeekLabel()
        setupPointsThisMonthLabel()
        setupHonorLabelConstraints()
    }
    
    private func setupBannerViewConstraints() {
        addSubview(bannerView)
        bannerView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(11)
            make.width.equalTo(self.snp.width).multipliedBy(0.15)
            make.height.equalTo(self.snp.height).multipliedBy(0.2)
        }
    }
    
    private func setupNameLabelConstraints() {
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(bannerView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(11)
        }
    }
    
    private func setupUsernameLabelConstraints() {
        addSubview(usernameLabel)
        usernameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(11)
            make.width.equalToSuperview().multipliedBy(0.7)
        }
    }
    
    private func setupClanLabelConstraints() {
        addSubview(clanLabel)
        clanLabel.snp.makeConstraints { (make) in
            make.top.equalTo(usernameLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(11)
        }
    }
    
    private func setupPointsThisWeekLabel() {
        addSubview(pointsThisWeekLabel)
        pointsThisWeekLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(usernameLabel.snp.centerY)
            make.trailing.equalToSuperview().offset(-11)
        }
    }
    
    private func setupPointsThisMonthLabel() {
        addSubview(pointsThisMonthLabel)
        pointsThisMonthLabel.snp.makeConstraints { (make) in
            make.top.equalTo(pointsThisWeekLabel.snp.bottom).offset(8)
            make.trailing.equalTo(pointsThisWeekLabel.snp.trailing)
            make.leading.equalTo(pointsThisWeekLabel.snp.leading)
        }
    }
    
    private func setupHonorLabelConstraints() {
        addSubview(honorLabel)
        honorLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-11)
        }
    }
    
}
