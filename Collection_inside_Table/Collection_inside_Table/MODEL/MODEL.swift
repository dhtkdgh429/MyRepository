//
//  MODEL.swift
//  Collection_inside_Table
//
//  Created by Oh Sangho on 2018. 9. 24..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

import UIKit

class Constant {
    static let totalItem:CGFloat = 20
    
    static let column: CGFloat = 3
    
    static let minLineSpacing: CGFloat = 1.0
    static let minItemSpacing: CGFloat = 1.0
    
    static let offset: CGFloat = 1.0 // TODO: for each side, define its offset
    
    static func getItemWidth(boundWidth: CGFloat) -> CGFloat {
        
        // totalCellWidth = (collectionview width or tableview width) - (left offset + right offset) - (total space x space width)
        
        let totalWidth = boundWidth - (offset + offset) - ((column - 1) * minItemSpacing)
        
        return totalWidth / column
    }
}
