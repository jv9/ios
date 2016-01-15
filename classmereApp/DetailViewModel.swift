import Foundation

class DetailViewModel {

    var course: Course

    init(course: Course) {
        self.course = course
    }
        
    
    func fetchBuildingDataForSections(sections: [CourseSection], completed: () -> Void) {
        var buildingsFetched = 0
        for section in sections {
            if let buildingCode = section.buildingCode {
                APIService.getLocationByAbbr(buildingCode) { buildingJSON in
                    let building = Building(buildingJSON: buildingJSON)
                    self.course.courseSections[0].building = building
                    buildingsFetched++
                    completed()
                }
            }
        }
    }
}
