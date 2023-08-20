//
//  CAShapeLayer+oval.swift
//  SWGauge
//
//  Created by Petr Korolev on 03/06/15.
//  Copyright (c) 2015 Petr Korolev. All rights reserved.
//

import UIKit

extension CAShapeLayer {

    static func getLine(_ lineWidth: CGFloat,
                       strokeStart: CGFloat,
                       strokeEnd: CGFloat,
                       strokeColor: UIColor,
                       fillColor: UIColor,
                       shadowRadius: CGFloat,
                       shadowOpacity: Float,
                       shadowOffsset: CGSize,
                       bounds: CGRect,
                       rotationAngle: CGFloat? = nil,
                       anchorPoint: CGPoint? = nil
    ) -> CAShapeLayer {

        var arc = CAShapeLayer()
        let path = CGMutablePath()
        let Y = bounds.midY
        path.move(to: CGPoint(x: lineWidth, y: Y))
        path.addLine(to: CGPoint(x: bounds.width - lineWidth, y: Y))

        arc.path = path

        arc = setupArc(arc, lineWidth: lineWidth,
                strokeStart: strokeStart,
                strokeEnd: strokeEnd,
                strokeColor: strokeColor,
                fillColor: fillColor,
                shadowRadius: shadowRadius,
                shadowOpacity: shadowOpacity,
                shadowOffsset: shadowOffsset,
                rotationAngle: rotationAngle,
                anchorPoint: anchorPoint)
        return arc
    }

    static func getOval(_ lineWidth: CGFloat,
                       strokeStart: CGFloat,
                       strokeEnd: CGFloat,
                       strokeColor: UIColor,
                       fillColor: UIColor,
                       shadowRadius: CGFloat,
                       shadowOpacity: Float,
                       shadowOffsset: CGSize,
                       bounds: CGRect,
                       rotationAngle: CGFloat? = nil,
                       anchorPoint: CGPoint? = nil,
                       isCircle: Bool = true

    ) -> CAShapeLayer {

        var arc = CAShapeLayer()
        let rect = bounds.insetBy(dx: lineWidth / 2, dy: lineWidth / 2)
        if isCircle {
            let arcDiameter = min(bounds.width, bounds.height) - lineWidth
            let X = bounds.midX
            let Y = bounds.midY
            arc.path = UIBezierPath(ovalIn: CGRect(x: X - (arcDiameter / 2), y: Y - (arcDiameter / 2), width: arcDiameter, height: arcDiameter)).cgPath
        } else {
            arc.path = UIBezierPath(ovalIn: rect).cgPath
        }


        arc = setupArc(arc, lineWidth: lineWidth,
                strokeStart: strokeStart,
                strokeEnd: strokeEnd,
                strokeColor: strokeColor,
                fillColor: fillColor,
                shadowRadius: shadowRadius,
                shadowOpacity: shadowOpacity,
                shadowOffsset: shadowOffsset,
                rotationAngle: rotationAngle,
                anchorPoint: anchorPoint)
        return arc
    }

    static func setupArc(_ arc: CAShapeLayer, lineWidth: CGFloat,
                         strokeStart: CGFloat,
                         strokeEnd: CGFloat,
                         strokeColor: UIColor,
                         fillColor: UIColor,
                         shadowRadius: CGFloat,
                         shadowOpacity: Float,
                         shadowOffsset: CGSize,
                         rotationAngle: CGFloat? = nil,
                         anchorPoint: CGPoint? = nil) -> CAShapeLayer {
        arc.lineWidth = lineWidth

        arc.strokeStart = strokeStart

        arc.strokeColor = strokeColor.cgColor
        arc.fillColor = fillColor.cgColor
        arc.shadowColor = UIColor.black.cgColor
        arc.shadowRadius = shadowRadius
        arc.shadowOpacity = shadowOpacity
        arc.shadowOffset = shadowOffsset

        if let anchorPoint {
            arc.anchorPoint = anchorPoint
        }
        if let rotationAngle {
            arc.transform = CATransform3DRotate(arc.transform, rotationAngle, 0, 0, 1)
        }

        arc.strokeEnd = strokeEnd
        return arc
    }
}
