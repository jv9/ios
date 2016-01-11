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
    
    var topView = UIStackView()
    var bottomView = UIStackView()
    
    private var topBackingView = UIView()
    private var bottomBackingView = UIView()
    
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
        
        // Place top and bottom views
        let topOrigin = CGPoint(x: 0.0, y: -self.frame.height)
        let bottomOrigin = CGPoint(x: 0.0, y: 0.0)
        
        let size = self.frame.size
        
        let topFrame = CGRect(origin: topOrigin, size: size)
        let bottomFrame = CGRect(origin: bottomOrigin, size: size)
        
        let topAnchorPoint = CGPoint(x: 0.5, y: 1.0)

        bottomView.frame = bottomFrame
        bottomView.axis = .Vertical
        bottomView.distribution = .FillEqually
        
        bottomBackingView.frame = bottomFrame

        topView.frame = bottomFrame
        topView.axis = .Vertical
        topView.distribution = .FillEqually
        
        topBackingView.frame = topFrame
        topBackingView.layer.anchorPoint = topAnchorPoint
        topBackingView.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI), 1.0, 0.0, 0.0)
        
        bottomBackingView.backgroundColor = UIColor.grayColor()
        topBackingView.backgroundColor = UIColor.grayColor()
        
        contentView.insertSubview(bottomBackingView, atIndex: 0)
        contentView.insertSubview(topBackingView, atIndex: 0)
        bottomBackingView.insertSubview(bottomView, atIndex: 0)
        topBackingView.insertSubview(topView, atIndex: 0)
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
                self.topBackingView.hidden = true
            }
            
            // Move animation
            bottomBackingView.layer.pop_addAnimation(moveAnimation, forKey: "bottomMoveUp")
            topBackingView.layer.pop_addAnimation(moveAnimation, forKey: "topMoveUp")
            
            // Flip animation
            topBackingView.layer.pop_addAnimation(flipAnimation, forKey: "topFlipDown")

            cellState = .Closed
        case .Closed:
            cellWillExpand()
            
            flipAnimation.toValue = 0.0
            moveAnimation.toValue = bottomBackingView.frame.height
            
            flipAnimation.completionBlock = { _,_ in
                self.cellDidExpand()
            }
            
            // Show cell
            topBackingView.hidden = false
            
            // Move animation
            bottomBackingView.layer.pop_addAnimation(moveAnimation, forKey: "bottomMoveDown")
            topBackingView.layer.pop_addAnimation(moveAnimation, forKey: "topMoveDown")
            
            // Flip animation
            topBackingView.layer.pop_addAnimation(flipAnimation, forKey: "topFlipUp")
            
            cellState = .Open
        }
    }
    
    func cellWillExpand() -> Void {}
    func cellDidExpand() -> Void {}
    func cellWillContract() -> Void {}
    func cellDidContract() -> Void {}
}
