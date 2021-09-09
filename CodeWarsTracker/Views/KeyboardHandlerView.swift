//
//  KeyboardHandlerViewController.swift
//  CodeWarsTracker
//
//  Created by Bienbenido Angeles on 9/8/21.
//  Original Source code from https://github.com/bhlvoong/LBTATools/blob/master/Source/Form/LBTAFormController.swift
//

import UIKit
import SnapKit

public enum FormAlignment {
    case top, center
}

class KeyboardHandlerView: UIView {
    
    var lowestElement: UIView!
    public lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.contentInsetAdjustmentBehavior = .never
        sv.contentSize = self.frame.size
        sv.keyboardDismissMode = .interactive
        return sv
    }()
    
    public let formContainerStackView: UIStackView = {
        let sv = UIStackView()
        sv.isLayoutMarginsRelativeArrangement = true
        sv.axis = .vertical
        return sv
    }()
    
    private lazy var distanceToBottom = self.distanceFromLowestElementToBottom()
    
    private let alignment: FormAlignment
    
//    override init(frame: CGRect) {
//        super.init(frame: UIScreen.main.bounds)
//    }
    
    public init(alignment: FormAlignment = .top) {
        self.alignment = alignment
        super.init(frame: UIScreen.main.bounds)
        commoninit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("You most likely have a Storyboard controller that uses this class, please remove any instance of LBTAFormController or sublasses of this component from your Storyboard files.")
    }
    
    private func commoninit(){
        self.backgroundColor = .white
        self.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(formContainerStackView)
        
        if alignment == .top {
            formContainerStackView.anchor(top: scrollView.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor)
        } else {
            formContainerStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
            formContainerStackView.centerInSuperview()
        }
        
        //viewDidAppear
        if formContainerStackView.frame.height > self.frame.height {
            scrollView.contentSize.height = formContainerStackView.frame.size.height
        }
        
        _ = distanceToBottom
    }
    
    private func distanceFromLowestElementToBottom() -> CGFloat {
        if lowestElement != nil {
            guard let frame = lowestElement.superview?.convert(lowestElement.frame, to: self) else { return 0 }
            let distance = self.frame.height - frame.origin.y - frame.height
            return distance
        }
        
        return self.frame.height - formContainerStackView.frame.maxY
    }
    
    private func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func handleKeyboardShow(notification: Notification) {
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue, let statusBarHeight = self.window?.windowScene?.statusBarManager?.statusBarFrame.height else { return }
        let keyboardFrame = value.cgRectValue
        
        scrollView.contentInset.bottom = keyboardFrame.height
        
        if alignment == .center {
            scrollView.contentInset.bottom += statusBarHeight
        }
        
        if distanceToBottom > 0 {
            scrollView.contentInset.bottom -= distanceToBottom
        }
        
        self.scrollView.verticalScrollIndicatorInsets.bottom = keyboardFrame.height
    }
    
    @objc private func handleKeyboardHide() {
        self.scrollView.contentInset.bottom = 0
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
}
