//
//  CloudTableViewCell.swift
//  classmereApp
//
//  Created by Brandon Lee on 6/8/16.
//  Copyright © 2016 Brandon Lee. All rights reserved.
//

import UIKit

class CloudTableViewCell: AbstractClassmereCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var buildingLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    /**
     Fill cell with specific course data.
     
     - Parameter course: The course object.
     - Returns: Nothing.
     */
    func populateWithCourse(course: Course) {
        let section = course.courseSections[0]
        titleLabel.text = course.title?.capitalizedString
        timeLabel.text = CloudTableViewCell.formatCourseTime(course)
        
        buildingLabel.text = CloudTableViewCell.formatBuildingStringWithSection(section)
        super.awakeFromNib()
    }
}
