//
//  HeaderView.swift
//  CodeWarsTracker
//
//  Created by Juan Ceballos on 8/26/21.
//

import UIKit

class HeaderView: UICollectionReusableView {
    static let reuseIdentifier = "headerView"
    
    public lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    public lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.searchBarStyle = .minimal
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
    
    private func commonInit()   {
        setupTextLabelConstraints()
        setupSearchBarConstraints()
    }
    
    private func setupTextLabelConstraints() {
        addSubview(textLabel)
        textLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(17)
            make.centerY.equalToSuperview()
        }
    }
    
    private func setupSearchBarConstraints() {
        addSubview(searchBar)
        searchBar.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-8)
            make.width.equalToSuperview().multipliedBy(0.4)
            make.height.equalToSuperview().multipliedBy(0.7)
            make.centerY.equalToSuperview()
        }
    }
    
}
