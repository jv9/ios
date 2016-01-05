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
    let bottomStackView = UIStackView()
    
    let titleLabel = ClassmereCellLabel()
    let timeLabel = ClassmereCellLabel()
    let buildingLabel = ClassmereCellLabel()
    
    let descriptionLabel = ClassmereCellLabel()
    let instructorLabel = ClassmereCellLabel()
    
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
        
        styleTopSubviews()
        styleMiddleSubviews()
        styleBottomSubviews()
    }
    
    func layoutTopSubviews() {
        let margins = topView.layoutMarginsGuide
        topView.layoutMargins = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        
        topView.addSubview(mapView)
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraintEqualToAnchor(margins.topAnchor).active = true
        mapView.bottomAnchor.constraintEqualToAnchor(margins.bottomAnchor).active = true
        mapView.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor).active = true
        mapView.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor).active = true
    }
    
    func layoutMiddleSubviews() {
        let margins = middleView.layoutMarginsGuide
        
        middleView.addSubview(middleStackView)
        middleStackView.translatesAutoresizingMaskIntoConstraints = false
        middleStackView.topAnchor.constraintEqualToAnchor(margins.topAnchor).active = true
        middleStackView.bottomAnchor.constraintEqualToAnchor(margins.bottomAnchor).active = true
        middleStackView.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor).active = true
        middleStackView.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor).active = true
        
        middleStackView.axis = .Vertical
        middleStackView.distribution = .FillEqually
        
        middleStackView.addArrangedSubview(titleLabel)
        middleStackView.addArrangedSubview(timeLabel)
        middleStackView.addArrangedSubview(buildingLabel)
    }
    
    func layoutBottomSubviews() {
        let margins = bottomView.layoutMarginsGuide
        
        bottomView.addSubview(bottomStackView)
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.topAnchor.constraintEqualToAnchor(margins.topAnchor).active = true
        bottomStackView.bottomAnchor.constraintEqualToAnchor(margins.bottomAnchor).active = true
        bottomStackView.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor).active = true
        bottomStackView.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor).active = true
        
        bottomStackView.axis = .Vertical
        bottomStackView.distribution = .FillEqually
        
        bottomStackView.addArrangedSubview(descriptionLabel)
        bottomStackView.addArrangedSubview(instructorLabel)
    }
    
    // MARK: - Style Subviews
    
    func styleTopSubviews() {
        let schoolCoordinates = CLLocationCoordinate2D(
            latitude: schoolLatitude,
            longitude: schoolLongitude)
        let schoolCoordinateRegion = MKCoordinateRegion(
            center: schoolCoordinates,
            span: schoolZoomSpan)
        mapView.setRegion(schoolCoordinateRegion, animated: false)
    }
    
    func styleMiddleSubviews() {

    }
    
    func styleBottomSubviews() {
        descriptionLabel.textLabel.numberOfLines = 5
    }

    func populateWithCourse(course: Course) {
        let section = course.courseSections[0]
        
        buildingAddress = section.building?.address
        
        titleLabel.text = course.title?.capitalizedString
        titleLabel.type = .Title
        timeLabel.text = TodayTableViewCell.formatCourseTime(course)
        timeLabel.type = .Time
        buildingLabel.text = TodayTableViewCell.formatBuildingStringWithSection(section)
        buildingLabel.type = .Building
        
        descriptionLabel.text = course.description
        descriptionLabel.type = .Description
        instructorLabel.text = section.instructor
        instructorLabel.type = .Instructor
        
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
