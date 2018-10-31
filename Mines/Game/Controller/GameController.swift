//
//  ViewController.swift
//  Mines
//
//  Created by Andrey Zonov on 17/09/2018.
//  Copyright © 2018 Andrey Zonov. All rights reserved.
//

import UIKit

class GameController: UIViewController {
    
    private var gameFieldView = GameFieldView()
    @IBOutlet weak var scrollView: UIScrollView!
    private let gameModel = GameModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.addSubview(gameFieldView)
        gameFieldView.dataSource = self
        view.layoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        updateMinZoomScaleForSize(view.bounds.size)
    }
    
    @IBAction func handleNewGameAction() {
        gameModel.restart()
        gameFieldView.reloadData()
    }
    
    private func updateMinZoomScaleForSize(_ size: CGSize) {
        let widthScale = size.width / gameFieldView.bounds.width
        let heightScale = size.height / gameFieldView.bounds.height
        let minScale = min(widthScale, heightScale)
        
        scrollView.minimumZoomScale = minScale
        scrollView.zoomScale = minScale
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

extension GameController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return gameFieldView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let offsetX = max((scrollView.bounds.width - scrollView.contentSize.width) * 0.5, 0)
        let offsetY = max((scrollView.bounds.height - scrollView.contentSize.height) * 0.5, 0)
        
        scrollView.contentInset = UIEdgeInsets(top: offsetY,
                                               left: offsetX,
                                               bottom: 0,
                                               right: 0)
    }
}
