//
//  ViewController.swift
//  CodeWarsTracker
//
//  Created by Juan Ceballos on 8/17/21.
//

import UIKit

class ScoreCardViewController: NavBarViewController {
    private let scoreCardView = ScoreCardView()
    
    override func loadView() {
        view = scoreCardView
    }
    
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, User>
    private var dataSource: DataSource!
    private var allUsers = [User]()
    private var allSevenPointOneUsers = [User]()
    private var allSevenPointTwoUsers = [User]()
    private var allEightPointOneUsers = [User]()
    private var allEightPointTwoUsers = [User]()
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        loadAllUsers()
        configureCollectionView()
        configureSearchBar()
        loadScoreCardData()
        scoreCardView.searchBar.delegate = self
        refreshControl.addTarget(self, action: #selector(refreshUserData), for: .valueChanged)
    }
    
    private func configureSearchBar() {
        scoreCardView.searchBar.showsScopeBar = true
        scoreCardView.searchBar.scopeButtonTitles = ["All", "7.1", "7.2", "8.1", "8.2"]
    }
    
    @objc private func refreshUserData() {
        loadAllUsers()
        loadScoreCardData()
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
        }
    }
    
    private func loadAllUsers() {
        
            CWTAPIClient.fetchAllUsers { (result) in
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        print(error)
                    }
                    
                case .success(let users):
                    DispatchQueue.main.async {
                        
                    
                    self.allUsers = users.sorted {$0.honor ?? 0 > $1.honor ?? 0}
                    self.allSevenPointOneUsers = self.allUsers.filter {$0.cohort == "Pursuit-7.1"}
                    self.allSevenPointTwoUsers = self.allUsers.filter {$0.cohort == "Pursuit-7.2"}
                    self.allEightPointOneUsers = self.allUsers.filter {$0.cohort == "Pursuit-8.1"}
                    self.allEightPointTwoUsers = self.allUsers.filter {$0.cohort == "Pursuit-8.2"}
                    self.configureDataSource()
                    }
                }
            }
        
        
    }
    
    private func performSearch(searchQuery: String?) {
        var filteredFellows = [User]()
        var filteredStaff = [User]()
        var selectedUsers = [User]()
        
        switch scoreCardView.searchBar.selectedScopeButtonIndex {
        case 0:
            selectedUsers = allUsers
        case 1:
            selectedUsers = allSevenPointOneUsers
        case 2:
            selectedUsers = allSevenPointTwoUsers
        case 3:
            selectedUsers = allEightPointOneUsers
        case 4:
            selectedUsers = allEightPointTwoUsers
        default:
            selectedUsers = allUsers
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
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, User>()
        snapshot.deleteAllItems()
        self.dataSource.apply(snapshot)
        snapshot.appendSections([.leaderBoard, .fellow, .staff])
        snapshot.appendItems(filteredFellows, toSection: .fellow)
        snapshot.appendItems(filteredStaff, toSection: .staff)
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func configureCollectionView() {
        print(allUsers)
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
                
                
                cell.backgroundColor = .systemBlue
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
                    headerView.textLabel.text = "Leader Board"
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
            var topFellows = [User]()
            var usersSorted = [User]()
            
            switch self.scoreCardView.searchBar.selectedScopeButtonIndex {
            case 0:
                usersSorted = self.allUsers
            case 1:
                usersSorted = self.allSevenPointOneUsers
            case 2:
                usersSorted = self.allSevenPointTwoUsers
            case 3:
                usersSorted = self.allEightPointOneUsers
            case 4:
                usersSorted = self.allEightPointTwoUsers
            default:
                usersSorted = self.allUsers
            }
            
            for user in usersSorted {
                if user.role == "staff" {
                    staff.append(user)
                } else if user.role == "fellow" {
                    fellows.append(user)
                }
            }
            
            let fellowsByWeekPoints = fellows.sorted {$0.pointThisWeek ?? 0 > $1.pointThisWeek ?? 0}
            for (index, fellow) in fellowsByWeekPoints.enumerated() {
                while topFellows.count < 3 {
                    if fellow.pointThisWeek ?? 0 > 0 {
                        var topper = fellowsByWeekPoints[index]
                        topper.isTopFellow = true
                        topFellows.append(topper)
                        break
                    }
                }
            }
            
            snapshot.appendSections([.leaderBoard, .fellow, .staff])
            snapshot.appendItems(topFellows, toSection: .leaderBoard)
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
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        configureDataSource()
    }
    
}

extension ScoreCardViewController: UICollectionViewDelegateFlowLayout {
    
}
