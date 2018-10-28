struct Cell: Hashable {
    
    enum `Type`: Hashable, Equatable {
        case empty
        case bomb
        case label(value: Int)
    }
    
    let location: Point
    var type: `Type` = .empty
    
    init(location: Point) {
        self.location = location
    }
    
    static func isBomb(_ cell: Cell) -> Bool {
        return cell.type == .bomb
    }
    
    static func isNotBomb(_ cell: Cell) -> Bool {
        return !isBomb(cell)
    }
}
