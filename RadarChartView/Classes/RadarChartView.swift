//
//  RadarChartView.swift
//  RadarChartView
//
//  Created by furuyan on 2017/08/18.
//  Copyright (c) 2017 furuyan. All rights reserved.
//

import UIKit
import CoreGraphics

public class RadarChartView: UIView {
    // MARK: display settings
    public var webCount = 5
    public var webColor = UIColor.black
    public var minValue = CGFloat(0.0)
    public var maxValue = CGFloat(100.0)
    public var verticalChartInset = CGFloat(40.0)
    public var horizontalChartInset = CGFloat(50.0)
    public var titleAttributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12),
                           NSAttributedStringKey.foregroundColor: UIColor.black]
    public var webTitleAttributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12),
                              NSAttributedStringKey.foregroundColor: UIColor.black]
    
    // MARK: display datas
    public var titles = [String]()
    public var webTitles = [String]()
    public var dataSets = [ChartDataSet]() {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // MARK: animation settings
    public var animationDuration = 0.3
    public var animationDelay = 0.5
    public var isAnimationEnabled = true
    
    // MARK: private
    private var radius = CGFloat(100.0)
    
    public init() {
        super.init(frame: .zero)
        backgroundColor = .white
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let maxWidth = rect.width - horizontalChartInset * 2.0
        let maxHeight = rect.height - verticalChartInset * 2.0
        let diameter = min(maxWidth, maxHeight)
        radius = diameter / 2.0
        
        drawWeb(rect)
        drawTitle(rect)
        drawWebTitle(rect)
        drawData(rect)
    }
    
    private func drawWeb(_ rect: CGRect) {
        guard webCount != 0 else { return }
        
        webColor.setStroke()
        let center = CGPoint(x: bounds.width / 2.0, y: bounds.height / 2.0)

        var outerPaths = [UIBezierPath]()
        (0..<webCount).forEach { _ in
            outerPaths.append(UIBezierPath())
        }
        
        for i in 0..<titles.count {
            let angle = CGFloat(2.0 * Double.pi) * CGFloat(i) / CGFloat(titles.count)
            let verticalPath = UIBezierPath()
            verticalPath.move(to: center)
            
            var point = center
            point.x = center.x + radius * sin(angle)
            point.y = center.y - (radius * cos(angle))
            verticalPath.addLine(to: point)
            verticalPath.stroke()
            
            for j in 0..<webCount {
                let outerPath = outerPaths[j]
                let innerRadius = radius / CGFloat(webCount) * CGFloat(j + 1)
                
                point.x = center.x + innerRadius * sin(angle)
                point.y = center.y - (innerRadius * cos(angle))
                
                if i == 0 {
                    outerPath.move(to: point)
                } else {
                    outerPath.addLine(to: point)
                }
                
                if i == titles.count - 1 {
                    outerPath.close()
                    outerPath.stroke()
                }
            }
        }
    }
    
    private func drawTitle(_ rect: CGRect) {
        let center = CGPoint(x: bounds.width / 2.0, y: bounds.height / 2.0)
        for (i, title) in titles.enumerated() {
            guard !title.isEmpty else {
                continue
            }
            
            let labelDrawRadius: CGFloat
            if rect.width > rect.height {
                labelDrawRadius = radius + (verticalChartInset / 2.0)
            } else {
                labelDrawRadius = radius + (horizontalChartInset / 2.0)
            }
            
            let angle = CGFloat(2.0 * Double.pi) * CGFloat(i) / CGFloat(titles.count)
            var point = center
            point.x = center.x + labelDrawRadius * sin(angle)
            point.y = center.y - (labelDrawRadius * cos(angle))
            
            let drawString = NSString(string: title)
            let stringSize = drawString.size(withAttributes: titleAttributes)
            
            let drawRect = CGRect(x: point.x - stringSize.width / 2.0,
                                  y: point.y - stringSize.height / 2.0,
                                  width: stringSize.width,
                                  height: stringSize.height)
            drawString.draw(in: drawRect, withAttributes: titleAttributes)
        }
    }
    
    private func drawWebTitle(_ rect: CGRect) {
        guard webCount != 0 else { return }
        
        let center = CGPoint(x: bounds.width / 2.0, y: bounds.height / 2.0)
        
        for i in 0..<webCount {
            let title: String
            if i < webTitles.count {
                title = webTitles[i]
            } else {
                title = ""
            }
            
            guard !title.isEmpty else {
                continue
            }
            
            let innerRadius = radius / CGFloat(webCount) * CGFloat(i + 1)
            
            var point = center
            point.y = center.y - innerRadius
            
            let drawString = NSString(string: title)
            let stringSize = drawString.size(withAttributes: webTitleAttributes)
            
            let drawRect = CGRect(x: point.x - stringSize.width - 3,
                                  y: point.y - stringSize.height,
                                  width: stringSize.width,
                                  height: stringSize.height)
            drawString.draw(in: drawRect, withAttributes: webTitleAttributes)
        }
    }
    
    private func drawData(_ rect: CGRect) {
        layer.sublayers?.filter { $0 is CAShapeLayer }.forEach { (layer) in
            layer.removeFromSuperlayer()
        }
        
        for dataSet in dataSets {
            drawSingleData(rect, dataSet: dataSet)
        }
        isAnimationEnabled = false
    }
    
    private func drawSingleData(_ rect: CGRect, dataSet: ChartDataSet) {
        let center = CGPoint(x: bounds.width / 2.0, y: bounds.height / 2.0)
        
        let dataLayer = CAShapeLayer()
        dataLayer.bounds = rect
        dataLayer.position = center
        dataLayer.strokeColor = dataSet.strokeColor.cgColor
        dataLayer.fillColor = dataSet.fillColor?.cgColor
        
        let path = UIBezierPath()
        for i in 0..<titles.count {
            let value: CGFloat
            if i < dataSet.entries.count {
                value = min(max(dataSet.entries[i].value, minValue), maxValue)
            } else {
                value = 0.0
            }
            
            let valueRadius = radius * value / (maxValue - minValue)
            let angle = CGFloat(2.0 * Double.pi) * CGFloat(i) / CGFloat(titles.count)
            var point = center
            point.x = center.x + valueRadius * sin(angle)
            point.y = center.y - (valueRadius * cos(angle))
            
            if i == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
            
            if i == titles.count - 1 {
                path.close()
            }
        }
        
        dataLayer.path = path.cgPath
        layer.addSublayer(dataLayer)
        
        if isAnimationEnabled {
            let beforePath = UIBezierPath(arcCenter: center, radius: 1, startAngle: 0, endAngle: CGFloat(2.0 * Double.pi), clockwise: true).cgPath
            dataLayer.path = beforePath
            let anim = CABasicAnimation(keyPath:"path")
            anim.beginTime = CACurrentMediaTime() + animationDelay
            anim.fromValue = beforePath
            anim.toValue = path.cgPath
            anim.duration = animationDuration
            anim.isRemovedOnCompletion = false
            anim.fillMode = kCAFillModeForwards
            dataLayer.add(anim, forKey: nil)
        }
    }
}
