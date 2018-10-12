//
//  Double.swift
//  testJSON
//
//  Created by Narongsak_O on 12/10/18.
//  Copyright © 2018 nProject. All rights reserved.
//

import Foundation

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
