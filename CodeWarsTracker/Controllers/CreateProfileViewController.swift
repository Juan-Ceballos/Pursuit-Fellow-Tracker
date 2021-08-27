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
    
    private let pickerViewElements = Section.allCases
    
    override func loadView() {
        view = createdProfileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func addSegControl(){
        segControl.addTarget(self, action: #selector(segmentControl(_:)), for: .valueChanged)
    }
    
    @objc func segmentControl(_ segmentedControl: UISegmentedControl) {
       switch (segmentedControl.selectedSegmentIndex) {
          case 0:
             // First segment tapped
          break
          case 1:
             // Second segment tapped
          break
          default:
          break
       }
    }
}
