//
//  ViewController.swift
//  testJSON
//
//  Created by Narongsak_O on 8/10/18.
//  Copyright © 2018 nProject. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    final let url = URL(string:"http://alpha.mtkserver.com/_get_title_shop/gold_month/09/2018")
    
    @IBOutlet weak var tableView: UITableView!
    
    var gold = [Gold]()
    
    var countArray:[String] = []
    
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
                
                self.tableView.reloadData()
                
                for i in actors {
                    self.countArray.append(i.count)
                }
                print(self.countArray)
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
    


}

