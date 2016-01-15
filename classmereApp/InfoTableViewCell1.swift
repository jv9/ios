import UIKit

class InfoTableViewCell1: AbstractClassmereCell {
    
    @IBOutlet weak var instructorLabel: UILabel!
    @IBOutlet weak var termLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    func populateWithCourse(course: Course) {
        let section = course.courseSections[0]
        instructorLabel.text = section.instructor
        termLabel.text = section.term
        typeLabel.text = section.type
    }
}
