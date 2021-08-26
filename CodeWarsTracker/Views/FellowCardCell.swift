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
        label.textColor = .systemBackground
        return label
    }()
    
    public lazy var honorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBackground
        label.font = .systemFont(ofSize: 33)
        return label
    }()
    
    public lazy var clanLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBackground
        return label
    }()
    
    public lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBackground
        label.font = .boldSystemFont(ofSize: 22)
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
        setupNameLabelConstraints()
        setupUsernameLabelConstraints()
        setupClanLabelConstraints()
        setupHonorLabelConstraints()
    }
    
    private func setupNameLabelConstraints() {
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(11)
            make.top.equalToSuperview().offset(11)
        }
    }
    
    private func setupUsernameLabelConstraints() {
        addSubview(usernameLabel)
        usernameLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(11)
            make.top.equalTo(nameLabel.snp.bottom).offset(22)
        }
    }
    
    private func setupClanLabelConstraints() {
        addSubview(clanLabel)
        clanLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(11)
            make.top.equalTo(usernameLabel.snp.bottom).offset(8)
        }
    }
    
    private func setupHonorLabelConstraints() {
        addSubview(honorLabel)
        honorLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(11)
            make.top.equalTo(clanLabel.snp.bottom).offset(8)
        }
    }
    
    
    
}
