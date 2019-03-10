import Foundation
import CoreGraphics

struct TelegraphicsModel {
    typealias Key = Int
    typealias Value = Int
    typealias Dataset = [(key: Key, value: Value)]
    
    let values: Dataset
    let color: CGColor
    
    init(values: Dataset, color: CGColor) {
        self.values = values
        self.color = color
    }
}
