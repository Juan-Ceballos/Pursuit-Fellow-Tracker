//
//  CreateProfileView.swift
//  CodeWarsTracker
//
//  Created by Bienbenido Angeles on 8/26/21.
//

import UIKit
import SnapKit

class CreateProfileView: UIView {

    public lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.text = "ERROR"
        label.numberOfLines = 3
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.isHidden = true
        return label
    }()
    
    public lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemRed
        return view
    }()
    
    public lazy var nameTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Name *"
        textfield.textContentType = .name
        //textfield.textAlignment = .center
        textfield.backgroundColor = .systemBackground
        textfield.adjustsFontSizeToFitWidth = true
        textfield.minimumFontSize = 12
        textfield.font = UIFont.systemFont(ofSize: 34)
        return textfield
    }()
    
    public lazy var emailTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Pursuit Email Address *"
        textfield.textContentType = .emailAddress
        //textfield.textAlignment = .center
        textfield.backgroundColor = .systemBackground
        textfield.adjustsFontSizeToFitWidth = true
        textfield.minimumFontSize = 12
        textfield.font = UIFont.systemFont(ofSize: 34)
        return textfield
    }()
    
    public lazy var githubUserNameTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "GitHub Username *"
        textfield.textContentType = .username
        //textfield.textAlignment = .center
        textfield.backgroundColor = .systemBackground
        textfield.adjustsFontSizeToFitWidth = true
        textfield.minimumFontSize = 12
        textfield.font = UIFont.systemFont(ofSize: 34)

        return textfield
    }()
    
    public lazy var codewarsUserNameTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Codewars Username *"
        textfield.textContentType = .username
        //textfield.textAlignment = .center
        textfield.backgroundColor = .systemBackground
        textfield.adjustsFontSizeToFitWidth = true
        textfield.minimumFontSize = 13
        textfield.font = UIFont.systemFont(ofSize: 34)
        return textfield
    }()
    
    public lazy var loginCreateButton: UIButton = {
        let button = UIButton()
        button.setTitle("SIGN UP", for: .normal)
        button.tintColor = .systemBackground
        button.titleLabel?.font = .systemFont(ofSize: 21, weight: .bold)
        button.backgroundColor = .systemBlue
        return button
    }()
    
    public lazy var selecUserSegmentedControl: UISegmentedControl = {
        let segConItems:[String] = Section.allCases.map{$0.sectionTitle}
        let segCon = UISegmentedControl(items: segConItems)
        segCon.selectedSegmentIndex = 0
        return segCon
    }()
    
    public lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 20
        stackView.axis = .vertical
        stackView.backgroundColor = .systemGroupedBackground
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
        let subViews = [nameTextField,emailTextField,githubUserNameTextField,codewarsUserNameTextField, selecUserSegmentedControl, loginCreateButton]
        for view in subViews {
            stackView.addArrangedSubview(view)
            //view.frame.size.height = 500
            //view.sizeToFit()
            //view.layoutIfNeeded()
        }

        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        self.backgroundColor = .systemBackground
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        //errorLabelConstrainsts()
        containerViewContrainsts()
        containerViewStackViewContrainsts()
        containerViewStackViewSubViewContrainsts()
    }
    
//    private func errorLabelConstrainsts(){
//        addSubview(errorLabel)
//        errorLabel.snp.makeConstraints { mkr in
//            mkr.leading.equalTo(safeAreaLayoutGuide).offset(20)
//            mkr.top.equalTo(safeAreaLayoutGuide).offset(20)
//            mkr.trailing.equalTo(safeAreaLayoutGuide).offset(-20)
//        }
//    }
    
    private func containerViewContrainsts(){
        addSubview(containerView)
        containerView.snp.makeConstraints { mkr in
            mkr.leading.equalTo(self).offset(20)
            mkr.trailing.equalTo(self).offset(-20)
            mkr.centerX.equalTo(self)
            mkr.centerY.equalTo(self)
            mkr.height.equalTo(self).multipliedBy(0.8)
        }
    }
    
    private func containerViewStackViewContrainsts(){
        containerView.addSubview(containerStackView)
        containerStackView.snp.makeConstraints { mkr in
            mkr.center.equalTo(containerView)
            mkr.edges.lessThanOrEqualTo(containerView)
        }
    }
    
    private func containerViewStackViewSubViewContrainsts () {
        for (index, subview) in containerStackView.arrangedSubviews.enumerated(){
            subview.snp.makeConstraints { mkr in
                mkr.width.equalTo(containerStackView).offset(-21)
            }
            
            subview.layer.cornerRadius = 8
            subview.layoutIfNeeded()
            subview.sizeToFit()
        }
        
        let textFields = [nameTextField, emailTextField, githubUserNameTextField, codewarsUserNameTextField]
        let otherUIs = [selecUserSegmentedControl,loginCreateButton]
        
        for tf in textFields {
            tf.snp.makeConstraints { mkr in
                mkr.height.equalTo(containerStackView).multipliedBy(0.2).offset(-21)
            }
            tf.setHorizontalPaddingPoints(13)
            tf.delegate = self
        }
        
//        for ui in otherUIs {
//            ui.snp.makeConstraints { mkr in
//                mkr.height.equalTo(containerStackView).multipliedBy(0.1).offset(-21)
//            }
//        }
    }
    

}

extension CreateProfileView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.highlightBorderSelected(borderWidth: 3, borderColor: UIColor.systemBlue.cgColor)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.highlightBorderSelected(borderWidth: 0, borderColor: UIColor.systemBackground.cgColor)
    }
}
