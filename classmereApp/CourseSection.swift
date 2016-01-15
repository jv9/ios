import Foundation
import SwiftyJSON

struct CourseSection {
    let term: String?
    let crn: Int?
    let instructor: String?

    // Within the meetingTimes array
    let buildingCode: String?
    let days: String?
    let startTime: NSDate?
    let endTime: NSDate?
    let roomNumber: String?

    let type: String?
    let status: String?
    let capacity: Int?
    let currentEnrollment: Int?
    let waitlistCurrent: Int?
    let fees: String?
    let restrictions: String?

    var building: Building?

    init(sectionJSON: JSON) {
        term = sectionJSON["term"].string as String?
        crn = sectionJSON["crn"].intValue as Int?
        instructor = sectionJSON["instructor"].string as String?

        if let meetingTimes = sectionJSON["meetingTimes"].array {
            buildingCode = meetingTimes[0]["buildingCode"].string
            days = meetingTimes[0]["days"].string
            startTime = CourseSection.dateFromISO8601String(meetingTimes[0]["startTime"].string)
            endTime = CourseSection.dateFromISO8601String(meetingTimes[0]["endTime"].string)
            roomNumber = meetingTimes[0]["roomNumber"].string
        } else {
            buildingCode = nil
            days = nil
            startTime = nil
            endTime = nil
            roomNumber = nil
        }

        type = sectionJSON["type"].string as String?
        status = sectionJSON["status"].string as String?
        fees = sectionJSON["fees"].string as String?
        restrictions = sectionJSON["restrictions"].string as String?
        waitlistCurrent = sectionJSON["waitlistcurrent"].intValue as Int?
        currentEnrollment = sectionJSON["currentEnrollment"].intValue as Int?
        capacity = sectionJSON["capacity"].intValue as Int?
    }

    /**
        Converts string returned in JSON to a NSDate.
        Offsets time by -7 hours since API returns GMT timezone
     */

    static func dateFromISO8601String(iso8601String: String?) -> NSDate? {
        if let iso8601String = iso8601String {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-DD'T'HH:mm:ssZ"
            let date = dateFormatter.dateFromString(iso8601String)
            let subtractSevenHours = NSTimeInterval(60*60*7)
            let offsetDate = date?.dateByAddingTimeInterval(subtractSevenHours)
            return offsetDate
        }
        return nil
    }
}
