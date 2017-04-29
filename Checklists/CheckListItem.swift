//
//  CheckListItem.swift
//  Checklists
//
//  Created by Yasser Abouel-Saad on 19/4/17.
//  Copyright © 2017 Yasser Abouel-Saad. All rights reserved.
//

import Foundation

class CheckListItem : NSObject {
    var text = ""
    var checked = false
    
    func toggleChecked(){
        checked = !checked
    }
}
