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
    
    var topView = UIView()
    var middleView = UIView()
    var bottomView = UIView()
    
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
        
        // Place top, middle, and bottom views
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
        
        topView.frame = topFrame
        topView.layer.anchorPoint = topAnchorPoint
        topView.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI), 1.0, 0.0, 0.0)
        topView.backgroundColor = UIColor.purpleColor()
        contentView.insertSubview(topView, atIndex: 0)
        
        bottomView.frame = bottomFrame
        bottomView.layer.anchorPoint = bottomAnchorPoint
        bottomView.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI), 1.0, 0.0, 0.0)
        bottomView.backgroundColor = UIColor.yellowColor()
        contentView.insertSubview(bottomView, atIndex: 0)
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
            cellWillContract()
            
            flipAnimation.toValue = M_PI / 2.0
            moveAnimation.toValue = 0.0
            
            // Hide cell on completion
            flipAnimation.completionBlock = { _,_ in
                self.cellDidContract()
                self.topView.hidden = true
                self.bottomView.hidden = true
            }
            
            // Move animation
            middleView.layer.pop_addAnimation(moveAnimation, forKey: "middleMoveUp")
            topView.layer.pop_addAnimation(moveAnimation, forKey: "topMoveUp")
            bottomView.layer.pop_addAnimation(moveAnimation, forKey: "bottomMoveUp")
            
            // Flip animation
            topView.layer.pop_addAnimation(flipAnimation, forKey: "topFlipDown")
            bottomView.layer.pop_addAnimation(flipAnimation, forKey: "bottomFlipUp")

            cellState = .Closed
        case .Closed:
            cellWillExpand()
            
            flipAnimation.toValue = 0.0
            moveAnimation.toValue = middleView.frame.height
            
            flipAnimation.completionBlock = { _,_ in
                self.cellDidExpand()
            }
            
            // Show cell
            topView.hidden = false
            bottomView.hidden = false
            
            // Move animation
            middleView.layer.pop_addAnimation(moveAnimation, forKey: "middleMoveDown")
            topView.layer.pop_addAnimation(moveAnimation, forKey: "topMoveDown")
            bottomView.layer.pop_addAnimation(moveAnimation, forKey: "middleMoveDown")
            
            // Flip animation
            topView.layer.pop_addAnimation(flipAnimation, forKey: "topFlipUp")
            bottomView.layer.pop_addAnimation(flipAnimation, forKey: "bottomFlipDown")
            
            cellState = .Open
        }
    }
    
    func cellWillExpand() -> Void {}
    func cellDidExpand() -> Void {}
    func cellWillContract() -> Void {}
    func cellDidContract() -> Void {}
}
