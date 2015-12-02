//
//  UILabel+Classmere.swift
//  classmereApp
//
//  Created by Rutger Farry on 12/1/15.
//  Copyright © 2015 Brandon Lee. All rights reserved.
//

import UIKit

extension UILabel {
    var classmereTextStyle: ClassmereTextStyle {
        get {
            return .Title
        }
        set {
            switch newValue {
            case .Title:
                self.font = UIFont.systemFontOfSize(18.0,
                    weight: UIFontWeightMedium)
                self.textColor = UIColor.whiteColor()
            case .Body:
                self.font = UIFont.systemFontOfSize(14.0,
                    weight: UIFontWeightRegular)
                self.textColor = UIColor.blackColor()
                self.alpha = 0.60
            }
        }
    }
}
