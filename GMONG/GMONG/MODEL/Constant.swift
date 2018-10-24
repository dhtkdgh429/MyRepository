//
//  Constant.swift
//  GMONG
//
//  Created by Oh Sangho on 2018. 9. 25..
//  Copyright © 2018년 Oh Sangho. All rights reserved.
//

import UIKit

class Constant {
    static let totalItem: CGFloat = 2
    
    static let column: CGFloat = 1
    
    // image 사이 line(상하) / item(좌우) 간 space
    static let minLineSpacing: CGFloat = 0
    static let minItemSpacing: CGFloat = 0
    
    // image와 화면 사이 offset
    static let offset: CGFloat = 0 // TODO: for each side, define its offset
    
    static func getItemWidth(boundWidth: CGFloat) -> CGFloat {
        
        let totalWidth = boundWidth - (offset + offset) - ((column - 1) * minItemSpacing)
        
        return totalWidth / column
    }
}
