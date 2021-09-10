//
//  VolunteerCell.swift
//  CodeWarsTracker
//
//  Created by Bienbenido Angeles on 9/9/21.
//

import UIKit

class VolunteerCell: UITableViewCell {
    
    static let reuseIdentifier = "volunteerCell"
    
    private var containerStackView:UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        return sv
    }()
    
    private var volunteerImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "person.fill"))
        return imageView
    }()
    
    private var labelStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        return sv
    }()
    
    private var volunteerNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    public func configureCell(for: Volunteer){
        
    }

}
