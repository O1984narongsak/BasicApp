//
//  Stat.swift
//  testJSON
//
//  Created by Narongsak_O on 9/10/18.
//  Copyright © 2018 nProject. All rights reserved.
//

import Foundation

class Stat: Codable  {
    let date: String
    let m_in : String
    let m_out : String
    init(date:String,m_in:String,m_out:String){
        self.m_in = m_in
        self.m_out = m_out
        self.date = date
    }
}
