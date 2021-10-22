//
//  UINavigationController+.swift
//  CodeWarsTracker
//
//  Created by Bienbenido Angeles on 9/25/21.
//

import UIKit

extension UINavigationController {
   open override var preferredStatusBarStyle: UIStatusBarStyle {
      return topViewController?.preferredStatusBarStyle ?? .default
   }
}
