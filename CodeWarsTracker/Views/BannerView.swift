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
            staffLabel.topAnchor.constraint(equalTo: topAnchor),
            staffLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            staffLabel.heightAnchor.constraint(equalTo: heightAnchor),
            staffLabel.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
    
}
