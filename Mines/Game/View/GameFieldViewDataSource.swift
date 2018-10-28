//
//  GameFieldViewDataSource.swift
//  Mines
//
//  Created by Andrey Zonov on 01/10/2018.
//  Copyright © 2018 Andrey Zonov. All rights reserved.
//

enum CellType {
    case closed
    case flagged
    case bomb
    case empty
    case label(value: Int)
}

protocol GameFieldViewDataSource: class {
    
    var size: Size { get }
    func cellTypeAtCoordinates(_ coordinates: Point) -> CellType
}
