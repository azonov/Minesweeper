import UIKit

class GameFieldView: UIView {
    
    weak var dataSource: GameFieldViewDataSource? {
        didSet {
            setupField()
            reloadData()
        }
    }
    
    weak var delegate: GameFieldViewDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let fieldSize = dataSource?.size,
            let cells = subviews as? [CellView] else { return }
        
        let dimension = min(bounds.width, bounds.height) / CGFloat(fieldSize.width)
        let cellSize = CGSize(width: dimension, height: dimension)
        let diff = abs(bounds.width - bounds.height) / 2
        var movX: CGFloat = 0
        var movY: CGFloat = 0
        if bounds.width > bounds.height {
            movX = diff
        } else {
            movY = diff
        }
        for cell in cells {
            let origin = CGPoint(x: movX + CGFloat(cell.point.x) * dimension,
                                 y: movY + CGFloat(cell.point.y) * dimension)
            cell.frame = CGRect(origin: origin, size: cellSize)
        }
    }
    
    private func setupField() {
        guard let fieldSize = dataSource?.size else { return }
        
        subviews.forEach { $0.removeFromSuperview() }
        let view = UIView()
        let rect = CGRect(x: 20, y: 20, width: 30, height: 50)
        let label = UILabel(frame: rect)
        label.text = "Лекция 3"
        view.addSubview(label)
        for x in 0..<fieldSize.width {
            for y in 0..<fieldSize.height {
                let cell = CellView(point: Point(x: x, y: y))
                cell.addTarget(self,
                               action: #selector(handleTouchUpInsideAction),
                               for: .touchUpInside)
                addSubview(cell)
            }
        }
    }
    
    func reloadData() {
        guard let dataSource = dataSource,
            let cells = subviews as? [CellView] else { return }
        
        for cell in cells {
            cell.cellType = dataSource.cellTypeAtCoordinates(cell.point)
        }
    }
    
    @objc
    private func handleTouchUpInsideAction(_ cell: CellView) {
        delegate?.didSelectCellAt(point: cell.point)
    }
}
