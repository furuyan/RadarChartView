import UIKit
import RadarChartView

class RadarChartViewController: UIViewController {
    let chartView = RadarChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        
        var dataSet = ChartDataSet()
        dataSet.entries = [ChartDataEntry(value: 100),
                           ChartDataEntry(value: 70),
                           ChartDataEntry(value: 80),
                           ChartDataEntry(value: 40),
                           ChartDataEntry(value: 90),
                           ChartDataEntry(value: 30)]
        var dataSet2 = ChartDataSet()
        dataSet2.entries = [ChartDataEntry(value: 50),
                            ChartDataEntry(value: 50),
                            ChartDataEntry(value: 70),
                            ChartDataEntry(value: 90),
                            ChartDataEntry(value: 70),
                            ChartDataEntry(value: 100)]
        dataSet2.strokeColor = .red
        dataSet2.fillColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.5)
        chartView.dataSets = [dataSet, dataSet2]
        chartView.titles = ["Apple", "Beef", "Cheese", "Donuts", "Egg", "Fig"]
        chartView.webTitles = ["20", "40", "60", "80", "100"]
        chartView.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: view.frame.width)
        view.addSubview(chartView)
    }
}
