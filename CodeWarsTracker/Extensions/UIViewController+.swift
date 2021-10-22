//
//  UIViewController+.swift
//  CodeWarsTracker
//
//  Created by Bienbenido Angeles on 9/6/21.
//

import UIKit

extension UIViewController {
    public func showAlert(title: String? = nil, message: String? = nil, completion:((UIAlertAction) ->())? = nil) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: completion)
    alertController.addAction(okAction)
    present(alertController, animated: true)
  }
    
    public convenience init(view: UIView) {
        self.init(nibName: nil, bundle: nil)
        self.view = view
        //view.backgroundColor = .systemBackground
        
    }
    
}
