//
//  MultiVC.swift
//  testJSON
//
//  Created by Narongsak_O on 10/10/18.
//  Copyright © 2018 nProject. All rights reserved.
//

import UIKit
import Charts

class MultiVC: UIViewController {
    
    @IBOutlet weak var lineChartV: LineChartView!
    
    var item = [String]()
    var lineOne = [Double]()
    var lineTwo = [Double]()
    var lineX = [Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMultiChart(name: item, vaule: lineOne, vauleT: lineTwo, vauleX: lineX)
        // Do any additional setup after loading the view.
    }
    
    //MARK: - setup Multi Line Chart
    func setUpMultiChart(name:[String],vaule:[Double],vauleT:[Double],vauleX:[Double]){
        
        lineChartV.dragEnabled = true
        lineChartV.setScaleEnabled(true)
        lineChartV.drawGridBackgroundEnabled = false
        lineChartV.pinchZoomEnabled = true
        lineChartV.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        lineChartV.borderColor = NSUIColor.white
        lineChartV.borderLineWidth = 1.0
        lineChartV.drawBordersEnabled = true
        
        //Mark: - xAxis
        
        let xAxis = lineChartV.xAxis
        xAxis.labelFont = NSUIFont.systemFont(ofSize: CGFloat(12.0))
        xAxis.labelTextColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        xAxis.drawGridLinesEnabled = true
        xAxis.drawAxisLineEnabled = true
        xAxis.labelPosition = .bottom
        xAxis.labelRotationAngle = 0
        xAxis.axisMinimum = 0
        
        lineChartV.chartDescription?.enabled = false
        
        var yVals1 = [ChartDataEntry]()
        var yVals2 = [ChartDataEntry]()
        var yVals3 = [ChartDataEntry]()
        
        for i in 0..<name.count {
            let val = vaule[i]
            yVals1.append(ChartDataEntry(x: Double(i), y: val))
        }
        
        for i in 0..<name.count  {
            let val = vauleT[i]
            yVals2.append(ChartDataEntry(x: Double(i), y: val))
        }
        
        for i in 0..<name.count  {
            let val = vauleX[i]
            yVals3.append(ChartDataEntry(x: Double(i), y: val))
        }
        
        var set1 = LineChartDataSet()
        var set2 = LineChartDataSet()
        var set3 = LineChartDataSet()
        
        set1 = LineChartDataSet(values: yVals1, label: "Income")
        set1.axisDependency = .left
        set1.colors = [#colorLiteral(red: 0.215686274509804, green: 0.709803921568627, blue: 0.898039215686275, alpha: 1.0)]
        set1.circleColors = [NSUIColor.purple]
        set1.lineWidth = 2.0
        set1.circleRadius = 3.0
        set1.fillAlpha = 65 / 255.0
        set1.fillColor = #colorLiteral(red: 0.215686274509804, green: 0.709803921568627, blue: 0.898039215686275, alpha: 1.0)
        set1.highlightColor = NSUIColor.green
        set1.highlightEnabled = true
        set1.drawCircleHoleEnabled = true
        
        
        set2 = LineChartDataSet(values: yVals2, label: "Payment")
        set2.axisDependency = .right
        set2.colors = [NSUIColor.red]
        set2.circleColors = [NSUIColor.orange]
        set2.lineWidth = 2.0
        set2.circleRadius = 3.0
        set2.fillAlpha = 65 / 255.0
        set2.fillColor = NSUIColor.red
        set2.highlightColor = NSUIColor.white
        set2.highlightEnabled = true
        set2.drawCircleHoleEnabled = true
        
        set3 = LineChartDataSet(values: yVals3, label: "gap")
        set3.axisDependency = .right
        set3.colors = [NSUIColor.green]
        set3.circleColors = [NSUIColor.white]
        set3.lineWidth = 2.0
        set3.circleRadius = 3.0
        set3.fillAlpha = 65 / 255.0
        set3.fillColor = NSUIColor.green
        set3.highlightColor = NSUIColor.yellow
        set3.highlightEnabled = true
        set3.drawCircleHoleEnabled = true
 
        //TODO: - append line
        var dataSets = [LineChartDataSet]()
        dataSets.append(set1)
        dataSets.append(set2)
        dataSets.append(set3)
        
        let data = LineChartData(dataSets: dataSets)
        data.setValueTextColor(#colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1))
        data.setValueFont(NSUIFont(name: "HelveticaNeue-Light", size: CGFloat(9.0)))
        lineChartV.data = data
        

        
//        lineChartV.data?.notifyDataChanged()
//        lineChartV.notifyDataSetChanged()
        
        //TODO: - animate Chart
        
        lineChartV.animate(xAxisDuration: 2, easingOption: .easeInBounce)
        lineChartV.animate(yAxisDuration: 2, easingOption: .easeInBounce)
        
    }
    

}
