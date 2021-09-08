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
        guard let name = createdProfileView.nameTextField.text,
              let pursuitEmailAddr = createdProfileView.emailTextField.text,
              let githubuserName  = createdProfileView.githubUserNameTextField.text,
              let codewarsUsername = createdProfileView.codewarsUserNameTextField.text
              else {
            //temporary alert if fields are missing, need to add error labels
            self.showAlert(title: "Missing Fields", message: "All fields must not be empty", completion: nil)
            return
        }
        let role = segControlElementSection.sectionTitle
        let postUserData:[String:Any] = ["email": pursuitEmailAddr,
                                         "githubUsername": githubuserName,
                                         "name": name,
                                         "role": role.lowercased(),
                                         "username": codewarsUsername]
        
        guard let user = User(postUserData) else {
            self.showAlert(title: "Data Error", message: "User not able to be initialized, missing values on dictionary keys", completion: nil)
            return
        }
        postUser(user)
    }
    
    
    private func addSegControl(){
        createdProfileView.selecUserSegmentedControl.addTarget(self, action: #selector(segmentControl(_:)), for: .valueChanged)
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
