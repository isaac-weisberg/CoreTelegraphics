import CoreGraphics

extension CGPoint {
    func assertBothInRange(_ range: ClosedRange<CGFloat>) {
        assert(range.contains(x), "x should be in range")
        assert(range.contains(y), "y should be in range")
    }
}
