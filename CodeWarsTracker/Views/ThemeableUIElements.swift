//
//  ThemeableUIElements.swift
//  CodeWarsTracker
//
//  Created by Bienbenido Angeles on 9/25/21.
//

import UIKit

class HighlightedViewController: UIViewController, Themeable {
    
    var statusFromTheme:UIStatusBarStyle = .default {
        didSet{
            setNeedsStatusBarAppearanceUpdate()
            navigationController?.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return statusFromTheme
    }
    
    
    func applyTheme(_ theme: PursuitTheme) {
        view.backgroundColor = theme.settings.appBgColor
        navigationController?.navigationBar.tintColor = theme.settings.highlightedBgColor
        statusFromTheme = theme.settings.statusBarStyle
    }
    
    override func viewDidLoad() {
        ThemeManager.shared.register(self)
        super.viewDidLoad()
    }
}

class HighlightedLabel: UILabel, Themeable {
    func applyTheme(_ theme: PursuitTheme) {
        textColor = theme.settings.textColor
        backgroundColor = theme.settings.highlightedBgColor
        sizeToFit()
    }
    
    override func didMoveToWindow() {
        ThemeManager.shared.register(self)
        super.didMoveToWindow()
    }
}

class UnhighlightedLabel: UILabel, Themeable {
    func applyTheme(_ theme: PursuitTheme) {
        textColor = theme.settings.highlightedBgColor
        //sizeToFit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        ThemeManager.shared.register(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HighlightedButton: UIButton, Themeable {
    func applyTheme(_ theme: PursuitTheme) {
        self.setTitleColor(theme.settings.textColor, for: .normal)
        backgroundColor = theme.settings.highlightedBgColor
        //sizeToFit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        ThemeManager.shared.register(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HighlightedCollectionViewCell: UICollectionViewCell, Themeable {
    func applyTheme(_ theme: PursuitTheme) {
        backgroundColor = theme.settings.highlightedBgColor
        sizeToFit()
    }
    
    override func didMoveToWindow() {
        ThemeManager.shared.register(self)
        super.didMoveToWindow()
    }
}

class HighlightedTableViewCell: UITableViewCell, Themeable {
    func applyTheme(_ theme: PursuitTheme) {
        textLabel?.textColor = theme.settings.textColor
        backgroundColor = theme.settings.highlightedBgColor
        sizeToFit()
    }
    
    override func didMoveToWindow() {
        ThemeManager.shared.register(self)
        super.didMoveToWindow()
    }
}

class HighlightedTextField: UITextView, Themeable {
    func applyTheme(_ theme: PursuitTheme) {
        backgroundColor = theme.settings.appBgColor
        textColor = theme.settings.highlightedBgColor
        sizeToFit()
    }
    
    override func didMoveToWindow() {
        ThemeManager.shared.register(self)
        super.didMoveToWindow()
    }
}

class HighlightedTableView: UITableView, Themeable {
    func applyTheme(_ theme: PursuitTheme) {
        backgroundColor = theme.settings.highlightedBgColor
        sizeToFit()
    }
    
    override func didMoveToWindow() {
        ThemeManager.shared.register(self)
        super.didMoveToWindow()
    }
}

class HighlightedPickerView: UIPickerView, Themeable {
    func applyTheme(_ theme: PursuitTheme) {
        //backgroundColor = theme.settings.highlightedBgColor
        setValue(theme.settings.highlightedBgColor, forKey: "textColor")
        //sizeToFit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        ThemeManager.shared.register(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HighlightedSegmentedControl: UISegmentedControl, Themeable {
    func applyTheme(_ theme: PursuitTheme) {
        backgroundColor = theme.settings.appBgColor
        selectedSegmentTintColor = theme.settings.highlightedBgColor
        setTitleTextAttributes([NSAttributedString.Key.foregroundColor:theme.settings.textColor], for: .normal)
    }
    
    override func didMoveToWindow() {
        ThemeManager.shared.register(self)
        super.didMoveToWindow()
    }
}

class HighlightedSearchBar: UISearchBar, Themeable {
    func applyTheme(_ theme: PursuitTheme) {
        tintColor = theme.settings.highlightedBgColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        ThemeManager.shared.register(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
