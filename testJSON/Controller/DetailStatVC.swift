//
//  DetailStatVC.swift
//  testJSON
//
//  Created by Narongsak_O on 9/10/18.
//  Copyright © 2018 nProject. All rights reserved.
//

import UIKit

class DetailStatVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    private struct Palette {
        static let red = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
    }

    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var totalIN: UILabel!
    
    @IBOutlet weak var totalOut: UILabel!
    
    @IBOutlet weak var gapTxt: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var nameP : String = ""
    var urlP : String = ""
    
    var stat = [Stat]()
    
    var totalInArray:[String] = []
    var totalOutArray:[String] = []
    var Date:[String] = []
    var balanceTotal:[Double] = []
    var revanue:[Double] = []
    var gapArray:[Double] = []
    var sumIn:Double = 0
    var sumOut:Double = 0
    var gapInOut:Double = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        name.text = nameP
        urlP = "https://office.mtkserver.com/result_account/\(nameP)/08/2018"
        downloadJson()
//        getTotal()
        // Do any additional setup after loading the view.
    }
    
    func downloadJson(){
        let url = URL(string:urlP)
        print(urlP)
        guard let downloadURL = url else { return }
        URLSession.shared.dataTask(with: downloadURL) { (data, urlResponse, error) in
            guard let data = data, error == nil, urlResponse != nil else {
                print("Something wrong")
                return }
            print("downloaded")
            //            print(data)
            do{
                let decoder = JSONDecoder()
                let actors = try decoder.decode([Stat].self, from: data)
                
                print(actors[0].m_in)
                
                self.stat = actors.reversed()
                // TODO: - Array
                for i in actors {
                    self.totalInArray.append(i.m_in)
                    self.Date.append(i.date)
                    self.totalOutArray.append(i.m_out)
                }
                self.balanceTotal = self.totalInArray.map { Double($0)!}                
                self.sumIn = self.balanceTotal.reduce(0, { ($0 + $1)})
                
                self.revanue = self.totalOutArray.map { Double($0)!}
                self.sumOut = self.revanue.reduce(0, { ($0 + $1)})

                
                for gap in self.balanceTotal {
                    for a in self.revanue{
                        self.gapArray.append(gap - a)
                    }
                }
                
                self.gapInOut = self.sumIn - self.sumOut
                
                
                
                print(self.totalInArray)
                print(self.Date)
                print(self.balanceTotal)
                print(self.sumIn)
                print(self.sumOut)
                print(self.gapInOut)
                print(self.gapArray)

                self.getTotal()
                
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
        return stat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailStatCell") as? DetailStatCell else { return UITableViewCell() }
        
        let mO = Double(stat[indexPath.row].m_out)
        let mI = Double(stat[indexPath.row].m_in)
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
//        formatter.locale = NSLocale(localeIdentifier: "th_TH") as Locale
        let mIn = formatter.string(for: mI)
        let mOut = formatter.string(for: mO)
        
        cell.inTxt.text = mIn
        cell.outTxt.text = mOut
        cell.dateTxt.text = stat[indexPath.row].date
        
        return cell
    }
    
    func getTotal(){
        
        let tIn = sumIn
        let tOut = sumOut
        let gIO = gapInOut
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
//        formatter.locale = NSLocale(localeIdentifier: "th_TH") as Locale
        let fIn = formatter.string(for: tIn)
        let fOut = formatter.string(for: tOut)
        let fGIO = formatter.string(for: gIO)
        
        totalIN.text = fIn
        totalOut.text = fOut
        
//        totalIN.text = String(format:"%.2f",sumIn)
//        totalOut.text = String(format:"%.2f",sumOut)
        if gapInOut > 0 {
            gapTxt.textColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
         gapTxt.text = fGIO
        } else {
            gapTxt.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
         gapTxt.text = fGIO
        }
    }
    
    //MARK: - VC segue to Multi Chart line VC
    
    @IBAction func toMultiChart(_ sender: Any) {
        performSegue(withIdentifier: "toMutiChart", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMutiChart" {
            let secondVC = segue.destination as! MultiVC
            secondVC.item = Date
            secondVC.lineOne = balanceTotal
            secondVC.lineTwo = revanue
            secondVC.lineX = gapArray
        }
    }
}
