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
    
    var name = ["mgd_month","mtk_month","beauty_month","jew_month"]
    var incomeS: Double = 0
    var payS:Double = 0
    var gapS:Double = 0
    var incomArray = [Double]()
    var payArray = [Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        downloadJson()

        // Do any additional setup after loading the view.
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
        cell?.statTxt.text = name[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailStatVC") as? DetailStatVC
        vc?.nameP = name[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func downloadJson(){
//        let url = URL(string:urlP)
//        print(urlP)
        for a in name {
            print(a)
            let urlB = "https://office.mtkserver.com/result_account/\(a)/08/2018"
            let url = URL(string:urlB)
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
                    for i in actors{
                        self.incomeS += Double(i.m_in)!
                        self.payS += Double(i.m_out)!
                        
                        //                  MARK: - Keep Dynamic data in Array      
//                        if self.incomArray == nil  && self.payArray == nil{
//                            self.incomArray.append(Double(i.m_in)!)
//                            self.payArray.append(Double(i.m_out)!)
//                        }else {
//                            self.incomArray += (Double(i.m_in)!)
//                            self.payArray += (Double(i.m_out)!)
//                        }

                    }
                    
                    //TODO: - get Income and Payment
                    print(self.incomeS)
                    print(self.payS)
                    print(self.incomeS - self.payS)
//                    self.tableView.reloadData()
                } catch {
                    print("something wrong after downloaded")
                }
                }.resume()
        }
        
    }
    



}


