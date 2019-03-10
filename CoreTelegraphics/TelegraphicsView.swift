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
            .map { dataset in
                dataset.map { newModel -> ([CGPoint], CGColor) in
                    guard let maxValue = newModel.values.map( { $0.value } ).max(by: <) else {
                        return ([], newModel.color)
                    }
                    
                    let horizontalCount = newModel.values.count
                    let normalizedPoints = newModel.values
                        .enumerated()
                        .map { stuff in
                            return CGPoint(
                                x: CGFloat(stuff.offset) / CGFloat(horizontalCount),
                                y: CGFloat(stuff.element.value) / CGFloat(maxValue))
                    }
                    return (normalizedPoints, newModel.color)
                }
            }
            .run(silo: telegraphicsLayer.lines)
            .disposed(by: trashBag)
        
        telegraphicsLayer.frame = bounds
        
        
//        viewModel.visibleValues
//            .run {[unowned self] newModel in
//                guard let maxValue = newModel.values.map( { $0.value } ).max(by: >) else {
//                    return
//                }
//                let sectors = 5
//                let step = CGFloat(maxValue) / CGFloat(sectors)
//                let sectorsRange: ClosedRange<Int> = 0...(sectors + 1)
//                let sectorValues: [CGFloat] = sectorsRange.map { CGFloat($0) * step }
//                
//                let horizontalCount = newModel.values.count
//                let normalizedPoints = newModel.values.enumerated()
//                    .map { stuff in
//                        return CGPoint(
//                            x: CGFloat(stuff.offset) / CGFloat(horizontalCount),
//                            y: CGFloat(stuff.element.value) / CGFloat(maxValue))
//                    }
//            }
//            .disposed(by: trashBag)
    }
}

private extension TelegraphicsView {
    func setup() {
        telegraphicsLayer.frame = bounds
        telegraphicsLayer.setNeedsDisplay()
        layer.addSublayer(telegraphicsLayer)
    }
}
