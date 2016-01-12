//
//  ClassmereCardLabel.swift
//  classmereApp
//
//  Created by Rutger Farry on 1/10/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import UIKit

enum ClassmereLabelTextStyle {
    case Heading
    case Body
    
    static func fontForStyle(style: ClassmereLabelTextStyle) -> UIFont {
        switch(style) {
        case Heading:
            return UIFont.systemFontOfSize(17.0, weight: UIFontWeightMedium)
        case Body:
            return UIFont.systemFontOfSize(14.0, weight: UIFontWeightRegular)
        }
    }
}

final class ClassmereCardLabel: UIStackView {
    
    private let iconView = UIImageView()
    private let label = UILabel()
    private var textStyle: ClassmereLabelTextStyle
    
    convenience init(icon: UIImage? = nil, text: String, style: ClassmereLabelTextStyle) {
        self.init(arrangedSubviews: [])
        textStyle = style
        iconView.image = icon
        iconView.contentMode = .ScaleAspectFit
        label.text = text
        label.font = ClassmereLabelTextStyle.fontForStyle(style)
    }
    
    required init?(coder aDecoder: NSCoder) {
        textStyle = .Body
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        textStyle = .Body
        super.init(frame: frame)
    }
    
    override init(arrangedSubviews views: [UIView]) {
        textStyle = .Body
        super.init(arrangedSubviews: views)
        axis = .Horizontal
        alignment = .FirstBaseline
        distribution = .Fill
        spacing = 4.0
    }
    
    override func layoutSubviews() {
        addArrangedSubview(iconView)
        addArrangedSubview(label)
        
        iconView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.heightAnchor.constraintEqualToConstant(label.font.pointSize).active = true
        iconView.heightAnchor.constraintEqualToAnchor(label.heightAnchor).active = true
        iconView.widthAnchor.constraintEqualToAnchor(iconView.heightAnchor).active = true
        label.centerYAnchor.constraintEqualToAnchor(iconView.centerYAnchor).active = true
        
        super.layoutSubviews()
    }
}
