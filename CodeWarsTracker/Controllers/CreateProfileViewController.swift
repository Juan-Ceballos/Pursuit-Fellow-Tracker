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
        createdProfileView.selecUserPickerView.dataSource = self
        createdProfileView.selecUserPickerView.delegate = self
    }

}

extension CreateProfileViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewElements.count
    }
}

extension CreateProfileViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerViewElements[row].sectionTitle
    }
}
