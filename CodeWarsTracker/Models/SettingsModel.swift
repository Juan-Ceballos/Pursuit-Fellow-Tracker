//
//  SettingsModel.swift
//  CodeWarsTracker
//
//  Created by Bienbenido Angeles on 9/25/21.
//

import UIKit

struct Settings {
    
    public static let sections = [
        Setting(
            groupTitle: "Appearance",
            items: [
                Item(title: "Change Themes", subtitle: nil, imageURLLink: nil, bgColor: nil, completionHandler: {parentVC,pushedVC   in
                    guard let validPVC = pushedVC else {
                        return
                    }
                    parentVC.navigationController?.pushViewController(validPVC, animated: true)
                })
            ]
        )
    ]
}

struct Setting {
    let groupTitle:String
    let items: [Item]
}

struct Item:TableViewCellConformance {
    let title: String
    let subtitle: String?
    let imageURLLink: String?
    let bgColor: UIColor?
    let completionHandler: ((_ parentVC: UIViewController, _ pushedVC: UIViewController?)->())
}
