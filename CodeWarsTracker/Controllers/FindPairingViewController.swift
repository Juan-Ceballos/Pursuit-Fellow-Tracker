//
//  PairingViewController.swift
//  CodeWarsTracker
//
//  Created by Bienbenido Angeles on 9/9/21.
//

import UIKit

class FindPairingViewController: UIViewController {
    
    private var findPairingView = FindPairingView()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = findPairingView
    }

}
