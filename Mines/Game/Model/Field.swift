struct Field {
    
    private var size: Size
    private var cells: [Cell]
    private let generator: Generator
    private var removed: [Int] = []
    
    init(size: Size) {
        self.size = size
        self.generator = Generator(width: size.width)
        self.cells = (0..<self.size.area).map(generator.generate)
    }
    
    mutating func pickRandomCell() -> Cell? {
        return cells.pickRandomElement()
    }
    
    subscript(point: Point) -> Cell? {
        mutating get {
            guard isAvailable(point: point) else { return nil }
            
            return cells[generator.indexForPoint(point)]
        }
        set {
            guard isAvailable(point: point) else { return }
            
            let index = generator.indexForPoint(point)
            
            if let newValue = newValue {
                cells[index] = newValue
            } else {
                let count = removed.filter { $0 < index }.count
                cells.remove(at: index - count)
                removed.append(index)
            }
        }
    }
    
    mutating func generateLabels() {
        let minedCells = cells.filter(Cell.isBomb)
        
        let bombNeighbors = Set<Cell>(minedCells
            .flatMap(neighborsCell)
            .filter(Cell.isNotBomb)
        )
        
        for bombNeighbor in bombNeighbors {
            let label = neighborsCell(around: bombNeighbor)
                .reduce(0) { result, cell in
                    return cell.type == .bomb ? result + 1 : result
            }
            self[bombNeighbor.location]?.type = .label(value: label)
        }
    }
    
    func neighborsCell(around cell: Cell) -> [Cell] {
        let points: [Point] = [Point(x: -1, y: -1),
                               Point(x: -1, y: 0),
                               Point(x: -1, y: 1),
                               Point(x: 0, y: -1),
                               Point(x: 0, y: 1),
                               Point(x: 1, y: -1),
                               Point(x: 1, y: 0),
                               Point(x: 1, y: 1)]
        var field = self
        return points
            .map { $0 + cell.location }
            .filter(isAvailable)
            .compactMap { field[$0] }
    }
    
    private func isAvailable(point: Point) -> Bool {
        return (0..<size.height).contains(point.y)
            && (0..<size.width).contains(point.x)
    }
}

fileprivate struct Generator {
    
    let width: Int
    
    func generate(index: Int) -> Cell {
        let point = pointForIndex(index)
        return Cell(location: point)
    }
    
    func indexForPoint(_ point: Point) -> Int {
        return point.y * width + point.x
    }
    
    private func pointForIndex(_ index: Int) -> Point {
        let x = index % width
        let y = index / width
        return Point(x: x, y: y)
    }
}
