struct Game {
    
    var field: Field
    
    private let initialLocation: Point
    private let bombsCount: Int
    private(set) var openedPoints = Set<Point>()
    
    init(size: Size,
         initialLocation: Point,
         bombsCount: Int) {
        
        self.field = Field(size: size)
        self.initialLocation = initialLocation
        self.bombsCount = bombsCount
        
        putBombs()
        field.generateLabels()
    }
    
    mutating func revealCellAt(point: Point) {
        openedPoints.insert(point)
        revealNeighbors(point: point)
    }
    
    private mutating func revealNeighbors(point: Point) {
        guard let cell = field[point], cell.type == .empty else { return }
        
        let neigbors = field.neighborsCell(around: cell)
            .filter { $0.type != .bomb }
        
        for neigbor in neigbors {
            if !openedPoints.contains(neigbor.location) {
                openedPoints.insert(neigbor.location)
                revealNeighbors(point: neigbor.location)
            }
        }
    }
    
    private func generateBombsLocations() -> [Point] {
        var field = self.field
        
        guard let initialCell = field[initialLocation] else { return [] }
        
        var aroundCells = field.neighborsCell(around: initialCell)
        aroundCells.append(initialCell)
        
        for cell in aroundCells {
            field[cell.location] = nil
        }
        
        return (0..<bombsCount).compactMap { _ in
            field.pickRandomCell()?.location
        }
    }
    
    private mutating func putBombs() {
        for location in generateBombsLocations() {
            field[location]?.type = .bomb
        }
    }
}
