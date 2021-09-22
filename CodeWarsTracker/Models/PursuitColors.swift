//
//  PursuitColors.swift
//  CodeWarsTracker
//
//  Created by Bienbenido Angeles on 9/22/21.
//

import UIKit

class PursuitColors: UIColor {
    
    static var pursuitPurle:UIColor {return UIColor(hex: "#4242EA") ?? UIColor()}
    static var electricYellow:UIColor {return UIColor(hex: "#EDFF00") ?? UIColor()}
    static var carbonBlack:UIColor {return UIColor(hex: "#1E1E1E") ?? UIColor()}
    static var starDust:UIColor {return UIColor(hex: "#E3E3E3") ?? UIColor()}
    
}

@objc
enum PursuitTheme:Int {
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
