//
//  UserDefaultsManager.swift
//  CodeWarsTracker
//
//  Created by Bienbenido Angeles on 10/21/21.
//

import Foundation

final class UserDefaultsManager {
    
    private static var defaults = UserDefaults.standard
    
    private enum defaultKeys:String {
        case themeKey = "theme"
    }
    
    static func saveTheme(theme:PursuitTheme){
        let themeIndex = PursuitTheme.allCases.firstIndex(of: theme) ?? 0
        defaults.set(themeIndex, forKey: defaultKeys.themeKey.rawValue)
    }
    
    static func loadTheme() -> PursuitTheme{
        let themeIndex = defaults.integer(forKey: defaultKeys.themeKey.rawValue)
        let theme = PursuitTheme.allCases[themeIndex]
        return theme
    }
    
}
