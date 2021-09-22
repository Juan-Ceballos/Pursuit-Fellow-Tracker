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
}

extension ThemeSettings {
    static let lightTheme = ThemeSettings(
        appBgColor: .white,
        highlightedBgColor: .lightGray,
        textColor: .black
    )
    static let darkTheme = ThemeSettings(
        appBgColor: .gray,
        highlightedBgColor: .darkGray,
        textColor: .white
    )
    
    //complete
    static let blackNDustTheme = ThemeSettings (
        appBgColor: PursuitColors.carbonBlack,
        highlightedBgColor: PursuitColors.starDust,
        textColor: PursuitColors.pursuitPurle
    )
    
    //complete
    static let blackNPurpleTheme = ThemeSettings(
        appBgColor: PursuitColors.carbonBlack,
        highlightedBgColor: PursuitColors.pursuitPurle,
        textColor: PursuitColors.starDust
    )
    
    //complete
    static let yellowNBlackTheme = ThemeSettings(
        appBgColor: PursuitColors.electricYellow,
        highlightedBgColor: PursuitColors.carbonBlack,
        textColor: PursuitColors.starDust
    )
    
    
    static let dustNBlackTheme = ThemeSettings(
        appBgColor: PursuitColors.starDust,
        highlightedBgColor: PursuitColors.carbonBlack,
        textColor: PursuitColors.pursuitPurle
    )
    
    static let dustNPurpleTheme = ThemeSettings(
        appBgColor: PursuitColors.starDust,
        highlightedBgColor: PursuitColors.pursuitPurle,
        textColor: PursuitColors.carbonBlack
    )
    
    static let purpleNBlackTheme = ThemeSettings(
        appBgColor: PursuitColors.pursuitPurle,
        highlightedBgColor: PursuitColors.carbonBlack,
        textColor: PursuitColors.starDust
    )
    
    static let purpleNDustTheme = ThemeSettings(
        appBgColor: PursuitColors.pursuitPurle,
        highlightedBgColor: PursuitColors.starDust,
        textColor: PursuitColors.carbonBlack
    )
    
}