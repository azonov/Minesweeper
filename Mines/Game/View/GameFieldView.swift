import UIKit

class GameFieldView: UIView {
    
    weak var dataSource: GameFieldViewDataSource? {
        didSet {
            setupView()
            reloadData()
        }
    }
    
    var size: CGFloat {
        return UIFont.preferredFont(forTextStyle: .largeTitle).lineHeight
    }
    
    private func setupView() {
        guard let fieldSize = dataSource?.size else { return }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        widthAnchor.constraint(equalToConstant: CGFloat(fieldSize.width) * size).isActive = true
        heightAnchor.constraint(equalToConstant: CGFloat(fieldSize.height) * size).isActive = true
        
        for subview in subviews {
            subview.removeFromSuperview()
        }
        for x in 0..<fieldSize.width {
            for y in 0..<fieldSize.height {
                let point = Point(x: x, y: y)
                
                let cell = CellView(point: point)
                
                addSubview(cell)
                
                let xOffset = CGFloat(x) * size
                let yOffset = CGFloat(y) * size
                
                cell.widthAnchor.constraint(equalToConstant: size).isActive = true
                cell.heightAnchor.constraint(equalToConstant: size).isActive = true
                
                cell.leftAnchor.constraint(equalTo: self.leftAnchor,
                                           constant: xOffset).isActive = true
                cell.topAnchor.constraint(equalTo: self.topAnchor,
                                          constant: yOffset).isActive = true
            }
        }
    }
    
    func reloadData() {
        if dataSource?.size.area != subviews.count {
            for subview in subviews {
                subview.removeFromSuperview()
            }
            constraints.forEach(removeConstraint)
        }
        
        guard let dataSource = dataSource,
            let cells = subviews as? [CellView] else {
            return
        }
        
        for cell in cells {
            cell.cellType = dataSource.cellTypeAtCoordinates(cell.point)
        }
    }
}
