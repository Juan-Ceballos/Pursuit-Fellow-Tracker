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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        loadScoreCardData()
        configureCollectionView()
        configureDataSource()
    }
    
    private func configureCollectionView() {
        scoreCardView.cv.register(FellowCardCell.self, forCellWithReuseIdentifier: FellowCardCell.reuseIdentifier)
        scoreCardView.cv.register(HeaderView.self, forSupplementaryViewOfKind: Constants.headerElementKind, withReuseIdentifier: HeaderView.reuseIdentifier)
        scoreCardView.cv.register(BannerView.self, forSupplementaryViewOfKind: Constants.badgeElementKind, withReuseIdentifier: BannerView.reuseIdentifier)
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, User>(collectionView: scoreCardView.cv, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FellowCardCell.reuseIdentifier, for: indexPath) as? FellowCardCell else {
                fatalError()
            }
            cell.backgroundColor = .systemBlue
            cell.nameLabel.text = item.name
            cell.usernameLabel.text = "Codewars: \(item.username)"
            cell.clanLabel.text = "Clan: \(item.clan ?? "No Clan")"
            cell.honorLabel.text = String(item.honor ?? 0)
            cell.pointsThisWeekLabel.text = "This Week: \(String(item.pointThisWeek ?? 0))"
            cell.pointsThisMonthLabel.text = "This Month: \(String(item.pointThisMonth ?? 0))"
            return cell
        })
        
        dataSource.supplementaryViewProvider = { [weak self] (collectionView, kind, indexPath) in
            if kind == Constants.headerElementKind {
                if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.reuseIdentifier, for: indexPath) as? HeaderView {
                    if self?.dataSource.itemIdentifier(for: indexPath)!.role == "staff" {
                        headerView.textLabel.text = "Staff"

                    } else {
                        headerView.textLabel.text = "Fellows"
                    }
                    
                    headerView.textLabel.textAlignment = .left
                    headerView.textLabel.font = UIFont.preferredFont(forTextStyle: .headline)
                    return headerView
                }
            }
            
            
            guard let strongSelf = self, let sequence = strongSelf.dataSource.itemIdentifier(for: indexPath) else { return nil }
            if let badgeView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: BannerView.reuseIdentifier, for: indexPath) as? BannerView {
                if sequence.role != "staff" {
                    badgeView.isHidden = true
                    return badgeView
                }
                badgeView.isHidden = false
                badgeView.staffLabel.text = "Staff"
                return badgeView
                
            }
            
            fatalError()
            
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, User>()
        var fellows = [User]()
        var staff = [User]()
        snapshot.appendSections([.fellow, .staff])
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

