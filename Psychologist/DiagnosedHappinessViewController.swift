import UIKit

class DiagnosedHappinessViewController : HappinessViewController,UIPopoverPresentationControllerDelegate
{
    override var happiness: Int {
        didSet {
            diagnosticHistory += [happiness]
        }
    }
    
    var diagnosticHistory: [Int] {
        get { return defaults.objectForKey(DefaultsKey) as? [Int] ?? [] }
        set { defaults.setObject(newValue, forKey: DefaultsKey) }
    }
    
    private let defaults = NSUserDefaults.standardUserDefaults()
    private let DefaultsKey = "DiagnosedHappinessViewController.History"
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "Show Diagnostic History":
                if let tvc = segue.destinationViewController as? TextViewController {
                    if let ppc = tvc.popoverPresentationController {
                        ppc.delegate = self
                    }
                    tvc.text = "\(diagnosticHistory)"
                }
            default: break
            }
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
}