//
//  FaceView.swift
//  Psychologist
//
//  Created by Martinho on 13/04/15.
//  Copyright (c) 2015 Martinho. All rights reserved.
//

import UIKit

class FaceView: UIView {
    
    override func drawRect(rect: CGRect)
    {
        setStrokeColor()
        bezierPathForFace().stroke()
        bezierPathForLeftEye().stroke()
        bezierPathForRightEye().stroke()
        bezierPathForSmile().stroke()
    }
    
    private func setStrokeColor()
    {
        let color: UIColor = UIColor.blueColor()
        color.set()
    }
    
    private func bezierPathForFace() -> UIBezierPath
    {
        return bezierPathCenteredIn(faceCenter,withRadius: faceRadius)
    }
    
    private func bezierPathForLeftEye() -> UIBezierPath
    {
        return bezierPathCenteredIn(leftEyeCenter,withRadius: eyeRadius)
    }
    
    private func bezierPathForRightEye() -> UIBezierPath
    {
        return bezierPathCenteredIn(rigthEyeCenter,withRadius: eyeRadius)
    }
    
    private func bezierPathForSmile() -> UIBezierPath
    {
        let mouthWidth = faceRadius / Scaling.FaceRadiusToMouthWidthRatio
        let mouthHeight = faceRadius / Scaling.FaceRadiusToMouthHeightRatio
        let mouthVerticalOffset = faceRadius / Scaling.FaceRadiusToMouthOffsetRatio
        
        let smileHeight = CGFloat(max(min(0.5, 1), -1)) * mouthHeight
        
        let start = CGPoint(x: faceCenter.x - mouthWidth / 2, y: faceCenter.y + mouthVerticalOffset)
        let end = CGPoint(x: start.x + mouthWidth, y: start.y)
        let cp1 = CGPoint(x: start.x + mouthWidth / 3, y: start.y + smileHeight)
        let cp2 = CGPoint(x: end.x - mouthWidth / 3, y: cp1.y)
        
        let path = UIBezierPath()
        path.moveToPoint(start)
        path.addCurveToPoint(end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = 3
        return path
    }
    
    private func bezierPathCenteredIn(center: CGPoint, withRadius: CGFloat) -> UIBezierPath{
        let path = UIBezierPath(
            arcCenter: center,
            radius: withRadius,
            startAngle: 0,
            endAngle: CGFloat(2*M_PI),
            clockwise: true
        )
        path.lineWidth = 3
        return path
    }
    
    var faceCenter: CGPoint {
        return convertPoint(center, fromView: superview)
    }
    
    var faceRadius: CGFloat {
        return min(bounds.size.width, bounds.size.height) / 2 * scale
    }
    
    var scale: CGFloat = 0.90
    
    var eyeRadius: CGFloat {
        return faceRadius / Scaling.FaceRadiusToEyeRadiusRatio
    }
    var eyeVerticalOffset: CGFloat {
        return faceRadius / Scaling.FaceRadiusToEyeOffsetRatio
    }
    var eyeHorizontalSeparation: CGFloat {
        return faceRadius / Scaling.FaceRadiusToEyeSeparationRatio
    }
    var leftEyeCenter: CGPoint {
        var eyeCenter=faceCenter
        eyeCenter.y -= eyeVerticalOffset
        eyeCenter.x -= eyeHorizontalSeparation / 2
        return eyeCenter
    }
    var rigthEyeCenter: CGPoint {
        var eyeCenter=faceCenter
        eyeCenter.y -= eyeVerticalOffset
        eyeCenter.x += eyeHorizontalSeparation / 2
        return eyeCenter
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
