import UIKit

protocol FaceViewDataSource: class {
    func smilinessForFaceView(sender: FaceView) -> Double?
}

@IBDesignable
class FaceView: UIView {
    
    weak var dataSource: FaceViewDataSource?

    @IBInspectable
    var lineWidth: CGFloat = 3 { didSet { setNeedsDisplay() } }
    @IBInspectable
    var color: UIColor = UIColor.blueColor() { didSet { setNeedsDisplay() } }
    @IBInspectable
    var scale: CGFloat = 0.90 { didSet { setNeedsDisplay() } }
    
    override func drawRect(rect: CGRect)
    {
        let smiliness = dataSource?.smilinessForFaceView(self) ?? 0.0

        setStrokeColor()
        bezierPathForFace().stroke()
        bezierPathForLeftEye().stroke()
        bezierPathForRightEye().stroke()
        bezierPathForSmile(smiliness).stroke()
    }
    
    private func setStrokeColor()
    {
        color.set()
    }
    
    private func bezierPathForFace() -> UIBezierPath
    {
        return circularBezierPathCenteredIn(faceCenter,withRadius: faceRadius)
    }
    
    private func bezierPathForLeftEye() -> UIBezierPath
    {
        return circularBezierPathCenteredIn(leftEyeCenter,withRadius: eyeRadius)
    }
    
    private func bezierPathForRightEye() -> UIBezierPath
    {
        return circularBezierPathCenteredIn(rigthEyeCenter,withRadius: eyeRadius)
    }
    
    private func bezierPathForSmile(fractionOfMaxSmile: Double) -> UIBezierPath
    {
        let smileHeight = CGFloat(max(min(fractionOfMaxSmile, 1), -1)) * mouthHeight
        
        let start = CGPoint(x: faceCenter.x - mouthWidth / 2, y: faceCenter.y + mouthVerticalOffset)
        let end = CGPoint(x: start.x + mouthWidth, y: start.y)
        let cp1 = CGPoint(x: start.x + mouthWidth / 3, y: start.y + smileHeight)
        let cp2 = CGPoint(x: end.x - mouthWidth / 3, y: cp1.y)
        
        let path = UIBezierPath()
        path.moveToPoint(start)
        path.addCurveToPoint(end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = lineWidth
        return path
    }
    
    private func circularBezierPathCenteredIn(center: CGPoint, withRadius radius: CGFloat) -> UIBezierPath{
        let path = UIBezierPath(
            arcCenter: center,
            radius: radius,
            startAngle: 0,
            endAngle: CGFloat(2*M_PI),
            clockwise: true
        )
        path.lineWidth = lineWidth
        return path
    }
    
    private var faceCenter: CGPoint {
        return convertPoint(center, fromView: superview)
    }
    
    private var faceRadius: CGFloat {
        return min(bounds.size.width, bounds.size.height) / 2 * scale
    }
    
   private var eyeRadius: CGFloat {
        return faceRadius / Scaling.FaceRadiusToEyeRadiusRatio
    }
    
   private var eyeVerticalOffset: CGFloat {
        return faceRadius / Scaling.FaceRadiusToEyeOffsetRatio
    }
    
    private var eyeHorizontalSeparation: CGFloat {
        return faceRadius / Scaling.FaceRadiusToEyeSeparationRatio
    }
    
    private var leftEyeCenter: CGPoint {
        var eyeCenter=faceCenter
        eyeCenter.y -= eyeVerticalOffset
        eyeCenter.x -= eyeHorizontalSeparation / 2
        return eyeCenter
    }
    
    private var rigthEyeCenter: CGPoint {
        var eyeCenter=faceCenter
        eyeCenter.y -= eyeVerticalOffset
        eyeCenter.x += eyeHorizontalSeparation / 2
        return eyeCenter
    }
    
    private var mouthWidth:CGFloat {
        return faceRadius / Scaling.FaceRadiusToMouthWidthRatio
    }
    
    private var mouthHeight:CGFloat {
        return faceRadius / Scaling.FaceRadiusToMouthHeightRatio
    }
    
    private var mouthVerticalOffset:CGFloat {
        return faceRadius / Scaling.FaceRadiusToMouthOffsetRatio
    }
    
    private struct Scaling {
        static let FaceRadiusToEyeRadiusRatio: CGFloat = 10
        static let FaceRadiusToEyeOffsetRatio: CGFloat = 3
        static let FaceRadiusToEyeSeparationRatio: CGFloat = 1.5
        static let FaceRadiusToMouthWidthRatio: CGFloat = 1
        static let FaceRadiusToMouthHeightRatio: CGFloat = 3
        static let FaceRadiusToMouthOffsetRatio: CGFloat = 3
    }
}
