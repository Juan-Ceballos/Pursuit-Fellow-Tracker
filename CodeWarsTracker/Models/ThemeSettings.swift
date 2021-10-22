//
//  ThemeSettings.swift
//  CodeWarsTracker
//
//  Created by Bienbenido Angeles on 9/22/21.
//

import UIKit

struct ThemeSettings {
    let appBgColor: UIColor
    let highlightedBgColor: UIColor
    let textColor: UIColor
    let statusBarStyle: UIBarStyle
}

extension ThemeSettings {
//    static let lightTheme = ThemeSettings(
//        appBgColor: .white,
//        highlightedBgColor: .lightGray,
//        textColor: .black,
//        statusBarStyle: .default
//    )
//    static let darkTheme = ThemeSettings(
//        appBgColor: .gray,
//        highlightedBgColor: .darkGray,
//        textColor: .white,
//        statusBarStyle: .default
//    )
    
    static let blackNDustTheme = ThemeSettings (
        appBgColor: PursuitColors.carbonBlack,
        highlightedBgColor: PursuitColors.starDust,
        textColor: PursuitColors.pursuitPurle,
        statusBarStyle: .black
    )
    
    static let blackNPurpleTheme = ThemeSettings(
        appBgColor: PursuitColors.carbonBlack,
        highlightedBgColor: PursuitColors.pursuitPurle,
        textColor: PursuitColors.starDust,
        statusBarStyle: .black
    )
    
    static let yellowNBlackTheme = ThemeSettings(
        appBgColor: PursuitColors.electricYellow,
        highlightedBgColor: PursuitColors.carbonBlack,
        textColor: PursuitColors.starDust,
        statusBarStyle: .default
    )
    
    
    static let dustNBlackTheme = ThemeSettings(
        appBgColor: PursuitColors.starDust,
        highlightedBgColor: PursuitColors.carbonBlack,
        textColor: PursuitColors.pursuitPurle,
        statusBarStyle: .default
    )
    
    static let dustNPurpleTheme = ThemeSettings(
        appBgColor: PursuitColors.starDust,
        highlightedBgColor: PursuitColors.pursuitPurle,
        textColor: PursuitColors.carbonBlack,
        statusBarStyle: .default
    )
    
    static let purpleNBlackTheme = ThemeSettings(
        appBgColor: PursuitColors.pursuitPurle,
        highlightedBgColor: PursuitColors.carbonBlack,
        textColor: PursuitColors.starDust,
        statusBarStyle: .default
    )
    
    static let purpleNDustTheme = ThemeSettings(
        appBgColor: PursuitColors.pursuitPurle,
        highlightedBgColor: PursuitColors.starDust,
        textColor: PursuitColors.carbonBlack,
        statusBarStyle: .black
    )
    
}
