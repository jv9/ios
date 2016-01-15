import Foundation
import SwiftyJSON

struct Course {
    let title: String?
    let subjectCode: String?
    let courseNumber: Int?
    let credits: [Int]?
    let description: String?
    let abbr: String?

    var courseSections = [CourseSection]()

    init(courseJSON: JSON) {
        title = courseJSON["title"].string as String?
        subjectCode = courseJSON["subjectCode"].string as String?
        courseNumber = courseJSON["courseNumber"].intValue as Int?
        credits = courseJSON["credits"].arrayObject as! [Int]?
        description = courseJSON["description"].string as String?
        abbr = (subjectCode ?? "") + " " + String(courseNumber ?? 0)

        // If sections exist, for each section in JSON array, create a CourseSection object
        if let sectionArray = courseJSON["sections"].array {
            for theSection in sectionArray {
                let courseSection = CourseSection(sectionJSON: theSection)
                courseSections.append(courseSection)
            }
        }
    }
}
