//
//  ViewController.swift
//  RadarChartView
//
//  Created by furuyan on 08/18/2017.
//  Copyright (c) 2017 furuyan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy var showChartButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Show Chart", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(showChart), for: .touchUpInside)
        return btn
    }()
    
    lazy var showChartOnTableViewButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Show Chart on TableView", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(showChartOnTableView), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        showChartButton.frame.size = CGSize(width: 300, height: 30)
        showChartButton.center = view.center
        showChartOnTableViewButton.frame.size = CGSize(width: 300, height: 30)
        showChartOnTableViewButton.center = CGPoint(x: view.center.x, y: view.center.y + 50)
        view.addSubview(showChartButton)
        view.addSubview(showChartOnTableViewButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func showChart() {
        navigationController?.pushViewController(RadarChartViewController(), animated: true)
    }
    
    func showChartOnTableView() {
        navigationController?.pushViewController(RadarChartViewController2(), animated: true)
    }
}

