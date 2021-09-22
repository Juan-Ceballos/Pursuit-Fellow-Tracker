//
//  PairingViewController.swift
//  CodeWarsTracker
//
//  Created by Bienbenido Angeles on 9/9/21.
//

import UIKit
import SafariServices
import DropDown

class FindPairingViewController: UIViewController {
    
    private var findPairingView = FindPairingView()
    
    private var dataSource: UITableViewDiffableDataSource<String, Volunteer>!
    
    private static var volunteerCellReuseID = "volunteerCell"
    
    var volunteers: [Volunteer] = [Volunteer]()
    
    var selectedMenu:String
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadVolunteers()
        configureDataSource()
    }
    
    override func viewDidLoad() {
        addNavBarTitles()
        delegatesAndDataSources()
        configureTableView()
    }
    
    override func loadView() {
        view = findPairingView
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
    
    private func delegatesAndDataSources(){
        findPairingView.tableView.delegate = self
        //findPairingView.tableView.dataSource = self
    }
    
    private func configureTableView(){
        findPairingView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: FindPairingViewController.volunteerCellReuseID)
    }
    
    private func loadVolunteers(){
        let volunteer = Volunteer(title: "Aaron Gorenstein", subtitle: "Engineer with Microsoft", imageURLLink: nil, other: "https://calendly.com/aarongorenstein/45-minute-pair-programming-exercise")
        let volunteers = [volunteer]
        self.volunteers = volunteers
    }
    
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<String, Volunteer>(tableView: findPairingView.tableView, cellProvider: { tableView, indexPath, volunteerObj in
            //let cell = tableView.dequeueReusableCell(withIdentifier: FindPairingViewController.volunteerCellReuseID, for: indexPath)
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: FindPairingViewController.volunteerCellReuseID)
            let volunteer = self.volunteers[indexPath.row]
            cell.configureCell(for: volunteer)
            cell.backgroundColor = .systemGroupedBackground
            return cell
        })
        var snapshot = NSDiffableDataSourceSnapshot<String, Volunteer>()
        snapshot.appendSections([""])
        snapshot.appendItems(volunteers)
        dataSource.apply(snapshot, animatingDifferences: false)
        //findPairingView.tableView.updateConstraints()
    }

}

extension FindPairingViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedVolunteerCalendarLink = volunteers[indexPath.row].other, let url = URL(string: selectedVolunteerCalendarLink) else {
            return
        }
        let webVC = SFSafariViewController(url: url)
        //webVC.delegate = self
        present(webVC, animated: true, completion: nil)
    }
}

//extension FindPairingViewController: SFSafariViewControllerDelegate {
//    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
//        dismiss(animated: true, completion: nil)
//    }
//}
