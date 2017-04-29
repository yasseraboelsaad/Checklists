//
//  CheckListItem.swift
//  Checklists
//
//  Created by Yasser Abouel-Saad on 19/4/17.
//  Copyright © 2017 Yasser Abouel-Saad. All rights reserved.
//

import Foundation

class CheckListItem : NSObject, NSCoding {
    var text = ""
    var checked = false
    
    func toggleChecked(){
        checked = !checked
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(text, forKey: "Text")
        aCoder.encode(checked, forKey: "Checked")
    }
    
    required init?(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObject(forKey: "Text") as! String
        checked = aDecoder.decodeBool(forKey: "Checked")
        super.init()
    }
    override init() {
        super.init()
    }
}
