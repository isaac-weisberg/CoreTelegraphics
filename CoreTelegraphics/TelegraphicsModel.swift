import Foundation

struct TelegraphicsModel {
    typealias Key = Date
    typealias Value = Int
    typealias Dataset = [(key: Key, value: Value)]
    
    let values: Dataset
    
    init(values: Dataset) {
        self.values = values
            .sorted { prev, next in
                prev.key > next.key
            }
    }
}
