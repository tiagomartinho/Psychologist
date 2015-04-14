import UIKit

class HappinessViewController: UIViewController, FaceViewDataSource
{
    let verySad: Int = 0
    let ecstatic: Int = 100
    var happiness: Int = 50 {
        didSet {
            happiness = min(max(happiness, verySad), ecstatic)
            updateUI()
        }
    }
    
    func updateUI() {
        faceView.setNeedsDisplay()
    }
    
    let frown: Double = -1.0
    let smile: Double = +1.0
    var m:Double { return (frown-smile)/Double(verySad-ecstatic) }
    var b:Double { return frown - Double(verySad) * m}
    func smilinessForFaceView(sender: FaceView) -> Double? {
        return m*Double(happiness)+b
    }
    
    @IBOutlet var faceView: FaceView! {
        didSet{
            faceView.dataSource = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: "scale:"))
        }
    }
    
    @IBAction func changeHapiness(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .Ended: fallthrough
        case .Changed:
            let translation = gesture.translationInView(faceView)
            gesture.setTranslation(CGPointZero, inView: faceView)
            let happinessChange = -Int(translation.y / 4)
            if happinessChange != 0 {
                happiness += happinessChange
            }
        default: break
        }
    }
}