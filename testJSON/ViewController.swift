//
//  ViewController.swift
//  testJSON
//
//  Created by Narongsak_O on 8/10/18.
//  Copyright © 2018 nProject. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    final let url = URL(string:"http://alpha.mtkserver.com/_get_title_shop/gold_month/09/2018")
    
    @IBOutlet weak var MChart: LineChartView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var totalTxt: UILabel!
    
    var gold = [Gold]()
    
    var dataEntries: [ChartDataEntry] = []
    
    
    var countArray:[String] = []
    var Date:[String] = []
    var countChart:[Double] = []
    var sumCount:Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadJson()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func downloadJson(){
        guard let downloadURL = url else {  return }
        URLSession.shared.dataTask(with: downloadURL) { (data, urlResponse, error) in
            
            guard let data = data, error == nil, urlResponse != nil else {
                print("Something wrong")
                return
            }
            print("downloaded")
//            print(data)
            do{
                let decoder = JSONDecoder()
                let actors = try decoder.decode([Gold].self, from: data)
            
                print(actors[0].count)
                
                self.gold = actors
                // TODO: - Array
                for i in actors {
                    self.countArray.append(i.count)
                    self.Date.append(i.date)
                }
                self.countChart = self.countArray.map { Double($0)!}
                
                for num in self.countChart {
                    self.sumCount += num
                }
                
                print(self.countArray)
                print(self.Date)
                print(self.countChart)
                print(self.sumCount)
                
                self.getTotal()
//
//                self.setChart(values: self.countChart)
                self.tableView.reloadData()
                
                
            } catch {
                print("something wrong after downloaded")
            }
        }.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gold.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DateCell") as? DateCell else { return UITableViewCell() }
        
        cell.countTxt.text = gold[indexPath.row].count
        cell.dateTxt.text = gold[indexPath.row].date
        
        return cell
    }
    
    //TODO: - total label txt
    func getTotal(){
        totalTxt.text = String(sumCount)
    }

    //MARK: - Chart Setup View
//    func setChart(values: [Double]){
//        MChart.noDataText = "No data available!"
//        for i in 0..<values.count {
//            print("chart point : \(values[i])")
//            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
//            dataEntries.append(dataEntry)
//        }
//        let line1 = LineChartDataSet(values: dataEntries, label: "Units Consumed")
//        line1.colors = [NSUIColor.blue]
//        line1.mode = .cubicBezier
//        line1.cubicIntensity = 0.2
//
//        let gredient = getGredientFilling()
//        line1.fill = Fill.fillWithLinearGradient(gredient, angle: 90.0)
//        line1.drawFilledEnabled = true
//
//        let data = LineChartData()
//        data.addDataSet(line1)
//        MChart.data = data
//        MChart.setScaleEnabled(false)
//        MChart.animate(xAxisDuration: 1.5)
//        MChart.drawGridBackgroundEnabled = false
//        MChart.xAxis.drawAxisLineEnabled = false
//        MChart.xAxis.drawGridLinesEnabled = false
//        MChart.leftAxis.drawAxisLineEnabled = false
//        MChart.leftAxis.drawGridLinesEnabled = false
//        MChart.rightAxis.drawAxisLineEnabled = false
//        MChart.rightAxis.drawGridLinesEnabled = false
//        MChart.legend.enabled = false
//        MChart.xAxis.enabled = false
//        MChart.leftAxis.enabled = false
//        MChart.rightAxis.enabled = false
//        MChart.xAxis.drawLabelsEnabled = false
//
//    }
//
//    private func getGredientFilling() -> CGGradient {
//        //TODO: - Setting fill gradien color
//
//        let coloTop = UIColor(red: 141/255, green: 133/255, blue: 220/255, alpha: 1).cgColor
//        let coloBot = UIColor(red: 230/255, green: 155/255, blue: 210/255, alpha: 1).cgColor
//
//        //TODO: - Color of gradient
//
//        let gradientColors = [ coloTop,coloBot] as CFArray
//
//        //TODO: - Positioning of the gradient
//
//        let colorLocations: [CGFloat] = [ 0.7, 0.0 ]
//
//        //TODO: - Gredient bject
//
//        return CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations)!
//    }


}

