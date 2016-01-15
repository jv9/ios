import Foundation
import Alamofire

class SearchViewModel {
    var courses = [Course]()
    var currentRequest: Request?

    func fetchSearchCourses(query: String, completed: () -> Void) {
        if let currentRequest = currentRequest {
            currentRequest.cancel()
        }
        currentRequest = APIService.searchCourse(query) { coursesJSON in
            self.courses.removeAll(keepCapacity: true)
            for (_, courseJSON) in coursesJSON {
                let course = Course(courseJSON: courseJSON)
                self.courses.append(course)
                completed()
            }
        }
    }
}
