//
//  ViewController.swift
//  Mines
//
//  Created by Andrey Zonov on 17/09/2018.
//  Copyright © 2018 Andrey Zonov. All rights reserved.
//

import UIKit

class GameController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    private var gameFieldView = GameFieldView()
    private let gameModel = GameModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.addSubview(gameFieldView)
        gameFieldView.dataSource = self
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        gameFieldView.addGestureRecognizer(recognizer)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        zoomOut()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? SettingsViewController else { return }
        destination.delegate = self
        destination.popoverPresentationController?.delegate = self
        destination.preferredContentSize = CGSize(width: 150, height: Difficulty.allCases.count * 44)
    }
    
    @IBAction func startNewGameTapped() {
        restart()
    }
    
    private func zoomOut() {
        updateMinZoomScaleForSize(view.bounds.size)
    }
    
    private func updateMinZoomScaleForSize(_ size: CGSize) {
        let widthScale = size.width / gameFieldView.bounds.width
        let heightScale = size.height / gameFieldView.bounds.height
        let minScale = min(widthScale, heightScale)
        
        scrollView.minimumZoomScale = minScale
        scrollView.zoomScale = minScale
    }
    
    private func didSelectCellAt(point: Point) {
        gameModel.revealCellAt(point: point)
        gameFieldView.reloadData()
    }
    
    @objc
    private func handleTapGesture(_ gestureRecognizer: UITapGestureRecognizer) {
        let location = gestureRecognizer.location(in: gameFieldView)
        if scrollView.zoomScale < 1 {
            scrollView.zoomTo(location: location)
        } else {
            let size = gameFieldView.size
            let point = Point(x: Int(location.x / size),
                              y: Int(location.y / size))
            didSelectCellAt(point: point)
        }
    }
    
    private func restart() {
        gameModel.restart()
        gameFieldView.reloadData()
        UIView.animate(withDuration: 0.5, animations: self.zoomOut)
    }
}

extension GameController: GameFieldViewDataSource {
    
    var size: Size {
        return gameModel.configuration.size
    }
    
    func cellTypeAtCoordinates(_ coordinates: Point) -> CellType {
        return gameModel.cellTypeAtCoordinates(coordinates)
    }
}

extension GameController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return gameFieldView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let offsetX = max((scrollView.bounds.width - scrollView.contentSize.width) * 0.5, 0)
        let offsetY = max((scrollView.bounds.height - scrollView.contentSize.height) * 0.5, 0)
        scrollView.contentInset = UIEdgeInsets(top: offsetY, left: offsetX, bottom: 0, right: 0)
    }
}

extension GameController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

extension GameController: SettingsControllerDelegate {
    
    func didSelectConfiguration() {
        dismiss(animated: true)
        restart()
    }
}
