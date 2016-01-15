import Foundation
import Alamofire
import SwiftyJSON

struct APIService {

    static let baseURL = "http://api.classmere.com"

    static func getAllCourses(completion: (JSON) -> Void) -> Request {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        return Alamofire.request(.GET, "\(baseURL)/courses/")
            .responseJSON { response in
                switch response.result {
                case .Success(let data):
                    completion(JSON(data))
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                }
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
    }

    static func getCourseBySubjectCode(subjectCode: String,
        courseNumber: Int, completion: (JSON) -> Void) -> Request {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            return Alamofire.request(.GET, "\(baseURL)/courses/\(subjectCode)/\(courseNumber)")
                .responseJSON { response in
                    switch response.result {
                    case .Success(let data):
                        completion(JSON(data))
                    case .Failure(let error):
                        print("Request failed with error: \(error)")
                    }
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }
    }

    static func getLocationByAbbr(abbr: String,
        completion: (JSON) -> Void) -> Request {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            return Alamofire.request(.GET, "\(baseURL)/buildings/\(abbr)")
                .responseJSON { response in
                    switch response.result {
                    case .Success(let data):
                        completion(JSON(data))
                    case .Failure(let error):
                        print("Request failed with error: \(error)")
                    }
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }
    }

    static func searchCourse(searchQuery: String,
        completion: (JSON) -> Void) -> Request {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            let allowedCharacters = NSCharacterSet.URLQueryAllowedCharacterSet()
            let encodedSearchQuery = searchQuery
                .stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacters)!
            return Alamofire.request(.GET, "\(baseURL)/search/courses/\(encodedSearchQuery)")
                .responseJSON { response in
                    switch response.result {
                    case .Success(let data):
                        if response.response?.statusCode !== 200 {
                            print("Course not found: \(searchQuery)")
                            completion(nil)
                        } else {
                            completion(JSON(data))
                        }
                    case .Failure(let error):
                        print("Request failed with error: \(error)")
                        completion(nil)
                    }
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }
    }
}
