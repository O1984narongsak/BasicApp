//
//  Gold.swift
//  testJSON
//
//  Created by Narongsak_O on 8/10/18.
//  Copyright © 2018 nProject. All rights reserved.
//

import UIKit

class Gold : Codable {
    let date: String
    let count : String
    init(date:String,count:String){
        self.date = date
        self.count = count
    }
}

struct CountArray {
    var count : Int = 0
}

struct Date {
    var date : String = ""
}
