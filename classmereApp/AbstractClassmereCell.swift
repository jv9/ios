//
//  AbstractClassmereCell.swift
//  classmereApp
//
//  Created by Rutger Farry on 10/26/15.
//  Copyright © 2015 Brandon Lee. All rights reserved.
//

import UIKit
import pop
import Darwin

private enum CellState {
    case Open
    case Closed
    case Opening
    case Closing
}

class AbstractClassmereCell: UITableViewCell {
    
    let aboveView = UIView()
    let belowView = UIView()
    
    private var cellState: CellState = .Closed
    
    override func awakeFromNib() {
        layer.cornerRadius = 4.0
        layer.masksToBounds = true
        backgroundColor = UIColor.clearColor()
        selectionStyle = .None
        
        aboveView.frame = self.frame
        belowView.frame = self.frame
    }
    
    func toggleExpansion() {
        let flipAnimation = POPSpringAnimation(propertyNamed: kPOPLayerRotationX)
        switch cellState {
        case .Open:
            flipAnimation.toValue = 0
            layer.pop_addAnimation(flipAnimation, forKey: "flipUp")
            cellState = .Closed
        case .Closed:
            flipAnimation.toValue = M_PI
            layer.pop_addAnimation(flipAnimation, forKey: "flipUp")
            cellState = .Open
        case .Opening:
            break
        case .Closing:
            break
        }
    }
}
