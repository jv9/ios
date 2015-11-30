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
    
    let FLIP_SPRING_BOUNCINESS: CGFloat = 0.0
    let MOVE_SPRING_BOUNCINESS: CGFloat = 0.0
    let FLIP_SPRING_VELOCITY: CGFloat = 12.0
    let MOVE_SPRING_VELOCITY: CGFloat = 12.0
    
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
        super.awakeFromNib()
        
        selectionStyle = .None
        
        let topOrigin = CGPoint(x: 0.0, y: -self.frame.height)
        let middleOrigin = CGPoint(x: 0.0, y: 0.0)
        let bottomOrigin = CGPoint(x: 0.0, y: self.frame.height)
        let size = self.frame.size
        
        let topFrame = CGRect(origin: topOrigin, size: size)
        let middleFrame = CGRect(origin: middleOrigin, size: size)
        let bottomFrame = CGRect(origin: bottomOrigin, size: size)
        
        let topAnchorPoint = CGPoint(x: 0.5, y: 1.0)
        let bottomAnchorPoint = CGPoint(x: 0.5, y:0.0)
        
        middleView.frame = middleFrame
        middleView.backgroundColor = UIColor.redColor()
        contentView.insertSubview(middleView, atIndex: 0)
        
        aboveView.frame = topFrame
        aboveView.layer.anchorPoint = topAnchorPoint
        aboveView.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI), 1.0, 0.0, 0.0)
        aboveView.backgroundColor = UIColor.purpleColor()
        contentView.insertSubview(aboveView, atIndex: 0)
        
        belowView.frame = bottomFrame
        belowView.layer.anchorPoint = bottomAnchorPoint
        belowView.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI), 1.0, 0.0, 0.0)
        belowView.backgroundColor = UIColor.yellowColor()
        contentView.insertSubview(belowView, atIndex: 0)
    }
    
    // MARK: - Animation Methods
    
    func toggleExpansion() {
        let flipAnimation = POPSpringAnimation(propertyNamed: kPOPLayerRotationX)
        let moveAnimation = POPSpringAnimation(propertyNamed: kPOPLayerTranslationY)
        flipAnimation.springBounciness = FLIP_SPRING_BOUNCINESS
        moveAnimation.springBounciness = MOVE_SPRING_BOUNCINESS
        flipAnimation.velocity = FLIP_SPRING_VELOCITY
        moveAnimation.velocity = MOVE_SPRING_VELOCITY
        
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
            flipAnimation.toValue = 0.0
            moveAnimation.toValue = middleView.frame.height
            
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
