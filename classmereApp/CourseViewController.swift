//
//  CourseViewController.swift
//  classmereApp
//
//  Created by Brandon Lee on 8/25/15.
//  Copyright (c) 2015 Brandon Lee. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

/**
 The view controller for viewing a specific course and its sections embedded in table view.
 */
class CourseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var creditsLabel: UILabel?
    @IBOutlet weak var descriptionLabel: UILabel?

    @IBOutlet weak var tableView: UITableView!

    var course: Course?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = course?.abbr
        tableView.delegate = self
        tableView.dataSource = self

        // TODO: A bit much to add into the view controller - the logic could be placed elsewhere...
        if let subjectCode = course?.subjectCode, courseNumber = course?.courseNumber {
            APIService.getCourseBySubjectCode(subjectCode,
                courseNumber: courseNumber) { courseJSON in
                    self.course = Course(courseJSON: courseJSON)
                    self.titleLabel?.text = self.course!.title!
                    self.descriptionLabel?.text = self.course!.description!
                    self.creditsLabel?.text = self.course!.credits!
                    self.tableView.reloadData()
            }
        }
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.flashScrollIndicators()
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return course?.courseSections.count ?? 0
    }

    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            
            // Configure the cell...
            guard let cell = tableView.dequeueReusableCellWithIdentifier("SectionCell",
                forIndexPath: indexPath) as? EmbeddedTableViewCell else {
                    return EmbeddedTableViewCell()
            }
            if let section = course?.courseSections[indexPath.row] {
                cell.termLabel?.text = section.term
                cell.startTimeLabel?.text = DataFormatter.timeStringFromDate(section.startTime)
                cell.endTimeLabel?.text = DataFormatter.timeStringFromDate(section.endTime)
                cell.instructorLabel?.text = section.instructor
            }
            return cell
    }

    // MARK: - Table view delegate

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showSection" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let navigationController = segue.destinationViewController as! UINavigationController
                let controller = navigationController.topViewController as! SectionViewController
                let theSection = course?.courseSections[indexPath.row]
                
                controller.detailViewModel = DetailViewModel(course: course!, courseSection: theSection!)
            }
        }
    }
    
    @IBAction func exitButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
