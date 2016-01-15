import UIKit

class InfoTableViewCell2: AbstractClassmereCell {

    @IBOutlet weak var capacityLabel: UILabel!
    @IBOutlet weak var currentlyEnrolledLabel: UILabel!
    @IBOutlet weak var availableSpotsLabel: UILabel!
    @IBOutlet weak var crnLabel: UILabel!
    
    func populateWithCourse(course: Course) {
        let section = course.courseSections[0]
        
        if let capacity = section.capacity {
            capacityLabel.text = String(capacity)
        }
        
        if let currentEnrolled = section.currentEnrollment {
            currentlyEnrolledLabel.text = String(currentEnrolled)
        }
        
        if section.capacity != nil && section.currentEnrollment != nil {
            availableSpotsLabel.text = String(section.capacity! - section.currentEnrollment!)
        } else {
            availableSpotsLabel.text = ""
        }
        
        if let crn = section.crn {
            crnLabel.text = String(crn)
        }
    }
}
