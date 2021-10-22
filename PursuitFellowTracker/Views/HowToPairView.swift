//
//  HowToPairView.swift
//  CodeWarsTracker
//
//  Created by Bienbenido Angeles on 9/10/21.
//

import UIKit

class HowToPairView: UIView {
    
    private var headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        label.numberOfLines = 0
        return label
    }()
    
    private var subHeadLabel: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.font = UIFont.systemFont(ofSize: 21)
        return textView
    }()
    
    private lazy var views:[UIView] = {
        let views = [headerLabel,subHeadLabel]
        return views
    }()
    
    private var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 13
        sv.distribution = .fill
        sv.alignment = .fill
        sv.isLayoutMarginsRelativeArrangement = true
        return sv
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
        backgroundColor = .systemBackground
        loadTextOnView()
        setupStackViewAndContrainsts()
        setupStackViewSubViewsAndContrainsts()
    }
    
    private func loadTextOnView(){
        let headLabelText = "How to Run a Pair Programming Session while doing Codewars Problems"
        let headLabelDesc = """
        While pairing, one developer will be considered ‘Driver’ and the other ‘Navigator’. When working with a volunteer, it is recommended that the Fellow is the Driver. One’s role is not necessarily indicative of one’s skill but rather the role they play in coding together.
        
        The Driver shares their screen and writes all the code.

        The Driver reads the problem aloud.

        The Driver reiterates the problem in their own words and brings up any clarifying questions.

        The Navigator asks any questions or raises any points they suspect the Driver may be missing.

        Start the problem.

        Delete the pre-written tests.

        What is the simplest case?

        Driver writes a test for that case. The Navigator can jump in at any time, but the Driver should lead at all times. The Navigator’s role is primarily to ask clarifying questions and point out typos or syntactical errors. The Navigator should help in debugging by indicating anywhere they see possible problems.

        Make the test pass.

        Write a test for each case until they are all covered and each is passing.

        Submit the result.

        Resolve any problems, writing additional tests as needed.

        Refactor the code if needed. Delete print or console.log statements and any comments. Submit final result.

        Review the first 2-4 other solutions. Disregard any that are unnecessarily confusing. Look for solutions that are easy to read and concise. Consider doing the problem again with an improved solution or move on to the next problem.
"""
        headerLabel.text = headLabelText
        subHeadLabel.text = headLabelDesc
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
            if index == 0 {
                subview.backgroundColor = .systemGroupedBackground
            }
            subview.layer.cornerRadius = 8
            subview.layoutIfNeeded()
            subview.sizeToFit()
        }
    }
}

