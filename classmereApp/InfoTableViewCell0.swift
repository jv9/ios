import UIKit

class InfoTableViewCell0: AbstractClassmereCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var buildingLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    
    func populateWithCourse(course: Course) {
        let section = course.courseSections[0]
        titleLabel.text = course.title?.capitalizedString
        timeLabel.text = InfoTableViewCell0.formatCourseTime(course)
        buildingLabel.text = InfoTableViewCell0.formatBuildingStringWithSection(section)
        dayLabel.text = section.days
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
        if let buildingName = section.buildingCode?.uppercaseString,
            roomNumber = section.roomNumber {
                return "\(buildingName) \(roomNumber)"
        } else {
            return "TBA"
        }
    }
}
