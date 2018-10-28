import Darwin//arc4random_uniform

extension CountableRange where Bound == Int {
    
    var randomElement: Bound {
        let distance = lowerBound.distance(to: upperBound)
        return Int(arc4random_uniform(UInt32(distance)))
    }
}

extension RangeReplaceableCollection where Index == Int {
    
    mutating func pickRandomElement() -> Element? {
        guard !isEmpty else { return nil }
        
        let index = (startIndex..<endIndex).randomElement
        let element = self[index]
        remove(at: index)
        
        return element
    }
}
