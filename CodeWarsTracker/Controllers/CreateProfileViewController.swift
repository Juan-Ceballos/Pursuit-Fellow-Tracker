//
//  CreateProfileViewController.swift
//  CodeWarsTracker
//
//  Created by Bienbenido Angeles on 8/26/21.
//

import UIKit

class CreateProfileViewController: UIViewController {
    
    private let createdProfileView = CreateProfileView()
    
    private var segControlElementSection:Section = Section.allCases[0]
    
    override func loadView() {
        view = createdProfileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSegControl()
        addButtonTargets()
        textFieldDelegates()
        addDropDownListener()
        addTargetForDropDownToLabel()
    }
    
    private func textFieldDelegates(){
        for textField in createdProfileView.textFields {
            textField.delegate = self
        }
    }
    
    private func addButtonTargets(){
        createdProfileView.loginCreateButton.addTarget(self, action: #selector(loginButtonPress), for: .touchUpInside)
    }
    
    @objc private func loginButtonPress(){
        //error handling
        guard let name = createdProfileView.nameTextField.text,!name.isEmpty,
              let pursuitEmailAddr = createdProfileView.emailTextField.text,!pursuitEmailAddr.isEmpty,
              let githubuserName  = createdProfileView.githubUserNameTextField.text,!githubuserName.isEmpty,
              let codewarsUsername = createdProfileView.codewarsUserNameTextField.text,!codewarsUsername.isEmpty
        else {
            //temporary alert if fields are missing, need to add error labels
            self.createdProfileView.errorLabel.text = "All fields must not be empty"
            self.createdProfileView.errorLabel.textColor = .systemRed
            //self.showAlert(title: "Missing Fields", message: "All fields must not be empty", completion: nil)
            return
        }
        let cohort = createdProfileView.labelForDropDownMenu.text == "Choose your cohort￼" ? nil : createdProfileView.labelForDropDownMenu.text
        let role = segControlElementSection.sectionTitle
        let postUserData:[String:Any] = ["email": pursuitEmailAddr,
                                         "githubUsername": githubuserName,
                                         "name": name,
                                         "role": role.lowercased(),
                                         "username": codewarsUsername,
                                         "cohort": cohort
        ]
        
        createdProfileView.errorLabel.text = "Create an account"
        createdProfileView.errorLabel.textColor = .label
        
        guard let user = User(postUserData) else {
            self.showAlert(title: "Data Error", message: "User not able to be initialized, missing values on dictionary keys", completion: nil)
            return
        }
        print(user)
        //postUser(user)
    }
    
    
    private func addSegControl(){
        createdProfileView.selecUserSegmentedControl.addTarget(self, action: #selector(segmentControl(_:)), for: .valueChanged)
    }
    
    private func addTargetForDropDownToLabel(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showDropDownMenu))
        createdProfileView.labelForDropDownMenu.addGestureRecognizer(tapGesture)
    }
    
    private func postUser(_ user: User){
        CWTAPIClient.postUser(user: user) {[weak self] result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "ERROR", message: error.localizedDescription)
                }
            case .success(_):
                DispatchQueue.main.async {
                    self?.showAlert(message: "User was created") { alert in
                        self?.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    @objc func segmentControl(_ segmentedControl: UISegmentedControl) {
        switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            // First segment tapped
            segControlElementSection = Section.allCases[0]
        case 1:
            // Second segment tapped
            segControlElementSection = Section.allCases[1]
        default:
            break
        }
    }
    
    private func addDropDownListener(){
        createdProfileView.cohortDropdownMenu.selectionAction = { index, title in
            self.addImageWith(string: title, on: self.createdProfileView.labelForDropDownMenu)
        }
    }
    
    @objc private func showDropDownMenu(){
        createdProfileView.cohortDropdownMenu.show()
    }
    
    private func addImageWith(string: String, on label: UILabel) {
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "arrowtriangle.down.fill")
        // Set bound to reposition
        let imageOffsetY: CGFloat = -5.0
        let xCoor = UIScreen.main.bounds.width / 4
        imageAttachment.bounds = CGRect(x: xCoor - (string == "Choose your cohort" ? 21 : -12 ), y: imageOffsetY, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
        // Create string with attachment
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        // Initialize mutable string
        let completeText = NSMutableAttributedString(string: "")
        // Add your text to mutable string
        let textAfterIcon = NSAttributedString(string: string)
        completeText.append(textAfterIcon)
        // Add image to mutable string
        completeText.append(attachmentString)
        label.attributedText = completeText
        
    }
}

extension CreateProfileViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.highlightBorderSelected(borderWidth: 3, borderColor: UIColor.systemBlue.cgColor)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.highlightBorderSelected(borderWidth: 0, borderColor: UIColor.systemBackground.cgColor)
    }
}
