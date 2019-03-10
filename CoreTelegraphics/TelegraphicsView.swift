import UIKit
import HalfFive

class TelegraphicsView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    let telegraphicsLayer = TelegraphicsLayer()
    
    var trashBag = TrashBag()
    
    func apply(viewModel: TelegraphicsViewModel) {
        trashBag = TrashBag()
        
        viewModel.visibleValues
            .run {[unowned self] newModel in
                guard let maxValue = newModel.values.map( { $0.value } ).max(by: >) else {
                    return
                }
                let sectors = 5
                let step = CGFloat(maxValue) / CGFloat(sectors)
                let sectorsRange: ClosedRange<Int> = 0...(sectors + 1)
                let sectorValues: [CGFloat] = sectorsRange.map { CGFloat($0) * step }
                
            }
            .disposed(by: trashBag)
    }
}

private extension TelegraphicsView {
    func setup() {
        telegraphicsLayer.frame = bounds
        telegraphicsLayer.setNeedsDisplay()
        layer.addSublayer(telegraphicsLayer)
        
        telegraphicsLayer.lines.fire(event: [
            ([CGPoint(x: 0.27, y: 0.1), CGPoint(x: 0.26, y: 0.26), CGPoint(x: 0.72, y: 0.70), CGPoint(x: 0.26, y: 0.70)], UIColor.red.cgColor)
        ])
    }
}
