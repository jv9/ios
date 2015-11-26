//
//  TodayTableViewCell.swift
//  classmere
//
//  Created by Rutger Farry on 10/22/15.
//  Copyright © 2015 Rutger Farry. All rights reserved.
//

import UIKit

class TodayTableViewCell: AbstractClassmereCell {

    let titleLabel = UILabel()
    let buildingLabel = UILabel()
    let timeLabel = UILabel()
    
    override func awakeFromNib() {
        titleLabel.constraints
        super.awakeFromNib()
        
        contentView.addSubview(titleLabel)
        
        let margins = layoutMarginsGuide
        
        titleLabel.topAnchor.constraintEqualToAnchor(margins.topAnchor).active = true
        titleLabel.leadingAnchor.constraintEqualToAnchor(margins.leadingAnchor).active = true
        titleLabel.trailingAnchor.constraintEqualToAnchor(margins.trailingAnchor).active = true
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
