//
//  TeacherAddStudentViewController.swift
//  CapProject
//
//  Created by Yves Songolo on 8/21/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class TeacherAddStudentViewController: UIViewController {

    
    @IBOutlet weak var codeview: UIImageView!
    @IBOutlet weak var selectCourse: UILabel!
    
   var courseName = [String]()
    var index = Int()
   
    
    @IBAction func cancel(_ sender: Any) {
        let initialVC = UIStoryboard.initialViewController(for: .Teachermain)
        self.view.window?.rootViewController = initialVC
        self.view.window?.makeKeyAndVisible()
    }
    
    
    @IBAction func StartGenerate(_ sender: Any) {
        
        TeacherServices.genrateQRCode(CourseIndex: index, iconView: codeview)
    }
    
    @IBAction func SelectCourse(_ sender: Any) {
        self.courseName = []
        
        CourseServices.fetchCourses(completion: {(listOfCourse) in
           
            for course in listOfCourse{
                self.courseName.append(course.courseName!)
            }
            Student.current.course = listOfCourse
        })
        
        ActionSheetStringPicker.show(withTitle: "Select Class", rows: self.courseName, initialSelection: 1, doneBlock: {
            
            picker, indexes, values in
            
            if indexes >= 0{
            
            self.selectCourse.text = values as? String
            self.index = indexes
            print("index: \(self.index)")
            
            return
            }
            else {
                print("index is less than 0, avoid out of bound // line 58")

            }
        }, cancel: {ActionSheetStringPicker in return }, origin: sender)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
