//
//  SettingsViewController.swift
//  CodeWarsTracker
//
//  Created by Bienbenido Angeles on 9/25/21.
//

import UIKit
import DropDown

class SettingsViewController: UIViewController {
    
    private let settingsView = SettingsView()
    private var selectedMenu: String
    private static var settingsViewControllerResuseID = "settingsCell"
    private let sections = Settings.sections
    
    init(dropDown: DropDown) {
        self.selectedMenu = dropDown.selectedItem ?? ""
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegatesAndDataSources()
        setupNavBar()
    }
    
    override func loadView() {
        view = settingsView
    }
    
    private func delegatesAndDataSources(){
        settingsView.tableView.delegate = self
        settingsView.tableView.dataSource = self
    }
    
    private func setupNavBar(){
        navigationItem.title = selectedMenu
        navigationController?.navigationBar.prefersLargeTitles = true
    }

}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let themePreviewsVC = ThemePreviewsViewController()
        sections[indexPath.section].items[indexPath.row].completionHandler(self,themePreviewsVC)
    }
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: SettingsViewController.settingsViewControllerResuseID)
        let item = sections[indexPath.section].items[indexPath.row]
        cell.configureCell(for: item)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = sections[section].groupTitle
        return section
    }
}
