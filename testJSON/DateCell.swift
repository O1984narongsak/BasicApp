//
//  DateCell.swift
//  testJSON
//
//  Created by Narongsak_O on 8/10/18.
//  Copyright © 2018 nProject. All rights reserved.
//

import UIKit

class DateCell: UITableViewCell {

    @IBOutlet weak var dateTxt: UILabel!
    @IBOutlet weak var countTxt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
