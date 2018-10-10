//
//  DetailStatCell.swift
//  testJSON
//
//  Created by Narongsak_O on 9/10/18.
//  Copyright © 2018 nProject. All rights reserved.
//

import UIKit

class DetailStatCell: UITableViewCell {

    @IBOutlet weak var dateTxt: UILabel!
    @IBOutlet weak var inTxt: UILabel!
    
    @IBOutlet weak var outTxt: UILabel!
    
    @IBOutlet weak var skuNoTxt: UILabel!
    @IBOutlet weak var sNoTxt: UILabel!
    @IBOutlet weak var detailTxt: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
