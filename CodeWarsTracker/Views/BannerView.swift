//
//  BannerView.swift
//  CodeWarsTracker
//
//  Created by Juan Ceballos on 8/27/21.
//

import UIKit

class BannerView: UICollectionReusableView {
    static let reuseIdentifier = "bannerView"
    
    public lazy var staffLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.text = "Staff"
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
        addSubview(staffLabel)
        staffLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            staffLabel.bottomAnchor.constraint(equalTo: self.centerYAnchor),
            staffLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            staffLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            staffLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        
        ])
    }
    
}
