//
//  GameModel.swift
//  Mines
//
//  Created by Andrey Zonov on 01/10/2018.
//  Copyright © 2018 Andrey Zonov. All rights reserved.
//

import Foundation

class GameModel {
    
    private(set) var game: Game?
    
    var configuration: Difficulty.Configuration {
        return Difficulty.selected.configuration
    }
    
    func revealCellAt(point: Point) {
        if game == nil {
            game = Game(size: configuration.size,
                        initialLocation: point,
                        bombsCount: configuration.bombsCount)
        }
        game?.revealCellAt(point: point)
    }
    
    func cellTypeAtCoordinates(_ coordinates: Point) -> CellType {
        guard var game = game, let cell = game.field[coordinates] else { return .closed }
        
        if game.isOver || game.openedPoints.contains(coordinates) {
            switch cell.type {
            case .bomb:
                return .bomb
            case .empty:
                return .empty
            case .label(let value):
                return .label(value: value)
            }
        } else {
            return .closed
        }
    }
    
    func restart() {
        game = nil
    }
}
