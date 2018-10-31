class GameModel {
    
    struct Configuration {
        var size: Size
        var bombsCount: Int
        
        static let beginner = Configuration(
            size: Size(width: 9, height: 9),
            bombsCount: 10)
        
        static let intermediate = Configuration(
            size: Size(width: 16, height: 16),
            bombsCount: 40)
        
        static let advanced = Configuration(
            size: Size(width: 30, height: 16),
            bombsCount: 99)
    }
    
    private(set) var game: Game?
    var configuration: Configuration = .advanced
    
    func revealCellAt(point: Point) {
        if game == nil {
            game = Game(size: configuration.size,
                        initialLocation: point,
                        bombsCount: configuration.bombsCount)
        }
        game?.revealCellAt(point: point)
    }
    
    func restart() {
        game = nil
    }
}
