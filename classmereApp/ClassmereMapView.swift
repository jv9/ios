//
//  ClassmereMapView.swift
//  classmereApp
//
//  Created by Rutger Farry on 1/10/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import UIKit
import Mapbox

class ClassmereMapView: UIView {
    private var internalMapView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.greenColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ClassmereMapView {
    func centerMapOnAddress() {
        return
    }
}
