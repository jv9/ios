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
    let middleStackView = UIStackView()
    
    let titleLabel = ClassmereCellLabel()
    let timeLabel = ClassmereCellLabel()
    let buildingLabel = ClassmereCellLabel()
    
    // MARK: - Map variables
    
    let schoolLatitude = 44.563849
    let schoolLongitude = -123.279498
    
    let schoolZoomSpan = MKCoordinateSpan(
        latitudeDelta: 0.02,
        longitudeDelta: 0.02)
    let buildingZoomSpan = MKCoordinateSpan(
        latitudeDelta: 0.005,
        longitudeDelta: 0.005)
    
    var pinLocation: MKPlacemark?
    var buildingAddress: String?
    
    var completedNavigation = false {
        didSet {
            completedNavigation = true
        }
    }
    
    // MARK: - Layout subviews
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layoutTopSubviews()
        layoutMiddleSubviews()
        layoutBottomSubviews()
        
        styleTopSubViews()
    }
    
    func layoutTopSubviews() {
        let margins = aboveView.layoutMarginsGuide
        aboveView.layoutMargins = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        
        aboveView.addSubview(mapView)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraintEqualToAnchor(margins.topAnchor).active = true
        mapView.bottomAnchor.constraintEqualToAnchor(margins.bottomAnchor).active = true
        mapView.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor).active = true
        mapView.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor).active = true
    }
    
    func layoutMiddleSubviews() {
        let margins = middleView.layoutMarginsGuide
        middleView.layoutMargins = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        
        middleView.addSubview(middleStackView)
        middleStackView.translatesAutoresizingMaskIntoConstraints = false
        middleStackView.topAnchor.constraintEqualToAnchor(margins.topAnchor).active = true
        middleStackView.bottomAnchor.constraintEqualToAnchor(margins.bottomAnchor).active = true
        middleStackView.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor).active = true
        middleStackView.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor).active = true
        
        middleStackView.addArrangedSubview(titleLabel)
        middleStackView.addArrangedSubview(timeLabel)
        middleStackView.addArrangedSubview(buildingLabel)
        
//        middleView.addSubview(titleLabel)
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        titleLabel.topAnchor.constraintEqualToAnchor(margins.topAnchor).active = true
//        titleLabel.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor).active = true
//        titleLabel.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor).active = true
//        
//        middleView.addSubview(timeLabel)
//        timeLabel.translatesAutoresizingMaskIntoConstraints = false
//        timeLabel.topAnchor.constraintGreaterThanOrEqualToAnchor(titleLabel.layoutMarginsGuide.bottomAnchor, constant: 12.0).active = true
//        timeLabel.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor).active = true
//        timeLabel.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor).active = true
//        
//        middleView.addSubview(buildingLabel)
//        buildingLabel.translatesAutoresizingMaskIntoConstraints = false
//        buildingLabel.topAnchor.constraintEqualToAnchor(timeLabel.layoutMarginsGuide.bottomAnchor, constant: 12.0).active = true
//        buildingLabel.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor).active = true
//        buildingLabel.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor).active = true
    }
    
    func layoutBottomSubviews() {
        
    }
    
    // MARK: - Style Subviews
    
    func styleTopSubViews() {
        let schoolCoordinates = CLLocationCoordinate2D(
            latitude: schoolLatitude,
            longitude: schoolLongitude)
        let schoolCoordinateRegion = MKCoordinateRegion(
            center: schoolCoordinates,
            span: schoolZoomSpan)
        mapView.setRegion(schoolCoordinateRegion, animated: false)
    }

    func populateWithCourse(course: Course) {
        let section = course.courseSections[0]
        titleLabel.text = course.title?.capitalizedString
        titleLabel.type = .Title
        timeLabel.text = TodayTableViewCell.formatCourseTime(course)
        timeLabel.type = .Time
        buildingLabel.text = TodayTableViewCell.formatBuildingStringWithSection(section)
        buildingLabel.type = .Building
        buildingAddress = section.building?.address
        
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
    
    func startNavigationAnimation() {
        if let buildingAddress = buildingAddress {
            let geoCoder = CLGeocoder()
            geoCoder.geocodeAddressString(buildingAddress) { placemarks, error in
                if let placemark: CLPlacemark = placemarks![0],
                    placemarkRegion = placemark.region as? CLCircularRegion {
                        let mapKitPlacemark = MKPlacemark(placemark: placemark)
                        var currentCoordinateRegion = self.mapView.region
                        currentCoordinateRegion.center = placemarkRegion.center
                        currentCoordinateRegion.span = self.buildingZoomSpan
                        
                        self.mapView.setRegion(currentCoordinateRegion, animated: true)
                        self.mapView.addAnnotation(mapKitPlacemark)
                        
                        self.pinLocation = mapKitPlacemark
                }
            }
        }
    }
    
    override func cellDidExpand() {
        if completedNavigation == false {
            startNavigationAnimation()
            completedNavigation = true
        }
    }
    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        if let pinLocation = pinLocation {
//            let mapItem = MKMapItem(placemark: pinLocation)
//            mapItem.name = "Course Location"
//            mapItem.openInMapsWithLaunchOptions(nil)
//        }
//    }
}
