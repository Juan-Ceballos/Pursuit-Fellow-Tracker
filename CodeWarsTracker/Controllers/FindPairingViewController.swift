//
//  PairingViewController.swift
//  CodeWarsTracker
//
//  Created by Bienbenido Angeles on 9/9/21.
//

import UIKit
import SafariServices

class FindPairingViewController: UIViewController {
    
    private var findPairingView = FindPairingView()
    
    private var dataSource: UITableViewDiffableDataSource<String, Volunteer>!
    
    var volunteers: [Volunteer] = [Volunteer]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        delegatesAndDataSources()
        configureTableView()
        configureDataSource()
    }
    
    override func loadView() {
        view = findPairingView
    }
    
    private func delegatesAndDataSources(){
        findPairingView.tableView.delegate = self
        //findPairingView.tableView.dataSource = self
    }
    
    private func configureTableView(){
        findPairingView.tableView.register(VolunteerCell.self, forCellReuseIdentifier: VolunteerCell.reuseIdentifier)
    }
    
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<String, Volunteer>(tableView: findPairingView.tableView, cellProvider: { tableView, indexPath, volunteerObj in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: VolunteerCell.reuseIdentifier, for: indexPath) as? VolunteerCell else {
                fatalError("Unable to deqeue cell with reuse ID: \(VolunteerCell.reuseIdentifier)")
            }
            let volunteer = Volunteer(name: "Aaron Gorenstein", contactLink: "https://calendly.com/aarongorenstein/45-minute-pair-programming-exercise", profileImageURL: "")
            cell.configureCell(for: volunteer)
            return cell
        })
    }

}

extension FindPairingViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedVolunteerCalendarLink = volunteers[indexPath.row].contactLink, let url = URL(string: selectedVolunteerCalendarLink) else {
            return
        }
        let webVC = SFSafariViewController(url: url)
        webVC.delegate = self
        present(webVC, animated: true, completion: nil)
    }
}

extension FindPairingViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true, completion: nil)
    }
}
