//
//  Difficulty.swift
//  Mines
//
//  Created by Andrey Zonov on 28/10/2018.
//  Copyright © 2018 Andrey Zonov. All rights reserved.
//

import Foundation

enum Difficulty: String, CaseIterable {
    private static let key = "GameConfiguration"
    
    struct Configuration {
        var size: Size
        var bombsCount: Int
    }
    
    case beginner = "Начинающий"
    case intermediate = "Средний"
    case advanced = "Продвинутый"
    
    static var selected: Difficulty {
        set {
            UserDefaults.standard.setValue(newValue.rawValue, forKey: key)
            UserDefaults.standard.synchronize()
        }
        get {
            guard let value = UserDefaults.standard.string(forKey: key),
                let configuration = Difficulty(rawValue: value) else {
                    return .beginner
            }
            
            return configuration
        }
    }
    
    var configuration: Configuration {
        switch self {
        case .beginner:
            return Configuration(size: Size(width: 9, height: 9), bombsCount: 10)
            
        case .intermediate:
            return Configuration(size: Size(width: 16, height: 16), bombsCount: 40)
            
        case .advanced:
            return Configuration(size: Size(width: 30, height: 16), bombsCount: 99)
        }
    }
}
