# RadarChartView

[![Version](https://img.shields.io/cocoapods/v/RadarChartView.svg?style=flat)](http://cocoapods.org/pods/RadarChartView)
[![License](https://img.shields.io/cocoapods/l/RadarChartView.svg?style=flat)](http://cocoapods.org/pods/RadarChartView)
[![Platform](https://img.shields.io/cocoapods/p/RadarChartView.svg?style=flat)](http://cocoapods.org/pods/RadarChartView)

![movie](https://user-images.githubusercontent.com/6193319/29426495-c757f76a-83c1-11e7-9e83-f1dd98e152c0.gif)

## Usage

```swift
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
        
let chartView = RadarChartView()
chartView.dataSets = [dataSet, dataSet2]
chartView.titles = ["Apple", "Beef", "Cheese", "Donuts", "Egg", "Fig"]
chartView.webTitles = ["20", "40", "60", "80", "100"]
chartView.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: view.frame.width)

view.addSubview(chartView)
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
- iOS 9.0+
- Swift 3.1

## Installation

RadarChartView is available through [CocoaPods](http://cocoapods.org) or [Carthage](https://github.com/Carthage/Carthage).

### CocoaPods

```ruby
pod "RadarChartView"
```

### Carthage

```
github "furuyan/RadarChartView"
```

## Author

furuyan, kfuruyan@gmail.com

## License

RadarChartView is available under the MIT license. See the LICENSE file for more info.
