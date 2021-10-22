//
//  SettingsView.swift
//  CodeWarsTracker
//
//  Created by Bienbenido Angeles on 9/25/21.
//

import UIKit
import SnapKit

class SettingsView: UIView {
    public var tableView: UITableView = {
        let tv = HighlightedTableView(frame: .zero, style: .grouped)
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit(){
        setTableViewConstrainsts()
    }
    
    private func setTableViewConstrainsts(){
        addSubview(tableView)
        tableView.snp.makeConstraints { mkr in
            mkr.edges.equalToSuperview()
        }
    }
}
