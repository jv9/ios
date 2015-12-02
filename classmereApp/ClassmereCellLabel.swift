//
//  ClassmereCellLabel.swift
//  classmereApp
//
//  Created by Rutger Farry on 12/1/15.
//  Copyright © 2015 Brandon Lee. All rights reserved.
//

import UIKit

enum ClassmereTextStyle {
    case Title
    case Body
}

enum ClassmereLabelType {
    case Title
    case Abbreviation
    case Credits
    case Description
    case Building
    case Days
    case Time
    case Type
    case Status
    case Enrollment
    case Fees
    case Restrictions
    
    static func widgetForType(type: ClassmereLabelType) -> UIView? {
        let image = imageForType(type)
        if let image = image {
            return UIImageView(image: image)
        } else {
            return nil
        }
    }
    
    static func textStyleForType(type: ClassmereLabelType) -> ClassmereTextStyle {
        switch type {
        case .Title:
            return .Title
        case .Abbreviation:
            return .Title
        default:
            return .Body
        }
    }
    
    private static func imageForType(type: ClassmereLabelType) -> UIImage? {
        switch type {
        case .Title:
            return nil
        case .Abbreviation:
            return nil
        case .Credits:
            return UIImage(named: "coins")
        case .Description:
            return UIImage(named: "description")
        case .Building:
            return UIImage(named: "building")
        case .Days:
            return UIImage(named: "calendar")
        case .Time:
            return UIImage(named: "clock")
        case .Type:
            return UIImage(named: "network")
        case .Status:
            return UIImage(named: "flag")
        case .Enrollment:
            return UIImage(named: "people")
        case .Fees:
            return UIImage(named: "cash")
        case .Restrictions:
            return UIImage(named: "flag")
        }
    }
}

class ClassmereCellLabel: UIStackView {
    
    var textLabel = UILabel()
    var widgetView = UIView()
    
    var text: String? {
        didSet {
            textLabel.text = text
        }
    }
    
    var type: ClassmereLabelType = .Title {
        didSet {
            textLabel.classmereTextStyle = ClassmereLabelType.textStyleForType(type)
            widgetView = ClassmereLabelType.widgetForType(type) ?? UIView()
        }
    }
    
    override func layoutSubviews() {
        self.addArrangedSubview(textLabel)
        self.addArrangedSubview(widgetView)
    }
}
