//
//  CategoryListItem.swift
//  Checklists
//
//  Created by Yasser Abouel-Saad on 26/4/17.
//  Copyright © 2017 Yasser Abouel-Saad. All rights reserved.
//

import Foundation
import  UIKit

class CategoryListItem : NSObject, NSCoding {
    var text = ""
    var image :UIImage!
    var imageName = ""
    var items: [CheckListItem]!

    override init() {
        items = [CheckListItem]()
        super.init()
    }
    
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(text, forKey: "Text")
        aCoder.encode(image, forKey: "Image")
        aCoder.encode(items, forKey: "Items")
    }
    
    required init(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObject(forKey: "Text") as! String
        image = aDecoder.decodeObject(forKey: "Image") as! UIImage?
        items = aDecoder.decodeObject(forKey: "Items") as! [CheckListItem]
        super.init()
    }
}
