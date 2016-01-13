//
//  ClassmereMapView.swift
//  classmereApp
//
//  Created by Rutger Farry on 1/10/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import UIKit
import Mapbox

final class ClassmereMapView: UIView {
    private let internalMapView = MGLMapView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        internalMapView.backgroundColor = UIColor.greenColor()
        translatesAutoresizingMaskIntoConstraints = false
        internalMapView.frame = bounds
        internalMapView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        
        let locationCoordinate = CLLocationCoordinate2D(latitude: 44.56,
            longitude: -123.27)
        internalMapView.setCenterCoordinate(locationCoordinate,
            zoomLevel: 15,
            animated: false)
        
        addSubview(internalMapView)
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
