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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        showChartButton.frame.size = CGSize(width: 200, height: 30)
        showChartButton.center = view.center
        view.addSubview(showChartButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func showChart() {
        navigationController?.pushViewController(RadarChartViewController(), animated: true)
    }
}

