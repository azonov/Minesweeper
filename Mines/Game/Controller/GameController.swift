//
//  ViewController.swift
//  Mines
//
//  Created by Andrey Zonov on 17/09/2018.
//  Copyright © 2018 Andrey Zonov. All rights reserved.
//

import UIKit

class GameController: UIViewController {
    
    @IBOutlet private weak var gameFieldView: GameFieldView!
    private let gameModel = GameModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameFieldView.dataSource = self
        gameFieldView.delegate = self
    }
    
    @IBAction func handleNewGameAction() {
        gameModel.restart()
        gameFieldView.reloadData()
    }
}

extension GameController: GameFieldViewDataSource {
    
    var size: Size {
        return gameModel.configuration.size
    }
    
    func cellTypeAtCoordinates(_ coorditanes: Point) -> CellType {
        guard var game = gameModel.game,
            let cell = game.field[coorditanes],
            game.openedPoints.contains(coorditanes) else { return .closed }
        
        switch cell.type {
        case .bomb:
            return .bomb
            
        case .empty:
            return .empty
            
        case .label(let value):
            return .label(value: value)
        }
    }
}

extension GameController: GameFieldViewDelegate {
    
    func didSelectCellAt(point: Point) {
        gameModel.revealCellAt(point: point)
        gameFieldView.reloadData()
    }
}
