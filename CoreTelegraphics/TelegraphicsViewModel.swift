import HalfFive

protocol TelegraphicsViewModel {
    var visibleValues: Container<TelegraphicsModel, SchedulingMain> { get }
}

class TelegraphicsViewModelImpl {
    init(model: TelegraphicsModel) {
        visibleValues = .init(value: model)
    }
    
    let visibleValues: Container<TelegraphicsModel, SchedulingMain>
}

extension TelegraphicsViewModelImpl: TelegraphicsViewModel {
    
}
