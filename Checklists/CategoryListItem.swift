//
//  CategoryListItem.swift
//  Checklists
//
//  Created by Yasser Abouel-Saad on 26/4/17.
//  Copyright © 2017 Yasser Abouel-Saad. All rights reserved.
//

import Foundation
import  UIKit

class CategoryListItem : NSObject {
    var text = ""
    var image :UIImage!
    var items: [CheckListItem]!

    override init() {
        items = [CheckListItem]()
        super.init()
    }
}
