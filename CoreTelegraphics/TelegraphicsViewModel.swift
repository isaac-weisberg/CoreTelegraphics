import HalfFive

protocol TelegraphicsViewModel {
    var visibleValues: Container<[TelegraphicsModel], SchedulingMain> { get }
}

class TelegraphicsViewModelImpl {
    init(models: [TelegraphicsModel]) {
        visibleValues = .init(value: models)
    }
    
    let visibleValues: Container<[TelegraphicsModel], SchedulingMain>
}

extension TelegraphicsViewModelImpl: TelegraphicsViewModel {
    
}
