//
//  HowToPairViewController.swift
//  CodeWarsTracker
//
//  Created by Bienbenido Angeles on 9/11/21.
//

import UIKit
import DropDown

class HowToPairViewController: UIViewController {
    
    let howToPairView = HowToPairView()
    
    var selectedMenu:String
    
    override func loadView() {
        view = howToPairView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addNavBarTitles()
    }
    
    init(dropDown: DropDown) {
        self.selectedMenu = dropDown.selectedItem ?? ""
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addNavBarTitles(){
        navigationItem.title = selectedMenu
    }
}
