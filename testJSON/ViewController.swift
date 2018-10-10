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
//                self.setLineChart(name: self.Date, vaule: self.countChart )
                self.tableView.reloadData()
                
                
            } catch {
                print("something wrong after downloaded")
            }
        }.resume()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
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
    
    //MARK: - to chart Line
    
    @IBAction func toLineBtn(_ sender: UIButton) {
        performSegue(withIdentifier: "toLineChart", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toLineChart" {
            let secondVC = segue.destination as! LineChartVC
            
            secondVC.test = countChart
            secondVC.item = Date
            
        }
    }
    //    func setLineChart(name:[String],vaule:[Double]){
//        var lineArray:[ChartDataEntry] = []
//        for i in 0..<name.count {
//            let data:ChartDataEntry = ChartDataEntry(x: Double(i),y:vaule[i])
//            lineArray.append(data)
//        }
//        let linedataset:LineChartDataSet = LineChartDataSet(values: lineArray, label: "test")
//        linedataset.setColor(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
//
//        let linedata:LineChartData = LineChartData(dataSet: linedataset)
//        MChart.data = linedata
//        MChart.animate(xAxisDuration: 2, easingOption: .easeInBounce)
//        MChart.animate(yAxisDuration: 2, easingOption: .easeInBounce)
//    }



}

