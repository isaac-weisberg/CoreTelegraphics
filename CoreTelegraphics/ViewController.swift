import UIKit

class ViewController: UIViewController {
    @IBOutlet var telegraphicsView: TelegraphicsView!
    
    let viewModel = TelegraphicsViewModelImpl(models: [
        TelegraphicsModel(values: [
            (key: 0, value: 13),
            (key: 0, value: 90),
            (key: 0, value: 90),
            (key: 0, value: 22),
            (key: 0, value: 90),
            (key: 0, value: 50),
            (key: 0, value: 31)
        ], color: UIColor.red.cgColor)
    ])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        telegraphicsView.apply(viewModel: viewModel)
    }
}
