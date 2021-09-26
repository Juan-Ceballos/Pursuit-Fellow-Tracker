//
//  PursuitColors.swift
//  CodeWarsTracker
//
//  Created by Bienbenido Angeles on 9/22/21.
//

import UIKit

class PursuitColors: UIColor {
    
    static var pursuitPurle:UIColor {return UIColor(hex: 0x4242EA) }
    static var electricYellow:UIColor {return UIColor(hex: 0xEDFF00) }
    static var carbonBlack:UIColor {return UIColor(hex: 0x1E1E1E) }
    static var starDust:UIColor {return UIColor(hex: 0xE3E3E3) }
    
}

@objc
enum PursuitTheme:Int, CaseIterable {
    case light
    case dark
    case blackNDust
    case blackNPurple
    case yellowNBlack
    case dustNBlack
    case dustNPurple
    case purpleNBlack
    case purpleNDust
    var settings: ThemeSettings {
        switch self {
        case .light:
            return .lightTheme
        case .dark:
            return .darkTheme
        case .blackNDust:
            return .blackNDustTheme
        case .blackNPurple:
            return .blackNPurpleTheme
        case .yellowNBlack:
            return .yellowNBlackTheme
        case .dustNBlack:
            return .dustNBlackTheme
        case .dustNPurple:
            return .dustNPurpleTheme
        case .purpleNBlack:
            return .purpleNBlackTheme
        case .purpleNDust:
            return .purpleNDustTheme
        }
    }
    
    var settingNames: String {
        switch self {
        case .light:
            return "Light"
        case .dark:
            return "Dark"
        case .blackNDust:
            return "Carbon black and Stardust"
        case .blackNPurple:
            return "Carbon black and Pursuit Purple"
        case .yellowNBlack:
            return "Electric yellow and Carbon black"
        case .dustNBlack:
            return "Stardust and Carbon black"
        case .dustNPurple:
            return "Stardust and Pursuit Purple"
        case .purpleNBlack:
            return "Pursuit Purple and Carbon black"
        case .purpleNDust:
            return "Pursuit Purple and Stardust"
        }
    }
    //        func get() -> (back: UIColor, fore: UIColor) {
    //                switch self {
    //                case .blackNWhite(back: let back, fore: let fore):
    //                    return (back:back,fore:fore)
    //                case .yellowNBlack(back: let back, fore: let fore):
    //                    return (back:back,fore:fore)
    //                case .dustNBlack(back: let back, fore: let fore):
    //                    return (back:back,fore:fore)
    //                case .purpleNBlack(back: let back, fore: let fore):
    //                    return (back:back,fore:fore)
    //                case .purpleNWhite(back: let back, fore: let fore):
    //                    return (back:back,fore:fore)
    //                }
    //            }
}
