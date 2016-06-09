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

    // static let baseURL = "http://api.classmere.com"
    // Original Server
    static let baseURL = "http://104.236.187.221"
    static let cloudPushURL = "http://159.203.253.52:3000/push"
    static let cloudPullURL = "http://159.203.253.52:3000/pull"
    
    /**
     Prints out alert message when a network event occurs
     
     - Parameter message: A message to print out
    */
    static func showAlert(message: String) {
        let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .Alert)
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
                    showAlert("Network Error - The internet connection appears to be offline.")
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
                        showAlert("Network Error - The internet connection appears to be offline.")
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
                        showAlert("Network Error - The internet connection appears to be offline.")
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
                        showAlert("Network Error - The internet connection appears to be offline.")
                        completion(nil)
                    }
                    UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }
    }
    
    static func getCourseCloud(completion: (JSON) -> Void) -> Request {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        return Alamofire.request(.GET, cloudPullURL)
            .responseJSON { response in
                switch response.result {
                case .Success(let data):
                    completion(JSON(data))
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                    showAlert("Network Error - The internet connection appears to be bad.")
                }
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
    }
    
    static func sendCourseCloud(courseSubjectCode: String, courseNumber: Int, completion: (JSON) -> Void) -> Request {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        let newCourse = ["subjectCode": courseSubjectCode, "courseNumber": courseNumber]
        return Alamofire.request(.POST, cloudPushURL, parameters: (newCourse as! [String : AnyObject]), encoding: .JSON)
            .responseJSON { response in
                switch response.result {
                case .Success(let data):
                    if response.response?.statusCode !== 200 {
                        showAlert("Error - Status Code: \(response.response!.statusCode)")
                        completion(nil)
                    } else {
                        showAlert("Success - Status Code: \(response.response!.statusCode)")
                        completion(JSON(data))
                    }
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                    showAlert("Network Failure!")
                }
                
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
    }
}
