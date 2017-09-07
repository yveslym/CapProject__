//
//  StudentAddNewCourseViewController.swift
//  CapProject
//
//  Created by Yves Songolo on 8/24/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import UIKit

class StudentAddNewCourseViewController: UIViewController {

    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var section: UILabel!
    
    @IBOutlet weak var schedule: UILabel!
    
    @IBOutlet weak var firstday: UILabel!
    
    @IBOutlet weak var lastDay: UILabel!
    
    @IBOutlet weak var teacherName: UILabel!
    
    @IBOutlet weak var ScanCourse: UIButton!
    
   // var newcourse = Course()
    
   
    
    override func viewDidAppear(_ animated: Bool) {
        
        if Helpers.isScanned == true{
            
            CourseServices.fetchCourses(completion: {(course) in
              Student.current.course = course
            })
            
            if Student.current.course.count > 0{
            let course = Student.current.course[Student.current.course.count-1]
            self.name.text = course.courseName
            self.section .text = course.section
            //add schedule in course class
            
            StudentServices.retrieveTeacherName(Withuid: course.teacherID, completion: {(teacherName) in
                
                if teacherName != nil{
                    self.teacherName.text = teacherName
                }
            })
            self.name.isHidden = false
            self.section.isHidden = false
            self.teacherName.isHidden = false
            self.schedule.isHidden = false
            self.firstday.isHidden = false
            self.lastDay.isHidden = false
            
            //self.newcourse = course
            Helpers.isScanned = !Helpers.isScanned
        }
    }
    }
    
    
    @IBAction func scancourseTapped(_ sender: Any) {
        
      self.performSegue(withIdentifier: "scan", sender: self)
    }
    
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        
        let initialVC = UIStoryboard.initialViewController(for: .Teachermain)
        self.view.window?.rootViewController = initialVC
        self.view.window?.makeKeyAndVisible()
    }
  
    @IBAction func cancelCourse(_ sender: Any) {
        if  Student.current.course.count-1 > 0{
        Student.current.course.remove(at: Student.current.course.count-1)
            
            
        }
        let initialVC = UIStoryboard.initialViewController(for: .main)
        self.view.window?.rootViewController = initialVC
        self.view.window?.makeKeyAndVisible()

        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   

}
