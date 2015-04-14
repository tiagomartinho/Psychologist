import UIKit

class HappinessViewController: UIViewController
{
    let verySad: Int = 0
    let ecstatic: Int = 100
    var happiness: Int = 25 {
        didSet {
            happiness = min(max(happiness, verySad), ecstatic)
        }
    }
    
}

