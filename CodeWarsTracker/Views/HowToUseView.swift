//
//  HowToUseView.swift
//  CodeWarsTracker
//
//  Created by Bienbenido Angeles on 9/21/21.
//

import UIKit

class HowToUseView: UIView {
    
    private var headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: label.font.pointSize)
        label.numberOfLines = 0
        return label
    }()
    
    public var subHeadLabel: UITextView = {
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
        setupStackViewAndContrainsts()
        setupStackViewSubViewsAndContrainsts()
        loadTextOnView()
    }
    
    private func loadTextOnView(){
        let headLabelText = "What is the Codewars Tracker and How Does It Work?"
        var linkText1:NSMutableAttributedString = NSMutableAttributedString(string: """
\n\nFirst, you should create an account with Codewars. It is free and very quick.
""")
        linkText1 = linkText1.setAsLink(textToFind: "Codewars", linkURL: "https://codewars.com/") ?? NSMutableAttributedString()
        
        //list
        var bullet = 0
        var listStrings = [
            "Log into your Codewars account and navigate to My Account",
            "Scroll down to the section that is titled: Webhooks.",
            "Copy and paste this following URL into the 'Payload url' box: https://codewars-tracker-be.herokuapp.com/codewars",
            "Click on the 'Update' button at the bottom of the page."
        ].map { str -> NSMutableAttributedString in
            bullet += 1
            return NSMutableAttributedString(string: String(bullet) + ". " + str)
        }
        listStrings[0] = listStrings[0].setAsLink(textToFind: "My Account", linkURL: "https://www.codewars.com/users/edit") ?? NSMutableAttributedString()
        
        //create image attachment for 2nd element
        let imageAttachment = NSTextAttachment()
        let image = UIImage(named: "codewars_webhook_screenshot")
        imageAttachment.setUUID("codewars_webhook_screenshot")
        imageAttachment.image = image
        var imageStr = NSAttributedString(attachment: imageAttachment)
        imageStr = imageStr.attributedStringWithResizedImages(with: UIScreen.main.bounds.width)
        listStrings[1].append(imageStr)        
        var linkText2:NSMutableAttributedString = NSMutableAttributedString(string: "\n\nCreate an account on this platform")
        linkText2 = linkText2.setAsLink(textToFind: "Create an account on this platform", linkURL: "https://codewars-tracker-fe.herokuapp.com/createAccount") ?? NSMutableAttributedString()
        //start
        headerLabel.text = headLabelText
        do {
            
            subHeadLabel.attributedText = try NSMutableAttributedString()
                .normal("""
            Codewars is a platform for practicing algorithmic problems in several different languages. It offers a great way to practice both the fundamentals and advanced aspects of any common language.

            This application is set up to help you track your progress and consistency in working with Codewars. Every time you complete a problem, an event will be emitted that updates your total poins, your weekly points and your monthly points.
""")
                .bold(linkText1)
                .bold("""
\n\nAfter you create your account, add the webhook by following these steps:\n\n
""")
                .list(listNSStrings: listStrings)
                .bold(linkText2)
                .bold("\n\nYou're Good to Go!")
                .normal("\n\nGo ahead and start solving problems. You can practice alone or pair with others - hopefully both!")
        } catch {
            subHeadLabel.text = error.localizedDescription
        }
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
