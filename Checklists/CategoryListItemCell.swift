//
//  CategoryListItemCell.swift
//  Checklists
//
//  Created by Yasser Abouel-Saad on 26/4/17.
//  Copyright © 2017 Yasser Abouel-Saad. All rights reserved.
//

import UIKit

class CategoryListItemCell: UITableViewCell {

    @IBOutlet var counterLabelView: UILabel!
    @IBOutlet var textLabelView: UILabel!
    @IBOutlet var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        textLabelView.text = ""
        counterLabelView.text = ""
        iconImageView.image=nil
    }

}
