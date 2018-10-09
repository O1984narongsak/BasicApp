//
//  DetailStatVC.swift
//  testJSON
//
//  Created by Narongsak_O on 9/10/18.
//  Copyright © 2018 nProject. All rights reserved.
//

import UIKit

class DetailStatVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

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
                
                self.stat = actors
                // TODO: - Array
                for i in actors {
                    self.totalInArray.append(i.m_in)
                    self.Date.append(i.date)
                    self.totalOutArray.append(i.m_out)
                }
                self.balanceTotal = self.totalInArray.map { Double($0)!}
                
                for num in self.balanceTotal {
                    self.sumIn += num
                }
                
                self.revanue = self.totalOutArray.map { Double($0)!}
                
                for nb in self.revanue {
                    self.sumOut += nb
                }
                
                self.gapInOut = self.sumIn - self.sumOut
                
                
                
                print(self.totalInArray)
                print(self.Date)
                print(self.balanceTotal)
                print(self.sumIn)
                print(self.sumOut)
                print(self.gapInOut)

                self.getTotal()
                
                self.tableView.reloadData()
                
                
            } catch {
                print("something wrong after downloaded")
            }
            }.resume()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailStatCell") as? DetailStatCell else { return UITableViewCell() }
        
        cell.inTxt.text = stat[indexPath.row].m_in
        cell.outTxt.text = stat[indexPath.row].m_out
        cell.dateTxt.text = stat[indexPath.row].date
        
        return cell
    }
    func getTotal(){
        totalIN.text = String(format:"%.2f",sumIn)
        totalOut.text = String(sumOut)
        gapTxt.text = String(format:"%.2f",gapInOut)
    }
    
    

}
