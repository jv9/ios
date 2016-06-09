//
//  APIService.swift
//  classmereApp
//
//  Created by Brandon Lee on 8/25/15.
//  Copyright (c) 2015 Brandon Lee. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

/**
 A representation of Classmere's API service.
 Reference Docs - https://github.com/classmere/api
 */
struct APIService {

//    static let baseURL = "http://api.classmere.com"
    static let baseURL = "http://104.236.187.221"
    
    /**
     Prints out alert message when a network error occurs
     
     - Parameter theError: An error message to print out
    */
    static func showAlert(theError: NSError) {
        let alertController = UIAlertController(title: "Network Error", message: "Request failed with error: \(theError)", preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(alertController, animated: true, completion: nil)
    }
    
    /**
    Fetches all courses at OSU in a single request.
     
    - Parameter completion: A callback that accepts JSON.
    - Returns: Request.
    */
    static func getAllCourses(completion: (JSON) -> Void) -> Request {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        return Alamofire.request(.GET, "\(baseURL)/courses/")
            .responseJSON { response in
                switch response.result {
                case .Success(let data):
                    completion(JSON(data))
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                    showAlert(error)
                }
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
    }

    /**
     Fetches a specific course at OSU by its subject code.
     
     - Parameter subjectCode: The first part of the course abbreviation.
     - Parameter courseNumber: The number ID of the particular course.
     - Parameter completion: A callback that accepts JSON.
     - Returns: Request.
     */
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
                        showAlert(error)
                    }
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }
    }

    /**
     Fetches a specific location at OSU by course's abbreviation.
     
     - Parameter abbr: The course's abbreviation.
     - Parameter completion: A callback that accepts JSON.
     - Returns: Request.
     */
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
                        showAlert(error)
                    }
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }
    }

    /**
     Fetches a specific course at OSU by a user inputted query.
     
     - Parameter searchQuery: The user inputted query.
     - Parameter completion: A callback that accepts JSON.
     - Returns: Request.
     */
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
                        showAlert(error)
                        completion(nil)
                    }
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }
    }
}
