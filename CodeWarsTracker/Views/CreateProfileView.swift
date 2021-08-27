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
        textfield.textAlignment = .center
        textfield.backgroundColor = .systemBackground
        return textfield
    }()
    
    public lazy var emailTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Pursuit Email Address *"
        textfield.textContentType = .emailAddress
        textfield.textAlignment = .center
        textfield.backgroundColor = .systemBackground
        return textfield
    }()
    
    public lazy var githubUserName: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "GitHub Username *"
        textfield.textContentType = .username
        textfield.textAlignment = .center
        textfield.backgroundColor = .systemBackground
        return textfield
    }()
    
    public lazy var codewarsUserName: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Codewars Username *"
        textfield.textContentType = .username
        textfield.textAlignment = .center
        textfield.backgroundColor = .systemBackground
        return textfield
    }()
    
    public lazy var loginCreateButton: UIButton = {
        let button = UIButton()
        button.setTitle("SIGN UP", for: .normal)
        button.tintColor = .systemBackground
        button.titleLabel?.font = .systemFont(ofSize: 26, weight: .bold)
        button.backgroundColor = .systemBlue
        return button
    }()
    
    public lazy var selecUserPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    public lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.backgroundColor = .systemGroupedBackground
        let subViews = [nameTextField,emailTextField,githubUserName,codewarsUserName, selecUserPickerView, loginCreateButton]
        for view in subViews {
            stackView.addArrangedSubview(view)
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
            //mkr.height.equalTo(containerView)
        }
    }

}
