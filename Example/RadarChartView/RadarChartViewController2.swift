//
//  RadarChartViewController2.swift
//  RadarChartView
//
//  Created by furuyan on 2017/08/24.
//  Copyright (c) 2017 furuyan. All rights reserved.
//

import UIKit
import RadarChartView

class RadarChartViewController2: UITableViewController {
    let cellHeight = CGFloat(300)
    
    // flags that has been displayed
    var hasBeenDisplayed = [IndexPath: Bool]()
    
    // cell's title
    let texts: [String] = ["First", "Second", "Third", "Fourth", "Fifth"]
    let dataSets: [[ChartDataSet]] = {
        var dataSets = [[ChartDataSet]]()
        for i in 0..<5 {
            var dataSet = ChartDataSet()
            for j in 0..<6 {
                let random = arc4random_uniform(100)
                dataSet.entries.append(ChartDataEntry(value: CGFloat(random)))
            }
            dataSets.append([dataSet])
        }
        return dataSets
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSets.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let labelWidth = CGFloat(60.0)
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! Cell
        cell.label.frame = CGRect(x: 0, y: 10, width: labelWidth, height: 20)
        cell.label.text = texts[indexPath.row]
        cell.chartView.frame = CGRect(x: labelWidth, y: 0, width: view.frame.width - labelWidth, height: cellHeight)
        cell.chartView.dataSets = dataSets[indexPath.row]
        
        // Perform animation when each cell is displayed on first time.
        if let flag = hasBeenDisplayed[indexPath], flag {
            cell.chartView.isAnimationEnabled = false
        } else {
            hasBeenDisplayed[indexPath] = true
            cell.chartView.isAnimationEnabled = true
        }

        return cell
    }
}

class Cell: UITableViewCell {
    let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()

    let chartView = RadarChartView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        chartView.titles = ["Apple", "Beef", "Cheese", "Donuts", "Egg", "Fig"]
        chartView.webTitles = ["20", "40", "60", "80", "100"]
        contentView.addSubview(chartView)
        contentView.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
