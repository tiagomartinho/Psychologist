import UIKit

class HappinessViewController: UIViewController, FaceViewDataSource
{
    let verySad: Int = 0
    let ecstatic: Int = 100
    var happiness: Int = 25 {
        didSet {
            happiness = min(max(happiness, verySad), ecstatic)
        }
    }
    
    let frown: Double = -1.0
    let smile: Double = +1.0
    var m:Double { return (frown-smile)/Double(ecstatic-verySad) }
    var b:Double { return frown - Double(verySad) * m}
    func smilinessForFaceView(sender: FaceView) -> Double? {
        return m*Double(happiness)+b
    }
    
    @IBOutlet var faceView: FaceView! {
        didSet{
            faceView.dataSource = self
        }
    }
}