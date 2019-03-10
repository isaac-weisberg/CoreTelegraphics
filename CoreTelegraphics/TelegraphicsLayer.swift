import UIKit
import HalfFive

class TelegraphicsLayer: CALayer {
    override init() {
        super.init()
        boundsContainer = .init(value: bounds)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        boundsContainer = .init(value: bounds)
        setup()
    }
    
    let trashBag = TrashBag()
    
    let lines = Container<[([CGPoint], CGColor)], SchedulingMain>(value: [])
    
    var boundsContainer: Container<CGRect, SchedulingMain>!
    
    override var bounds: CGRect {
        didSet {
            boundsContainer.fire(event: bounds)
        }
    }
}

private extension TelegraphicsLayer {
    func setup() {
        lines
            .withLatest(from: boundsContainer) { (lines: $0, bounds: $1) }
            .map { stuff in
                stuff.lines.map { line -> CAShapeLayer in
                    let points = line.0
                        .map { clamped -> CGPoint in
                            #if DEBUG
                            clamped.assertBothInRange(0.0...1.0)
                            #endif
                            return CGPoint(x: stuff.bounds.width * clamped.x, y: stuff.bounds.height * clamped.y)
                    }
                    return shapeLayerWithLine(at: points, strokeColor: line.1)
                }
            }
            .run {[unowned self] layers in
                layers.forEach {
                    $0.frame = self.bounds
                    $0.setNeedsDisplay()
                }
                self.sublayers = layers
            }
            .disposed(by: trashBag)
        
    }

}

private func shapeLayerWithLine(at points: [CGPoint], strokeColor: CGColor) -> CAShapeLayer {
    let shapeLayer = CAShapeLayer()
    shapeLayer.fillColor = UIColor.clear.cgColor
    shapeLayer.strokeColor = strokeColor
    let path = CGMutablePath()
    if let first = points.first {
        path.move(to: first)
        var pointsCopy = points
        pointsCopy.removeFirst()
        pointsCopy
            .forEach {
                path.addLine(to: $0)
        }
    }
    
    shapeLayer.path = path
    return shapeLayer
}
