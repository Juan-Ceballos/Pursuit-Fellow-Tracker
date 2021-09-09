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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        loadScoreCardData()
        configureCollectionView()
        configureDataSource()
        scoreCardView.searchBar.delegate = self
        loadAllUsers()
    }
    
    private func loadAllUsers() {
        CWTAPIClient.fetchAllUsers { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let users):
                self.allUsers = users.sorted {$0.honor ?? 0 > $1.honor ?? 0}
            }
        }
    }
    
    private func performSearch(searchQuery: String?) {
        var filteredFellows = [User]()
        var filteredStaff = [User]()
        
        for user in allUsers {
            if user.role == "staff" {
                filteredStaff.append(user)
            } else if user.role == "fellow" {
                filteredFellows.append(user)
            }
        }
        
        if let searchQuery = searchQuery, !searchQuery.isEmpty {
            filteredFellows = filteredFellows.filter { $0.name.contains(searchQuery) }
            filteredStaff = filteredStaff.filter { $0.name.contains(searchQuery) }
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, User>()
        snapshot.deleteAllItems()
        self.dataSource.apply(snapshot)
        snapshot.appendSections([.fellow, .staff])
        snapshot.appendItems(filteredFellows, toSection: .fellow)
        snapshot.appendItems(filteredStaff, toSection: .staff)
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func configureCollectionView() {
        scoreCardView.cv.register(FellowCardCell.self, forCellWithReuseIdentifier: FellowCardCell.reuseIdentifier)
        scoreCardView.cv.register(HeaderView.self, forSupplementaryViewOfKind: Constants.headerElementKind, withReuseIdentifier: HeaderView.reuseIdentifier)
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, User>(collectionView: scoreCardView.cv, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FellowCardCell.reuseIdentifier, for: indexPath) as? FellowCardCell else {
                fatalError()
            }
            
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
                cell.leaderBoardBadgeLabel.text = "\(indexPath.row + 1)"
                cell.leaderBoardBadgeLabel.backgroundColor = .systemOrange
            case 1:
                cell.bannerView.isHidden = true
            case 2:
                cell.bannerView.isHidden = false
            default:
                print()
            }
//            if let item = self.dataSource.itemIdentifier(for: indexPath) {
//                if item.role != "staff" {
//                    DispatchQueue.main.async {
//                        cell.bannerView.isHidden = true
//                    }
//                } else {
//                    cell.bannerView.isHidden = false
//                }
//            }
            return cell
        })
        
        dataSource.supplementaryViewProvider = {
            (collectionView, kind, indexPath) in
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.reuseIdentifier, for: indexPath) as? HeaderView else {
                fatalError()
            }
            
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
            
            return headerView
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, User>()
        var fellows = [User]()
        var staff = [User]()
        var topFellows = [User]()
        snapshot.appendSections([.leaderBoard, .fellow, .staff])
        CWTAPIClient.fetchAllUsers { [weak self] (result) in
            switch result {
            case .failure(let error):
                print("\(error)")
            case .success(let users):
                let usersSorted = users.sorted {$0.honor ?? 0 > $1.honor ?? 0}
                DispatchQueue.main.async {
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
                    snapshot.appendItems(topFellows, toSection: .leaderBoard)
                    snapshot.appendItems(fellows, toSection: .fellow)
                    snapshot.appendItems(staff, toSection: .staff)
                    self?.dataSource.apply(snapshot, animatingDifferences: false)
                }
            }
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

extension ScoreCardViewController: UICollectionViewDelegateFlowLayout {
    
}
