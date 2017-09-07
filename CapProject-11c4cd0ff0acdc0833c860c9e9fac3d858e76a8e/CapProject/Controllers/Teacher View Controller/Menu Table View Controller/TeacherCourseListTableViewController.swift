//
//  TeacherCourseListTableViewController.swift
//  CapProject
//
//  Created by Yves Songolo on 8/21/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import UIKit

class TeacherCourseListTableViewController: UITableViewController {
    
    var course = [Course]()
    
        override func viewDidAppear(_ animated: Bool) {
        //self.configureTableView()
            CourseServices.fetchCourses(completion:{ (courseList) in
                self.course = courseList
                self.tableView.reloadData()
                self.configureTableView()
                Teacher.current.course = courseList
            })
            
            
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        
//        CourseServices.fetchCourses(completion:{ (courseList) in
//            self.course = courseList
//            self.tableView.reloadData()
//            self.configureTableView()
//            Teacher.current.course = courseList
//        })
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureTableView(){
        // remove separators for empty cells
        tableView.tableFooterView = UIView()
        // remove separators from cells
        tableView.separatorStyle = .none
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(Teacher.current.course.count)
        return self.course.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TeacherLIstOfCourseTableViewCell
        
        
        cell.classname.text = Teacher.current.course[indexPath.row].courseName
        
        print("cell \(cell.classname.text!)")
        
        cell.classSection.text = Teacher.current.course[indexPath.row].section
        let Nst = Teacher.current.course[indexPath.row].student.count
        
        cell.numberofStudent.text = String(Nst)
        
        return cell
    }
    
    
    
}
