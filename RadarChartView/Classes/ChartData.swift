//
//  ChartData.swift
//  RadarChartView
//
//  Created by furuyan on 2017/08/18.
//  Copyright (c) 2017 furuyan. All rights reserved.
//

import UIKit

public struct ChartDataSet {
    public var strokeColor = UIColor.blue
    public var fillColor: UIColor? = UIColor(red: 0, green: 0, blue: 1, alpha: 0.5)
    public var entries = [ChartDataEntry]()
    
    public init() { }
}

public struct ChartDataEntry {
    public var value = CGFloat(0.0)
    public init(value: CGFloat) {
        self.value = value
    }
}
