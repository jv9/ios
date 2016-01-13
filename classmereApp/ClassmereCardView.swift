//
//  ClassmereCardView.swift
//  classmereApp
//
//  Created by Rutger Farry on 1/10/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import UIKit

final class ClassmereCardView: UIView {
    
    private var mapView: ClassmereMapView?
    private let cardStackView = UIStackView()
    
    var mapAddress: String?
    var labels: [ClassmereCardLabel]?
    
    convenience init(withMap: Bool, labels: [ClassmereCardLabel]) {
        self.init(frame: CGRect())
        
        self.labels = labels
        for label in labels {
            cardStackView.addArrangedSubview(label)
        }
        
        if withMap {
            let mapView = ClassmereMapView()
            self.addSubview(mapView)
            mapView.topAnchor.constraintEqualToAnchor(self.topAnchor).active = true
            mapView.heightAnchor.constraintEqualToConstant(280.0).active = true
            mapView.leftAnchor.constraintEqualToAnchor(self.leftAnchor).active = true
            mapView.rightAnchor.constraintEqualToAnchor(self.rightAnchor).active = true
            self.mapView = mapView
        }
    }
    required init?(coder aDecoder: NSCoder) {
        mapView = nil
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        mapView = nil
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        addSubview(cardStackView)
        cardStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let cardStackViewTopAnchor = mapView?.topAnchor ?? topAnchor
        cardStackView.topAnchor.constraintEqualToAnchor(cardStackViewTopAnchor).active = true
        cardStackView.rightAnchor.constraintEqualToAnchor(rightAnchor).active = true
        cardStackView.bottomAnchor.constraintEqualToAnchor(bottomAnchor).active = true
        cardStackView.leftAnchor.constraintEqualToAnchor(leftAnchor).active = true
    }
    
    func addClassmereLabel(label: ClassmereCardLabel) {
        
    }
}