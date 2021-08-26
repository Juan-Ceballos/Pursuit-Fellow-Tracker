//
//  ViewController.swift
//  CodeWarsTracker
//
//  Created by Juan Ceballos on 8/17/21.
//

import UIKit

class ScoreCardViewController: UIViewController {
    
    private let scoreCardView = ScoreCardView()
    
    override func loadView() {
        view = scoreCardView
    }
    
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, User>
    private var dataSource: DataSource!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        loadScoreCardData()
        configureCollectionView()
        configureDataSource()
    }
    
    private func configureCollectionView() {
        scoreCardView.cv.register(FellowCardCell.self, forCellWithReuseIdentifier: FellowCardCell.reuseIdentifier)
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, User>(collectionView: scoreCardView.cv, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FellowCardCell.reuseIdentifier, for: indexPath) as? FellowCardCell else {
                fatalError()
            }
            cell.backgroundColor = .systemBackground
            cell.usernameLabel.text = item.username
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, User>()
        snapshot.appendSections([.fellow])
        CWTAPIClient.fetchAllUsers { [weak self] (result) in
            switch result {
            case .failure(let error):
                print("\(error)")
            case .success(let users):
                DispatchQueue.main.async {
                    snapshot.appendItems(users, toSection: .fellow)
                    self?.dataSource.apply(snapshot, animatingDifferences: false)
                }
            }
        }
    }
    
    private func loadScoreCardData(){
        CWTAPIClient.getScoreboardData { (result) in
            switch result {
            case .failure(let appError):
                return
            case .success(let scoreboardData):
                DispatchQueue.main.async {
                    self.scoreCardView.scoreboardWeeklyLabel.text = "Weekly\nFellows: \(scoreboardData.fellows_this_week)\nStaff: \(scoreboardData.staff_this_week)"
                    self.scoreCardView.scoreboardMonthlyLabel.text = "Monthly\nFellows: \(scoreboardData.fellows_this_month)\nStaff: \(scoreboardData.staff_this_month)"
                    self.scoreCardView.scoreboardAllTimeLabel.text = "All Time\nFellows: \(scoreboardData.fellows_all_time)\nStaff: \(scoreboardData.staff_all_time)"
                }
            }
        }
    }
    
    


}

