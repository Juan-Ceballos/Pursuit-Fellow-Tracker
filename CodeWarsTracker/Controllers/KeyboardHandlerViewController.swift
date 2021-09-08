//
//  KeyboardHandlerViewController.swift
//  CodeWarsTracker
//
//  Created by Bienbenido Angeles on 9/8/21.
//  Original Source code from https://github.com/bhlvoong/LBTATools/blob/master/Source/Form/LBTAFormController.swift
//

import UIKit

public enum FormAlignment {
    case top, center
}

class KeyboardHandlerViewController: UIViewController {
    
    var lowestElement: UIView!
    public lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.contentInsetAdjustmentBehavior = .never
        sv.contentSize = view.frame.size
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
    
    public init(alignment: FormAlignment = .top) {
        self.alignment = alignment
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
            fatalError("You most likely have a Storyboard controller that uses this class, please remove any instance of LBTAFormController or sublasses of this component from your Storyboard files.")
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(formContainerStackView)
        
        if alignment == .top {
            formContainerStackView.anchor(top: scrollView.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
        } else {
            formContainerStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
            formContainerStackView.centerInSuperview()
        }
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if formContainerStackView.frame.height > view.frame.height {
            scrollView.contentSize.height = formContainerStackView.frame.size.height
        }
        
        _ = distanceToBottom
    }
    
    private func distanceFromLowestElementToBottom() -> CGFloat {
        if lowestElement != nil {
            guard let frame = lowestElement.superview?.convert(lowestElement.frame, to: view) else { return 0 }
            let distance = view.frame.height - frame.origin.y - frame.height
            return distance
        }
        
        return view.frame.height - formContainerStackView.frame.maxY
    }
    
    private func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func handleKeyboardShow(notification: Notification) {
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue, let statusBarHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height else { return }
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
