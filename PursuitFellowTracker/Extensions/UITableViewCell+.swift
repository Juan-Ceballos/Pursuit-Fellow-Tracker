//
//  UITableViewCell+.swift
//  CodeWarsTracker
//
//  Created by Bienbenido Angeles on 9/10/21.
//

import UIKit

public protocol TableViewCellConformance {
    var title: String { get }
    var subtitle:String? {get}
    var imageURLLink:String? { get }
}

extension UITableViewCell {
    public func configureCell<T: TableViewCellConformance>(for obj: T) {
        self.textLabel?.text = obj.title
        if let subtitle = obj.subtitle {
            self.detailTextLabel?.text = subtitle
        }
        if let image = obj.imageURLLink {
            //image handling for the future
            //self.imageView?.image =
        }
    }
}
