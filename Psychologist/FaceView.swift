//
//  FaceView.swift
//  Psychologist
//
//  Created by Martinho on 13/04/15.
//  Copyright (c) 2015 Martinho. All rights reserved.
//

import UIKit

class FaceView: UIView {

    var faceCenter: CGPoint {
        return convertPoint(center, fromView: superview)
    }
    
    var faceRadius: CGFloat {
        return min(bounds.size.width, bounds.size.height) / 2 * scale
    }
    
    var scale: CGFloat = 0.90

    override func drawRect(rect: CGRect)
    {
        setStrokeColor()
        bezierPathForFace().stroke()
        bezierPathForLeftEye().stroke()
        bezierPathForRightEye().stroke()
    }

    private func setStrokeColor()
    {
        let color: UIColor = UIColor.blueColor()
        color.set()
    }
    
    private func bezierPathForFace() -> UIBezierPath
    {
        let facePath = UIBezierPath(
            arcCenter: faceCenter,
            radius: faceRadius,
            startAngle: 0,
            endAngle: CGFloat(2*M_PI),
            clockwise: true
        )
        facePath.lineWidth = 3
        return facePath
    }
    
    private func bezierPathForLeftEye() -> UIBezierPath
    {
        let eyeRadius = faceRadius / Scaling.FaceRadiusToEyeRadiusRatio
        let eyeVerticalOffset = faceRadius / Scaling.FaceRadiusToEyeOffsetRatio
        let eyeHorizontalSeparation = faceRadius / Scaling.FaceRadiusToEyeSeparationRatio
        
        var eyeCenter = faceCenter
        eyeCenter.y -= eyeVerticalOffset
        eyeCenter.x -= eyeHorizontalSeparation / 2
        
        let path = UIBezierPath(
            arcCenter: eyeCenter,
            radius: eyeRadius,
            startAngle: 0,
            endAngle: CGFloat(2*M_PI),
            clockwise: true
        )
        path.lineWidth = 3
        return path
    }
    
    private func bezierPathForRightEye() -> UIBezierPath
    {
        let eyeRadius = faceRadius / Scaling.FaceRadiusToEyeRadiusRatio
        let eyeVerticalOffset = faceRadius / Scaling.FaceRadiusToEyeOffsetRatio
        let eyeHorizontalSeparation = faceRadius / Scaling.FaceRadiusToEyeSeparationRatio
        
        var eyeCenter = faceCenter
        eyeCenter.y -= eyeVerticalOffset
        eyeCenter.x += eyeHorizontalSeparation / 2
        
        let path = UIBezierPath(
            arcCenter: eyeCenter,
            radius: eyeRadius,
            startAngle: 0,
            endAngle: CGFloat(2*M_PI),
            clockwise: true
        )
        path.lineWidth = 3
        return path
    }
    
    private struct Scaling {
        static let FaceRadiusToEyeRadiusRatio: CGFloat = 10
        static let FaceRadiusToEyeOffsetRatio: CGFloat = 3
        static let FaceRadiusToEyeSeparationRatio: CGFloat = 1.5
    }
}
