//
//  CreateProfileViewController.swift
//  CodeWarsTracker
//
//  Created by Bienbenido Angeles on 8/26/21.
//

import UIKit

class CreateProfileViewController: UIViewController {
    
    private let createdProfileView = CreateProfileView()
    private lazy var segControl = createdProfileView.selecUserSegmentedControl
    private lazy var nameTextField = createdProfileView.nameTextField
    private lazy var emailTextField = createdProfileView.emailTextField
    private lazy var codewarsUserNameTextField = createdProfileView.codewarsUserNameTextField
    private lazy var githubUserNameTextField = createdProfileView.githubUserNameTextField
    private lazy var segCon = createdProfileView.selecUserSegmentedControl
    private lazy var loginCreateButton = createdProfileView.loginCreateButton
    private lazy var textFields = createdProfileView.textFields
    
    
    
    private var segControlElementSection:Section = Section.allCases[0]
    
    override func loadView() {
        view = createdProfileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSegControl()
        addButtonTargets()
        textFieldDelegates()
    }
    
    private func textFieldDelegates(){
        for textField in textFields {
            textField.delegate = self
        }
    }
    
    private func addButtonTargets(){
        loginCreateButton.addTarget(self, action: #selector(loginButtonPress), for: .touchUpInside)
    }
    
    @objc private func loginButtonPress(){
        let name = nameTextField.text ?? ""
        let pursuitEmailAddr = emailTextField.text ?? ""
        let githubuserName  = githubUserNameTextField.text ?? ""
        let codewarsUsername = codewarsUserNameTextField.text ?? ""
        let role = segControlElementSection.sectionTitle
        //let userType
        let postUserData:[String:Any] = ["email": pursuitEmailAddr,
                                         "githubUsername": githubuserName,
                                         "name": name,
                                         "role": role.lowercased(),
                                         "username": codewarsUsername]
        let user = User(postUserData)
        postUser(user)
    }
    
    
    private func addSegControl(){
        segControl.addTarget(self, action: #selector(segmentControl(_:)), for: .valueChanged)
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
}

extension CreateProfileViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.highlightBorderSelected(borderWidth: 3, borderColor: UIColor.systemBlue.cgColor)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.highlightBorderSelected(borderWidth: 0, borderColor: UIColor.systemBackground.cgColor)
    }
}
