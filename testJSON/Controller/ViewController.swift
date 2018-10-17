//
//  ViewController.swift
//  testJSON
//
//  Created by Narongsak_O on 8/10/18.
//  Copyright © 2018 nProject. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    
    final let url = URL(string:"http://alpha.mtkserver.com/_get_title_shop/gold_month/09/2018")
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var MChart: LineChartView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var totalTxt: UILabel!
    
    var gold = [Gold]()
    
    var dataEntries: [ChartDataEntry] = []
    
    var currentGold = [Gold]()
    
    var countArray:[String] = []
    var Date:[String] = []
    var countChart:[Double] = []
    var sumCount:Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadJson()
        
        tableView.delegate = self
        tableView.dataSource = self
        setUpSearchBar()
        
        

    }
    
    //MARK: - network load dara from JSON
    
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
                
                self.gold = actors.reversed()
                self.currentGold = actors.reversed()
//                let testG = self.currentGold.f
                // TODO: - Array Map
                
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
    
    //MARK: - setup TableView
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentGold.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DateCell") as? DateCell else { return UITableViewCell() }
        
        //TODO: - Numbers format
        let price = Double(currentGold[indexPath.row].count)
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let formatCount = formatter.string(for: price)
        
        //TODO: - Date format
//        let dt = currentGold[indexPath.row].date
        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
//        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
//        let date = dateFormatter.date(from: dt)!
//
//        let calendar = Calendar.current
//        let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
//        let finalDate = calendar.date(from:components)
//        print(finalDate)
        
//        print(formatCount as Any)
        cell.countTxt.text = formatCount
        cell.dateTxt.text = currentGold[indexPath.row].date
        
        return cell
    }
    
    //TODO: - total label txt
    
    func getTotal(){
        
        let su = sumCount
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let sumC = formatter.string(for: su )
        
        totalTxt.text = sumC
    }
    
    //MARK: - BTN VC segue to Chart Line VC
    
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
    //MARK: - Searchbar 
    
    func setUpSearchBar(){
        searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            currentGold = gold
            tableView.reloadData()
            return }
        currentGold = gold.filter({ (test) -> Bool in
            return   test.date.lowercased().contains(searchText)
        })
        tableView.reloadData()
    }

}

//MARK: - Format Number



