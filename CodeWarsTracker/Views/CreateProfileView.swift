//
//  CreateProfileView.swift
//  CodeWarsTracker
//
//  Created by Bienbenido Angeles on 8/26/21.
//

import UIKit
import SnapKit
import DropDown

class CreateProfileView: KeyboardHandlerView {

    public lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Create an account"
        label.numberOfLines = 3
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .body)
        //label.isHidden = true
        return label
    }()
    
    public lazy var textFields: [UITextField] = {
        let arr = [nameTextField,emailTextField, codewarsUserNameTextField, githubUserNameTextField]
        return arr
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
    
    public lazy var cohortDropdownMenu: DropDown = {
        let menu = DropDown()
        let menuItems = ["Choose your cohort","Pursuit-8.1", "Pursuit-8.2","Pursuit-7.1", "Pursuit-7.2"]
        menu.dataSource = menuItems
        menu.anchorView = labelForDropDownMenu
        menu.frame = formContainerStackView.frame
        return menu
    }()
    
    
    public lazy var labelForDropDownMenu: UILabel = {
        let label = UILabel()
        // Create Attachment
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "arrowtriangle.down.fill")
        // Set bound to reposition
        let imageOffsetY: CGFloat = -5.0
        let xCoor = UIScreen.main.bounds.width / 4
        imageAttachment.bounds = CGRect(x: xCoor - 21, y: imageOffsetY, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
        // Create string with attachment
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        // Initialize mutable string
        let completeText = NSMutableAttributedString(string: "")
        // Add your text to mutable string
        let textAfterIcon = NSAttributedString(string: "Choose your cohort")
        completeText.append(textAfterIcon)
        // Add image to mutable string
        completeText.append(attachmentString)
        label.textAlignment = .center
        label.attributedText = completeText
        label.backgroundColor = .systemBackground
        label.isUserInteractionEnabled = true
        return label
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
    
    override init(alignment: FormAlignment = .top) {
        super.init(alignment: alignment)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        containerViewStackViewSubViewContrainsts(formContainerStackView)
    }
    
    public func containerViewStackViewSubViewContrainsts (_ stackView: UIStackView) {
        stackView.snp.makeConstraints { mkr in
            //mkr.height.equalToSuperview().multipliedBy(0.768)
        }
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 21
        stackView.axis = .vertical
        stackView.backgroundColor = .systemGroupedBackground
        //stackView.layoutMargins = UIEdgeInsets(top: 21, left: 21, bottom: 21, right: 21)
        stackView.isLayoutMarginsRelativeArrangement = true
        let subViews = [errorLabel,
                        nameTextField,
                        emailTextField,
                        githubUserNameTextField,
                        codewarsUserNameTextField,
                        labelForDropDownMenu,
                        selecUserSegmentedControl,
                        loginCreateButton]
        for view in subViews {
            stackView.addArrangedSubview(view)
            //view.frame.size.height = 500
            //view.sizeToFit()
            //view.layoutIfNeeded()
        }
        
        for (index, subview) in stackView.arrangedSubviews.enumerated(){
            subview.snp.makeConstraints { mkr in
                mkr.width.equalTo(stackView).offset(-21)
                if index == 0 || (5...7).contains(index){
                    mkr.height.equalTo(self).multipliedBy(0.05)
                }else if(1...4).contains(index){
                    mkr.height.equalTo(self).multipliedBy(0.1)
                }
            }
            
            subview.layer.cornerRadius = 8
            subview.layoutIfNeeded()
            subview.sizeToFit()
        }
        
        let textFields = [nameTextField, emailTextField, githubUserNameTextField, codewarsUserNameTextField]
        //let otherUIs = [labelForDropDownMenu,selecUserSegmentedControl,loginCreateButton]
        
        for tf in textFields {
            tf.setHorizontalPaddingPoints(13)
        }
        
//        for ui in otherUIs {
//            ui.snp.makeConstraints { mkr in
//                //mkr.height.equalTo(100).offset(0)
//            }
//        }
    }
    

}

