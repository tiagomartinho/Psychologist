import UIKit

class DiagnosedHappinessViewController : HappinessViewController,UIPopoverPresentationControllerDelegate
{
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.None
    }
}