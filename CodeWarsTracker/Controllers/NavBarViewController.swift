//
//  NavBarViewController.swift
//  CodeWarsTracker
//
//  Created by Bienbenido Angeles on 8/25/21.
//

import UIKit
import DropDown

class NavBarViewController: UIViewController {
    
    private let tabBarMenu:DropDown = {
        let menu = DropDown()
        let menuItems = ["Find a Pairing", "How to Pair"," How to Use", "Create Account"]
        menu.dataSource = menuItems
        return menu
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let image = UIImage(systemName: "line.horizontal.3") else {
            return
        }
        addNavBarItems(image: image)
        addDropDownListener()
    }
    

    private func addNavBarItems(image: UIImage){
        
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(showDropDownMenu), for: .touchUpInside)
        
        let barButtonItem = UIBarButtonItem(customView: button)
        tabBarMenu.frame = navigationController?.navigationBar.frame ?? .zero
        tabBarMenu.anchorView = barButtonItem
        
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    private func addDropDownListener(){
        tabBarMenu.selectionAction = { index, title in
            switch index {
            case 0:
                break
            case 1:
                break
            case 2:
                break
            case 3:
                break
            default:
                break
            }
        }
    }
    
    @objc private func showDropDownMenu(){
        tabBarMenu.show()
    }

}
