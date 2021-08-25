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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        loadScoreCardData()
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

