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
        let label = UnhighlightedLabel()
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .headline)
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
        setupTextLabelConstraints()
    }
    
    private func setupTextLabelConstraints() {
        addSubview(textLabel)
        textLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
        }
    }
    
}
