//
//  HowToUseViewController.swift
//  CodeWarsTracker
//
//  Created by Bienbenido Angeles on 9/21/21.
//

import UIKit
import SafariServices
import DropDown

class HowToUseViewController: HighlightedViewController {

    private let howToUseView = HowToUseView()
    
    private var selectedMenu: String
    
    override func loadView() {
        view = howToUseView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        delegates()
        addNavBarTitles()
    }
    
    init(dropDown: DropDown) {
        self.selectedMenu = dropDown.selectedItem ?? ""
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func delegates(){
        howToUseView.subHeadLabel.delegate = self
    }
    
    private func addNavBarTitles(){
        navigationItem.title = selectedMenu
    }
}

extension HowToUseViewController: UITextViewDelegate {
    @discardableResult
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        
        let safariVC = SFSafariViewController(url: URL)
        self.present(safariVC, animated: true, completion: nil)
        return false
    }
    
    func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        guard var image = textAttachment.image else {
            return false
        }
        
        image = UIImage(named: "codewars_webhook_screenshot") ?? UIImage()
        
        let sv = PanZoomImageView(image: image)
        let tempVC = UIViewController(view: sv)
        present(tempVC, animated: true, completion: nil)
        return true
    }
}

