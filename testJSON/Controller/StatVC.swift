//
//  StatVC.swift
//  testJSON
//
//  Created by Narongsak_O on 9/10/18.
//  Copyright © 2018 nProject. All rights reserved.
//

import UIKit

class StatVC: UIViewController ,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var overBtn: UIButton!
    
    var name = ["mgd_month","mtk_month","beauty_month","jew_month"]
    var brand = ["MTK Racing","MTK TECH","MTK Beauty","MTK Jew"]

    var incomeS: Double = 0
    var payS:Double = 0
    var gapS:Double = 0
//    var incomAS = [Double]()
//    var payAS = [Double]()
    var incomArray = [Double]()
    var payArray = [Double]()
    
    var incomATwo = [Double]()
    var payATwo = [Double]()
    
    var incomAT = [Double]()
    var payAT = [Double]()
    
    var incomAFo = [Double]()
    var payAFo = [Double]()
    
    var plus = [Double]()
    var fill = [Double]()
    var gapFP = [Double]()
    var clear = [Double]()
    var nameC:[String] = []
    
    var fillS : String = ""
    var plusS : String = ""
    var gapFpS : String = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        downloadJson()
        overBtn.layer.cornerRadius = 10.0

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(name.count)
        return name.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatTableViewCell",for: indexPath ) as? StatTableViewCell
        
        cell?.statTxt.text = brand[indexPath.row]
        cell?.img.image = UIImage(named: name[indexPath.row])
        return cell!
    }
    
    //TODO: - Parse data to New VC
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailStatVC") as? DetailStatVC
        
        vc?.nameL = brand[indexPath.row]
        vc?.nameP = name[indexPath.row]
        vc?.image = UIImage(named: name[indexPath.row])!
        
        self.navigationController?.pushViewController(vc!, animated: true)
        
        
    }
    
    func downloadJson(){

        for a in name {
            print(a)
            let urlB = "https://office.mtkserver.com/result_account/\(a)/08/2018"
            print(urlB)
            let url = URL(string:urlB)
            guard let downloadURL = url else { return }
            URLSession.shared.dataTask(with: downloadURL) { (data, urlResponse, error) in
                guard let data = data, error == nil, urlResponse != nil else {
                    print("Something wrong")
                    return }
                print("downloaded")

                do{
                    let decoder = JSONDecoder()
                    let actors = try decoder.decode([Stat].self, from: data)
                    
                    for i in actors{
//                        if self.incomArray.count == 0 && self.payArray.count == 0 {
                            self.incomArray.append(Double(i.m_in)!)
                            self.payArray.append(Double(i.m_out)!)
                        
                    }
                    
                    print("pay \(self.payArray.count)")
                    print("income \(self.incomArray.count)")

                    if self.plus.count == 0 {
                        self.plus = self.payArray
                    } else if self.plus.count < self.payArray.count {
                        let a = self.payArray.count - self.plus.count
                        let b = Array(repeating: 0.0, count: a)
                        self.plus += b
                        for(index,_) in self.plus.enumerated(){
                            self.plus[index] = self.plus[index] + self.payArray[index]
                        }
                    } else if self.plus.count > self.payArray.count {
                        let a = self.plus.count - self.payArray.count
                        let b = Array(repeating: 0.0, count: a)
                        self.payArray += b
                        for(index,_) in self.plus.enumerated(){
                            self.plus[index] = self.plus[index] + self.payArray[index]
                        }
                        print("plus\(self.plus.count)")
                    }

                    if  self.fill.count == 0 {
                        self.fill = self.incomArray
                    }else if self.fill.count < self.incomArray.count {
                        let c = self.incomArray.count - self.fill.count
                        let d = Array(repeating: 0.0, count: c)
                        self.fill += d
                        for(index,_) in self.fill.enumerated(){
                            self.fill[index] = self.fill[index] + self.incomArray[index]
                        }
                    } else if self.fill.count > self.incomArray.count {
                        let c = self.fill.count - self.incomArray.count
                        let d = Array(repeating: 0.0, count: c)
                        self.incomArray += d
                        for(index,_) in self.fill.enumerated(){
                            self.fill[index] = self.fill[index] + self.incomArray[index]
                        }
                    }

                    self.incomArray.removeAll()
                    self.payArray.removeAll()

                    let t = self.plus.reduce(0, { ($0 + $1)})
                    let h = self.fill.reduce(0, { ($0 + $1)})
                    self.nameC = Array(repeating: "1", count: self.plus.count)
                    
                    for gap in self.fill {
                        for a in self.plus{
                            self.gapFP.append(gap - a)
                        }
                    }
                    
                    print(self.nameC)
                    print(self.plus.count)
                    print(self.fill.count)
                    print("plus\(t)")
                    print("fill\(h)")
                    
                    self.fillS = String(t)
                    self.plusS = String(h)
                    self.gapFpS = String(h - t)
                    
                    self.tableView.reloadData()
                } catch {
                    print("something wrong after downloaded")
                }
                }.resume()
        } //for loop
    
    }
    
    
    @IBAction func toOverBtn(_ sender: UIButton) {
        performSegue(withIdentifier: "toOverView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toOverView" {
            let secondVC = segue.destination as! OverViewVC
            secondVC.item = nameC
            secondVC.lineOne = fill
            secondVC.lineTwo = plus
            secondVC.lineX = gapFP
            
        }
    }
    
    
}


