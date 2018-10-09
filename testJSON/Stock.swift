//
//  Stock.swift
//  testJSON
//
//  Created by Narongsak_O on 9/10/18.
//  Copyright © 2018 nProject. All rights reserved.
//

import Foundation

class Ksu : Codable {
    let inventory : [Stock]
    init(inventory : [Stock]){
        self.inventory = inventory
    }
}



class Stock: Codable  {
    let item_sku: String
    let item_name : String
    let item_count : String
    init(item_sku:String,item_name:String,item_count:String){
        self.item_name = item_name
        self.item_count = item_count
        self.item_sku = item_sku
    }
}
