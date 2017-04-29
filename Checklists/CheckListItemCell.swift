//
//  CheckListItemCell.swift
//  Checklists
//
//  Created by Yasser Abouel-Saad on 17/4/17.
//  Copyright © 2017 Yasser Abouel-Saad. All rights reserved.
//

import UIKit

class CheckListItemCell: UITableViewCell {

    @IBOutlet var itemTitleLable : UILabel!
    
    @IBOutlet weak var checkLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        itemTitleLable.text = ""
    }

}
