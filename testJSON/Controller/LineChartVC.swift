//
//  LineChartVC.swift
//  testJSON
//
//  Created by Narongsak_O on 10/10/18.
//  Copyright © 2018 nProject. All rights reserved.
//

import UIKit
import Charts

class LineChartVC: UIViewController {

    @IBOutlet weak var linChart: LineChartView!
    
    var item = [String]()
    var test = [Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLineChart(name: item, vaule: test )
        // Do any additional setup after loading the view.
    }
    
    //MARK: - setUp Line Chart
    
    func setLineChart(name:[String],vaule:[Double]){
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = Locale.current
        let valuesNumberFormatter = ChartValueFormatter(numberFormatter: numberFormatter)
        
        var lineArray:[ChartDataEntry] = []
        for i in 0..<name.count {
            let data:ChartDataEntry = ChartDataEntry(x: Double(i),y:vaule[i])
            lineArray.append(data)
        }
        let linedataset:LineChartDataSet = LineChartDataSet(values: lineArray, label: "test")
                linedataset.valueFormatter = valuesNumberFormatter
                linedataset.valueFont = linedataset.valueFont.withSize(CGFloat(9.0))
        linedataset.setColor(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
        
        
        
        let linedata:LineChartData = LineChartData(dataSet: linedataset)
        linChart.data = linedata
        linChart.animate(xAxisDuration: 2, easingOption: .easeInBounce)
        linChart.animate(yAxisDuration: 2, easingOption: .easeInBounce)
    }
    
}

//MARK: - format Number

class ChartValueFormatter: NSObject, IValueFormatter {
    fileprivate var numberFormatter: NumberFormatter?
    
    convenience init(numberFormatter: NumberFormatter) {
        self.init()
        self.numberFormatter = numberFormatter
    }
    
    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        guard let numberFormatter = numberFormatter
            else {
                return ""
        }
        return numberFormatter.string(for: value)!
    }
}
