//
//  NavBarViewController.swift
//  CodeWarsTracker
//
//  Created by Bienbenido Angeles on 8/25/21.
//

import UIKit
import DropDown

class NavBarViewController: HighlightedViewController {
    
    private let tabBarMenu:DropDown = {
        let menu = DropDown()
        let menuItems = ["Find a Pairing", "How to Pair","How to Use", "Create Account", "Settings"]
        menu.dataSource = menuItems
        return menu
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addDropDownListener()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func applyTheme(_ theme: PursuitTheme) {
        view.backgroundColor = theme.settings.appBgColor
        guard let image = UIImage(systemName: "line.horizontal.3"), let titleImage = theme.settings.pursuitLogo else {
            return
        }
        addNavBarItems(image: image, titleImage: titleImage)
    }
    
    
    private func addNavBarItems(image: UIImage, titleImage: UIImage){
        let logoContainer = UIView(frame: CGRect(x: 0, y: 0, width: 270, height: 50))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 270, height: 50))
        imageView.contentMode = .scaleAspectFit
        imageView.image = titleImage
        logoContainer.addSubview(imageView)
        navigationItem.titleView = logoContainer
        
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
                let findPairingVC = FindPairingViewController(dropDown: self.tabBarMenu)
                self.navigationController?.pushViewController(findPairingVC, animated: true)
            case 1:
                let howToPairVC = HowToPairViewController(dropDown: self.tabBarMenu)
                self.navigationController?.pushViewController(howToPairVC, animated: true)
            case 2:
                let howToUseVC = HowToUseViewController(dropDown: self.tabBarMenu)
                self.navigationController?.pushViewController(howToUseVC, animated: true)
            case 3:
                let createProfileVC = CreateProfileViewController(dropDown: self.tabBarMenu)
                self.navigationController?.pushViewController(createProfileVC, animated: true)
            case 4:
                let settingsVC = SettingsViewController(dropDown: self.tabBarMenu)
                self.navigationController?.pushViewController(settingsVC, animated: true)
            default:
                break
            }
        }
    }
    
    @objc private func showDropDownMenu(){
        tabBarMenu.show()
    }
    
}
