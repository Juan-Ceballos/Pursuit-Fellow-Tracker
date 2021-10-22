//
//  ThemeableUIElements.swift
//  CodeWarsTracker
//
//  Created by Bienbenido Angeles on 9/25/21.
//

import UIKit

class HighlightedViewController: UIViewController, Themeable {
        
    func applyTheme(_ theme: PursuitTheme) {
        view.backgroundColor = theme.settings.appBgColor
        //navigationController?.navigationBar.tintColor = theme.settings.highlightedBgColor
        //navigationController?.navigationBar.barTintColor = theme.settings.highlightedBgColor
        //navigationController?.navigationBar.backgroundColor = theme.settings.highlightedBgColor
        //navigationItem.titleView?.tintColor = theme.settings.highlightedBgColor
       // navigationController?.navigationBar.barStyle = theme.settings.statusBarStyle
       // print(navigationController != nil)
    }
    
    override func viewDidLoad() {
        ThemeManager.shared.register(self)
        super.viewDidLoad()
    }
    
}

class HighlightedNavigationController: UINavigationController, Themeable {
    
    var themeStatusBar:UIStatusBarStyle = .default {
        didSet{
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    
    func applyTheme(_ theme: PursuitTheme) {
        navigationBar.tintColor = theme.settings.highlightedBgColor
        navigationBar.titleTextAttributes = [.foregroundColor: theme.settings.highlightedBgColor]
        navigationBar.largeTitleTextAttributes = [.foregroundColor: theme.settings.highlightedBgColor]
        themeStatusBar = theme.settings.statusBarStyle
        //navigationBar.barStyle = theme.settings.statusBarStyle
    }
    
    override func viewDidLoad() {
        ThemeManager.shared.register(self)
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return themeStatusBar
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
        detailTextLabel?.textColor = theme.settings.textColor
        backgroundColor = theme.settings.highlightedBgColor
        accessoryView?.tintColor = theme.settings.textColor
        tintColor = theme.settings.textColor
        sizeToFit()
    }
    
    override func didMoveToWindow() {
        ThemeManager.shared.register(self)
        super.didMoveToWindow()
    }
}

class HighlightedTextView: UITextView, Themeable {
    func applyTheme(_ theme: PursuitTheme) {
        backgroundColor = theme.settings.highlightedBgColor
        textColor = theme.settings.textColor
        sizeToFit()
    }
    
    override func didMoveToWindow() {
        ThemeManager.shared.register(self)
        super.didMoveToWindow()
    }
}

class UnhighlightedTextView: UITextView, Themeable {
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

class HighlightedTextField: UITextField, Themeable {
    func applyTheme(_ theme: PursuitTheme) {
        backgroundColor = theme.settings.highlightedBgColor
        textColor = theme.settings.textColor
    }
    
    override func didMoveToWindow() {
        ThemeManager.shared.register(self)
        super.didMoveToWindow()
    }
}

class UnhighlightedTextField: UITextField, Themeable {
    func applyTheme(_ theme: PursuitTheme) {
        backgroundColor = theme.settings.appBgColor
        textColor = theme.settings.highlightedBgColor
    }
    
    override func didMoveToWindow() {
        ThemeManager.shared.register(self)
        super.didMoveToWindow()
    }
}

class HighlightedTableView: UITableView, Themeable, UITableViewDelegate {
    
    func applyTheme(_ theme: PursuitTheme) {
        backgroundColor = theme.settings.appBgColor
        sectionIndexColor = theme.settings.highlightedBgColor
        sizeToFit()
    }
    
    override func didMoveToWindow() {
        ThemeManager.shared.register(self)
        super.didMoveToWindow()
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .red
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
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
        selectedSegmentTintColor = theme.settings.textColor
        setTitleTextAttributes([NSAttributedString.Key.foregroundColor:theme.settings.highlightedBgColor], for: .normal)
    }
    
    override func didMoveToWindow() {
        ThemeManager.shared.register(self)
        super.didMoveToWindow()
    }
}

class HighlightedSearchBar: UISearchBar, Themeable {
    func applyTheme(_ theme: PursuitTheme) {
        barTintColor = theme.settings.appBgColor
        searchTextField.textColor = theme.settings.highlightedBgColor
        searchTextField.tintColor = theme.settings.highlightedBgColor
        searchTextField.backgroundColor = theme.settings.textColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        ThemeManager.shared.register(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HighlightedStackView: UIStackView, Themeable {
    func applyTheme(_ theme: PursuitTheme) {
        backgroundColor = theme.settings.highlightedBgColor
        //subviews.forEach{$0.tintColor = theme.settings.textColor;$0.backgroundColor = theme.settings.highlightedBgColor}
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        ThemeManager.shared.register(self)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class UnHighlightedStackView: UIStackView, Themeable {
    func applyTheme(_ theme: PursuitTheme) {
        backgroundColor = theme.settings.appBgColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        ThemeManager.shared.register(self)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
