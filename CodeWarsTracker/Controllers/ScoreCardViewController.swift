//
//  ViewController.swift
//  CodeWarsTracker
//
//  Created by Juan Ceballos on 8/17/21.
//

import UIKit
import SafariServices

class ScoreCardViewController: NavBarViewController {
    private let scoreCardView = ScoreCardView()
    
    override func loadView() {
        view = scoreCardView
    }
    
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, User>
    private var dataSource: DataSource!
    private var allUsers = [[User]]()
    private var allCurrentUsers = [User]()
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .systemBackground
        loadAllUsers()
        configureCollectionView()
        loadScoreCardData()
        scoreCardView.searchBar.delegate = self
        scoreCardView.cv.delegate = self
        refreshControl.addTarget(self, action: #selector(refreshUserData), for: .valueChanged)
        scoreCardView.segmentedControl.addTarget(self, action: #selector(segmentValueChanged), for: .valueChanged)
    }
    
    @objc func segmentValueChanged(_ sender: UISegmentedControl!) {
        configureDataSource()
    }
    
    @objc private func refreshUserData() {
        loadAllUsers()
        loadScoreCardData()
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
        }
    }
    
    private func loadAllUsers() {
        CWTAPIClient.fetchAllUsers { [weak self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error)
                }
            case .success(let users):
                DispatchQueue.main.async {
                    self?.allUsers = users
                    self?.configureDataSource()
                }
            }
        }
    }
    
    private func performSearch(searchQuery: String?) {
        var filteredFellows = [User]()
        var filteredStaff = [User]()
        var selectedUsers = [User]()
        
        switch self.scoreCardView.segmentedControl.selectedSegmentIndex {
        case 0:
            selectedUsers = self.allUsers[0].sorted {$0.honor ?? 0 > $1.honor ?? 0}
        case 1:
            selectedUsers = self.allUsers[1].sorted {$0.honor ?? 0 > $1.honor ?? 0}
        case 2:
            selectedUsers = self.allUsers[2].sorted {$0.honor ?? 0 > $1.honor ?? 0}
        case 3:
            selectedUsers = self.allUsers[3].sorted {$0.honor ?? 0 > $1.honor ?? 0}
        case 4:
            selectedUsers = self.allUsers[4].sorted {$0.honor ?? 0 > $1.honor ?? 0}
        default:
            selectedUsers = self.allUsers[0].sorted {$0.honor ?? 0 > $1.honor ?? 0}
        }
        
        for user in selectedUsers {
            if user.role == "staff" {
                filteredStaff.append(user)
            } else if user.role == "fellow" {
                filteredFellows.append(user)
            }
        }
        
        if let searchQuery = searchQuery, !searchQuery.isEmpty {
            filteredFellows = filteredFellows.filter { $0.name.contains(searchQuery) }
            filteredStaff = filteredStaff.filter { $0.name.contains(searchQuery) }
        } else {
            configureDataSource()
        }
        
        let fellowsByWeekPoints = selectedUsers.sorted {$0.pointThisWeek ?? 0 > $1.pointThisWeek ?? 0}
        let fellowsRemoveZeros = fellowsByWeekPoints.filter {$0.pointThisWeek != 0}
        var lead = [User]()
        var count = 0
        while count < fellowsRemoveZeros.count && count < 3 {
            var tempFellow = fellowsRemoveZeros[count]
            tempFellow.isTopFellow = true
            lead.append(tempFellow)
            count += 1
        }
        var snapshot = NSDiffableDataSourceSnapshot<Section, User>()
        snapshot.appendSections([.leaderBoard, .fellow, .staff])
        snapshot.appendItems(lead, toSection: .leaderBoard)
        snapshot.appendItems(filteredFellows, toSection: .fellow)
        snapshot.appendItems(filteredStaff, toSection: .staff)
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func configureCollectionView() {
        scoreCardView.cv.register(FellowCardCell.self, forCellWithReuseIdentifier: FellowCardCell.reuseIdentifier)
        scoreCardView.cv.register(HeaderView.self, forSupplementaryViewOfKind: Constants.headerElementKind, withReuseIdentifier: HeaderView.reuseIdentifier)
        scoreCardView.cv.refreshControl = refreshControl
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, User>(collectionView: scoreCardView.cv, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FellowCardCell.reuseIdentifier, for: indexPath) as? FellowCardCell else {
                fatalError()
            }
            DispatchQueue.main.async {
                //cell.backgroundColor = .systemBlue
                cell.nameLabel.text = item.name
                cell.usernameLabel.text = "Codewars: \(item.username)"
                cell.clanLabel.text = "Class: \(item.cohort ?? "No Clan")"
                cell.honorLabel.text = String(item.honor ?? 0)
                cell.pointsThisWeekLabel.text = "This Week: \(String(item.pointThisWeek ?? 0))"
                cell.pointsThisMonthLabel.text = "This Month: \(String(item.pointThisMonth ?? 0))"
                switch indexPath.section {
                case 0:
                    cell.bannerView.isHidden = true
                    cell.leaderBoardBadgeLabel.isHidden = false
                    cell.leaderBoardBadgeLabel.text = "\(indexPath.row + 1)"
                    cell.leaderBoardBadgeLabel.backgroundColor = .systemOrange
                case 1:
                    cell.bannerView.isHidden = true
                    cell.leaderBoardBadgeLabel.isHidden = true
                case 2:
                    cell.bannerView.isHidden = false
                default:
                    print()
                }
            }
            return cell
        })
        
        dataSource.supplementaryViewProvider = {
            (collectionView, kind, indexPath) in
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.reuseIdentifier, for: indexPath) as? HeaderView else {
                fatalError()
            }
            
            DispatchQueue.main.async {
                switch indexPath.section {
                case 0:
                    headerView.textLabel.text = "This Week's Top Scores"
                case 1:
                    headerView.textLabel.text = "Fellows"

                case 2:
                    headerView.textLabel.text = "Staff"
                default:
                    fatalError("Invalid Section, for headerview supplementary view provider")
                }
            }
            return headerView
        }
        
        DispatchQueue.main.async {
            var snapshot = NSDiffableDataSourceSnapshot<Section, User>()
            var fellows = [User]()
            var staff = [User]()
            var usersSorted = [User]()
            
            switch self.scoreCardView.segmentedControl.selectedSegmentIndex {
            case 0:
                usersSorted = self.allUsers[0].sorted {$0.honor ?? 0 > $1.honor ?? 0}
            case 1:
                usersSorted = self.allUsers[1].sorted {$0.honor ?? 0 > $1.honor ?? 0}
            case 2:
                usersSorted = self.allUsers[2].sorted {$0.honor ?? 0 > $1.honor ?? 0}
            case 3:
                usersSorted = self.allUsers[3].sorted {$0.honor ?? 0 > $1.honor ?? 0}
            case 4:
                usersSorted = self.allUsers[4].sorted {$0.honor ?? 0 > $1.honor ?? 0}
            default:
                usersSorted = self.allUsers[0].sorted {$0.honor ?? 0 > $1.honor ?? 0}
            }
            
            for user in usersSorted {
                if user.role == "staff" {
                    staff.append(user)
                } else if user.role == "fellow" {
                    fellows.append(user)
                }
            }
            
            let fellowsByWeekPoints = fellows.sorted {$0.pointThisWeek ?? 0 > $1.pointThisWeek ?? 0}
            let fellowsRemoveZeros = fellowsByWeekPoints.filter {$0.pointThisWeek != 0}
            print(fellowsRemoveZeros.count)
            var lead = [User]()
            var count = 0
            while count < fellowsRemoveZeros.count && count < 3 {
                var tempFellow = fellowsRemoveZeros[count]
                tempFellow.isTopFellow = true
                lead.append(tempFellow)
                count += 1
            }
            
            snapshot.appendSections([.leaderBoard, .fellow, .staff])
            snapshot.appendItems(lead, toSection: .leaderBoard)
            snapshot.appendItems(fellows, toSection: .fellow)
            snapshot.appendItems(staff, toSection: .staff)
            self.dataSource.apply(snapshot, animatingDifferences: false)
        }
        
    }
    
    private func loadScoreCardData(){
        CWTAPIClient.getScoreboardData { [weak self] (result) in
            switch result {
            case .failure(let error):
                print(error)
                return
            case .success(let scoreboardData):
                DispatchQueue.main.async {
                    self?.scoreCardView.scoreboardWeeklyLabel.text = "Weekly\nFellows: \(scoreboardData.fellowsThisWeek)\nStaff: \(scoreboardData.staffThisWeek)"
                    self?.scoreCardView.scoreboardMonthlyLabel.text = "Monthly\nFellows: \(scoreboardData.fellowsThisMonth)\nStaff: \(scoreboardData.staffThisMonth)"
                    self?.scoreCardView.scoreboardAllTimeLabel.text = "All Time\nFellows: \(scoreboardData.fellowsAllTime)\nStaff: \(scoreboardData.staffAllTime)"
                }
            }
        }
    }
    
}

extension ScoreCardViewController: UISearchBarDelegate    {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        performSearch(searchQuery: searchText)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}

extension ScoreCardViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let snap = dataSource.snapshot()
        let snapSects = snap.sectionIdentifiers
        let selectedSection = snapSects[indexPath.section]
        let userSec = snap.itemIdentifiers(inSection: selectedSection)
        let user = userSec[indexPath.row]
        let userId = user.id
        
        guard let userIdUW = userId, let url = URL(string: RequestURLString.feFellow + String(userIdUW)) else {
            return
        }
        let webVC = SFSafariViewController(url: url)
        present(webVC, animated: true, completion: nil)
    }

}
