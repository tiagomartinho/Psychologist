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
        bezierPathForEye().stroke()
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
    
    private func bezierPathForEye() -> UIBezierPath
    {
        let eyeRadius = faceRadius / 10
        let eyeVerticalOffset = faceRadius / 3
        let eyeHorizontalSeparation = faceRadius / 1.5
        
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
}
