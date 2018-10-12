//
//  StockVC.swift
//  testJSON
//
//  Created by Narongsak_O on 9/10/18.
//  Copyright © 2018 nProject. All rights reserved.
//

import UIKit

class StockVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
      final let url = URL(string:"https://office.mtkserver.com/get_shop_order/get_inventory")
    
    var invent = [Stock]()
    var nameS = [String]()
    var skuNo = [String]()
    var countS = [String]()
    var countD = [Double]()
    var sumCount : Double = 0
    var currentSKU = [Stock]() //update tableView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setUpSearchBar()
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
                
                self.currentSKU = actors.inventory
                
                self.countD = self.countS.map { Double($0)!}

                for num in self.countD {
                    self.sumCount += num
                }

                print(self.nameS)
                print(self.countS)
                print(self.skuNo)
                print(self.sumCount)
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
//        return invent.count
        return currentSKU.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StockCell") as? StockCell else { return UITableViewCell() }
        
        let price = Double(currentSKU[indexPath.row].item_count)
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let dec = formatter.string(for: price)
        
        cell.countTxt.text = dec
        cell.noTxt.text = currentSKU[indexPath.row].item_name
        cell.skuTxt.text = currentSKU[indexPath.row].item_sku
        print(currentSKU[indexPath.row].item_sku)
        
        //Todo: check Stock
        
//        checkStock(value: Int(invent[indexPath.row].item_count)!)
        
        let a = Int(currentSKU[indexPath.row].item_count)!
        if a < 200 {
             cell.stockTxt.text = "!Alert"
             cell.stockTxt.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        } else {
            cell.stockTxt.text = "Available"
            cell.stockTxt.textColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
        }
        
        return cell
    }
    
    func setUpTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //MARK: - Search Bar
    func setUpSearchBar(){
        searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            currentSKU = invent
            tableView.reloadData()
            return }
        currentSKU = invent.filter({ (test) -> Bool in
             return   test.item_sku.lowercased().contains(searchText)
        })
        tableView.reloadData()
    }
    
//    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
//        switch <#value#> {
//        case 0:
//        case 1:
//            <#code#>
//        default:
//            <#code#>
//        }
//    }
    


}

//MARK: - Format Number

extension Double {
    static let twoFractionDigits: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    var formatted: String {
        return Double.twoFractionDigits.string(for: self) ?? ""
    }
}
