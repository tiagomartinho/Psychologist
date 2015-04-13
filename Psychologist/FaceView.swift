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
    
    var scale: CGFloat = 0.90 { didSet { setNeedsDisplay() } }

    override func drawRect(rect: CGRect)
    {
        let facePath = UIBezierPath(
            arcCenter: faceCenter,
            radius: faceRadius,
            startAngle: 0,
            endAngle: CGFloat(2*M_PI),
            clockwise: true
        )
        facePath.lineWidth=3
        
        let color: UIColor = UIColor.blueColor()
        color.set()
        
        facePath.stroke()
    }

}
