//
//  ThemeManager.swift
//  CodeWarsTracker
//
//  Created by Bienbenido Angeles on 9/22/21.
//
//Original tut from https://sergebouts.github.io/swift-theme-manager/

import Foundation

@objc
protocol Themeable {
    func applyTheme(_ theme: PursuitTheme)
}

final class ThemeManager {
    
    //1.Observer Pattern - store observers, UIElements
    private var themables = NSHashTable<Themeable>.weakObjects()
    
    var theme: PursuitTheme {
        didSet{
            guard theme != oldValue else {
                return
            }
            apply()
        }
    }
    
    //1. Singleton Pattern
    private static var instance: ThemeManager?
    
    //2. Singleton Pattern
    public static var shared: ThemeManager {
        if instance == nil {
            let savedTheme = UserDefaultsManager.loadTheme()
            instance = ThemeManager(defaultTheme: savedTheme)
        }
        return instance!
    }
    
    private init(defaultTheme: PursuitTheme){
        self.theme = defaultTheme
    }
    
    //2. Observer Pattern - register observers
    public func register(_ themable: Themeable){
        themables.add(themable)
        
        //apply default theme
        themable.applyTheme(theme)
    }
    
    //3.Observer Pattern - apply observers
    private func apply(){
        themables.allObjects.forEach{
            $0.applyTheme(theme)
        }
    }
    
    public func setTheme(_ theme: PursuitTheme){
        self.theme = theme
    }
}
