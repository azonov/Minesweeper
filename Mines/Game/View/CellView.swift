import UIKit

class CellView: UIView {
    
    private let label = UILabel()
    private lazy var tileLayer = CAShapeLayer()
    private(set) var point: Point
    
    var cellType: CellType = .closed {
        didSet {
            let title: String
            let color: UIColor
            switch cellType {
            case .closed:
                title = "🔒"
                color = .white
                
            case .flagged:
                title = "🚩"
                color = .white
                
            case .label(let value):
                title = "\(value)"
                color = UIColor(white: 0.85, alpha: 1)
                label.textColor = colorForValue(value)
                
            case .bomb:
                title = "💣"
                color = .red
                
            case .empty:
                title = ""
                color = UIColor(white: 0.85, alpha: 1)
            }
            label.text = title
            tileColor = color
        }
    }
    
    var tileColor: UIColor = .white {
        didSet {
            tileLayer.fillColor = tileColor.cgColor
        }
    }
    
    
    init(point: Point) {
        self.point = point
        
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        layer.addSublayer(tileLayer)
        
        addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.leftAnchor.constraint(equalTo: leftAnchor),
            label.rightAnchor.constraint(equalTo: rightAnchor)
        ])
        
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let offset: CGFloat = 2
        let rect = CGRect(x: offset,
                          y: offset,
                          width: bounds.width - offset * 2,
                          height: bounds.height - offset * 2)
        tileLayer.path = UIBezierPath(roundedRect: rect, cornerRadius: 5).cgPath
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func colorForValue(_ value: Int) -> UIColor {
        switch value {
        case 1:
            return .blue
        case 2:
            return UIColor(red: 0,
                           green: 124/255,
                           blue: 21/255,
                           alpha: 1)
        case 3:
            return .red
            
        case 4:
            return UIColor(red: 15/255,
                           green: 0,
                           blue: 120/255,
                           alpha: 1)
            
        default:
            return .black
        }
    }
}
