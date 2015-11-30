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

enum CellState {
    case Open
    case Closed
}

class AbstractClassmereCell: UITableViewCell {
    
    var aboveView = UIView()
    var middleView = UIView()
    var belowView = UIView()
    
    var cellState: CellState = .Closed
    
    // MARK: - Initialization
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        selectionStyle = .None
        let origin = CGPoint(x: 0.0, y: 0.0)
        let size = self.frame.size
        let frame = CGRect(origin: origin, size: size)
        
        middleView.frame = frame
        middleView.backgroundColor = UIColor.redColor()
        contentView.insertSubview(middleView, atIndex: 0)
        
        aboveView.frame = frame
        aboveView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        aboveView.backgroundColor = UIColor.purpleColor()
        contentView.insertSubview(aboveView, atIndex: 0)
        
        belowView.frame = frame
        belowView.layer.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        belowView.backgroundColor = UIColor.yellowColor()
        contentView.insertSubview(belowView, atIndex: 0)
    }
    
    // MARK: - Animation Methods
    
    func toggleExpansion() {
        let flipAnimation = POPSpringAnimation(propertyNamed: kPOPLayerRotationX)
        let moveAnimation = POPSpringAnimation(propertyNamed: kPOPLayerTranslationY)
        flipAnimation.springBounciness = 0.0
        moveAnimation.springBounciness = 0.0
        switch cellState {
        case .Open:
            flipAnimation.toValue = M_PI / 2.0
            moveAnimation.toValue = 0.0
            
            // Hide cell on completion
            flipAnimation.completionBlock = { _,_ in
                self.aboveView.hidden = true
                self.belowView.hidden = true
            }
            
            // Move animation
            middleView.layer.pop_addAnimation(moveAnimation, forKey: "middleMoveUp")
            aboveView.layer.pop_addAnimation(moveAnimation, forKey: "aboveMoveUp")
            belowView.layer.pop_addAnimation(moveAnimation, forKey: "belowMoveUp")
            
            // Flip animation
            aboveView.layer.pop_addAnimation(flipAnimation, forKey: "aboveFlipDown")
            belowView.layer.pop_addAnimation(flipAnimation, forKey: "belowFlipUp")

            cellState = .Closed
        case .Closed:
            flipAnimation.toValue = M_PI
            moveAnimation.toValue = 122.0
            
            // Show cell
            aboveView.hidden = false
            belowView.hidden = false
            
            // Move animation
            middleView.layer.pop_addAnimation(moveAnimation, forKey: "middleMoveDown")
            aboveView.layer.pop_addAnimation(moveAnimation, forKey: "aboveMoveDown")
            belowView.layer.pop_addAnimation(moveAnimation, forKey: "middleMoveDown")
            
            // Flip animation
            aboveView.layer.pop_addAnimation(flipAnimation, forKey: "aboveFlipUp")
            belowView.layer.pop_addAnimation(flipAnimation, forKey: "belowFlipDown")
            
            cellState = .Open
        }
    }
}
