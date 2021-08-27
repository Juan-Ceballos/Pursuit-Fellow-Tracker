//
//  CreateProfileViewController.swift
//  CodeWarsTracker
//
//  Created by Bienbenido Angeles on 8/26/21.
//

import UIKit

class CreateProfileViewController: UIViewController {
    
    private let createdProfileView = CreateProfileView()
    
    private let pickerViewElements = Section.allCases
    
    override func loadView() {
        view = createdProfileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
