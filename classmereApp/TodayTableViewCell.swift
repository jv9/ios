//
//  TodayTableViewCell.swift
//  classmere
//
//  Created by Rutger Farry on 10/22/15.
//  Copyright © 2015 Rutger Farry. All rights reserved.
//


import UIKit
import MapKit

class TodayTableViewCell: AbstractClassmereCell {

    let mapView = MKMapView()
    let titleLabel = UILabel()
    let timeLabel = UILabel()
    let buildingLabel = UILabel()
    
    // MARK: - Layout subviews
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layoutTopSubviews()
        layoutMiddleSubviews()
        layoutBottomSubviews()
    }
    
    func layoutTopSubviews() {
        let margins = aboveView.layoutMarginsGuide
        
        aboveView.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraintEqualToAnchor(margins.topAnchor).active = true
        mapView.bottomAnchor.constraintEqualToAnchor(margins.bottomAnchor).active = true
        mapView.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor).active = true
        mapView.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor).active = true
//        let origin = CGPoint(x: 0.0, y: 0.0)
//        let size = aboveView.bounds.size
//        let frame = CGRect(origin: origin, size: size)
//        mapView.frame = frame
    }
    
    func layoutMiddleSubviews() {
        let margins = middleView.layoutMarginsGuide
        
        middleView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraintEqualToAnchor(margins.topAnchor).active = true
        titleLabel.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor).active = true
        titleLabel.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor).active = true
        
        middleView.addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.topAnchor.constraintEqualToAnchor(titleLabel.layoutMarginsGuide.bottomAnchor).active = true
        timeLabel.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor).active = true
        timeLabel.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor).active = true
        
        middleView.addSubview(buildingLabel)
        buildingLabel.translatesAutoresizingMaskIntoConstraints = false
        buildingLabel.topAnchor.constraintEqualToAnchor(timeLabel.layoutMarginsGuide.bottomAnchor).active = true
        buildingLabel.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor).active = true
        buildingLabel.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor).active = true
    }
    
    func layoutBottomSubviews() {
        
    }

    func populateWithCourse(course: Course) {
        let section = course.courseSections[0]
        titleLabel.text = course.title?.capitalizedString
        timeLabel.text = TodayTableViewCell.formatCourseTime(course)
        buildingLabel.text = TodayTableViewCell.formatBuildingStringWithSection(section)
        super.awakeFromNib()
    }

    static func formatCourseTime(course: Course) -> String {
        if let startTime = course.courseSections[0].startTime,
            endTime = course.courseSections[0].endTime {
                let startTimeString = DataFormatter.timeStringFromDate(startTime)
                let endTimeString = DataFormatter.timeStringFromDate(endTime)
                return "\(startTimeString) – \(endTimeString)"
        } else {
            return "TBA"
        }
    }

    static func formatBuildingStringWithSection(section: CourseSection) -> String {
        if let buildingName = section.building?.name?.capitalizedString,
            roomNumber = section.roomNumber {
                return "\(buildingName) \(roomNumber)"
        } else {
            return "TBA"
        }
    }
}
