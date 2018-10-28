struct Point: Hashable {
    
    let x: Int
    let y: Int
    
    static func +(lhs: Point, rhs: Point) -> Point {
        return Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}

struct Size {
    
    let width: Int
    let height: Int
    
    var area: Int {
        return width * height
    }
    
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }
}
