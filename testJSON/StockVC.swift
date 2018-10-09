//
//  StockVC.swift
//  testJSON
//
//  Created by Narongsak_O on 9/10/18.
//  Copyright © 2018 nProject. All rights reserved.
//

import UIKit

class StockVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
      final let url = URL(string:"https://office.mtkserver.com/get_shop_order/get_inventory")
    
    var invent = [Stock]()
    var nameS = [String]()
    var skuNo = [String]()
    var countS = [String]()
    var countD = [Double]()
    var sumCount : Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        downloadJson()
        // Do any additional setup after loading the view.
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
                let actors = try decoder.decode(Ksu.self, from: data)
                
                print(actors.inventory[0].item_name)
                
                self.invent = actors.inventory
//                 TODO: - Array
                for i in actors.inventory {
                    self.nameS.append(i.item_name)
                    self.countS.append(i.item_count)
                    self.skuNo.append(i.item_sku)
                }
                self.countD = self.countS.map { Double($0)!}

                for num in self.countD {
                    self.sumCount += num
                }

                print(self.nameS)
                print(self.countS)
                print(self.skuNo)
                print(self.sumCount)
//
//                self.getTotal()
                //
                //                self.setChart(values: self.countChart)
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
        return invent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StockCell") as? StockCell else { return UITableViewCell() }
        
        cell.countTxt.text = invent[indexPath.row].item_count
        cell.noTxt.text = invent[indexPath.row].item_name
        cell.skuTxt.text = invent[indexPath.row].item_sku
        
        return cell
    }



}
