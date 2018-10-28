import UIKit

class CellView: UIButton {
    
    private(set) var point: Point
    
    var cellType: CellType = .closed {
        didSet {
            let title: String
            switch cellType {
            case .closed:
                title = "🔒"
            case .flagged:
                title = "🚩"
            case .label(let label):
                title = "\(label)"
            case .bomb:
                title = "💣"
            case .empty:
                title = ""
            }
            setTitle(title, for: .normal)
        }
    }
    
    init(point: Point) {
        self.point = point
        
        super.init(frame: .zero)
        
        setTitleColor(.black, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.black.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
