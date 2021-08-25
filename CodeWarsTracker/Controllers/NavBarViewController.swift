//
//  NavBarViewController.swift
//  CodeWarsTracker
//
//  Created by Bienbenido Angeles on 8/25/21.
//

import UIKit

class NavBarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let image = UIImage(systemName: "line.horizontal.3") else {
            return
        }
        addNavBarItems(image: image)
    }
    

    private func addNavBarItems(image: UIImage){
        
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(popOverViewController), for: .touchUpInside)
        
        let barButtonItem = UIBarButtonItem(customView: button)
        
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc private func popOverViewController(){
        
        //navigationController?.pushViewController(firstProfilelVC, animated: true)
    }

}
