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
    case Instructor
    case Type
    case Status
    case Enrollment
    case Fees
    case Restrictions
    
    static func optionalImageViewForType(type: ClassmereLabelType) -> UIImageView? {
        let image = imageForType(type)
        if let image = image {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .ScaleAspectFit
            return imageView
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
        case .Instructor:
            return UIImage(named: "blank_face")
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
            widgetView = ClassmereLabelType.optionalImageViewForType(type) ?? UIView()
        }
    }
    
    override func drawRect(rect: CGRect) {
//        addArrangedSubview(widgetView)
        addArrangedSubview(textLabel)

    }
}
