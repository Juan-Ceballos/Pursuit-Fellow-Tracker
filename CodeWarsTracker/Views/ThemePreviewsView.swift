//
//  ThemePreviewsVIew.swift
//  CodeWarsTracker
//
//  Created by Bienbenido Angeles on 9/25/21.
//

import UIKit

class ThemePreviewsView: UIView {
    
    private var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 13
        sv.distribution = .fillProportionally
        sv.alignment = .fill
        sv.isLayoutMarginsRelativeArrangement = true
        return sv
    }()
    
    private var textLabel: UnhighlightedLabel = {
        let label = UnhighlightedLabel()
        label.text = "It's a simple example of a theme!"
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 34)
        label.textAlignment = .center
        return label
    }()
    
    private var button: HighlightedButton = {
        let button = HighlightedButton()
        button.setTitle("Theme text", for: .normal)
        return button
    }()
    
    public var pickerView: HighlightedPickerView = {
        let pickerView = HighlightedPickerView()
        return pickerView
    }()
    
    private lazy var views:[UIView] = {
        let views = [textLabel, button, pickerView]
        return views
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        setupStackViewAndContrainsts()
        setupStackViewSubViewsAndContrainsts()
    }
    
    private func setupStackViewAndContrainsts(){
        addSubview(stackView)
        stackView.snp.makeConstraints { mkr in
            mkr.top.equalToSuperview().offset(13)
            mkr.left.equalToSuperview().offset(13)
            mkr.right.equalToSuperview().offset(-13)
            mkr.bottom.equalToSuperview().offset(-13)
        }
        
        let subViews:[UIView] = views
        for view in subViews {
            stackView.addArrangedSubview(view)
        }
    }
    
    private func setupStackViewSubViewsAndContrainsts(){
        
        for (index, subview) in stackView.arrangedSubviews.enumerated(){
            subview.snp.makeConstraints { mkr in
                if index == 0 {
                    //mkr.height.greaterThanOrEqualToSuperview().multipliedBy(0.382)
                } else if index == 1 {
                    //mkr.height.equalTo(89)
                } else {
                    //mkr.height.lessThanOrEqualToSuperview().multipliedBy(0.618)
                    //mkr.width.equalTo(stackView)
                }
                //mkr.width.equalTo(stackView)
                
            }
            subview.layer.cornerRadius = 8
            subview.layoutIfNeeded()
            subview.sizeToFit()
        }
    }

}
