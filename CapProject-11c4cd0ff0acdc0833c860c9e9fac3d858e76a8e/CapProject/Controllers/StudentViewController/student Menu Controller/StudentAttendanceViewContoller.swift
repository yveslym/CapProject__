//
//  StudentAttendanceViewContoller.swift
//  CapProject
//
//  Created by Yves Songolo on 8/10/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import UIKit
import SwiftQRCode

class StudentAttendanceViewContoller: UIViewController {
    
    @IBOutlet weak var course: UILabel!
    @IBOutlet weak var section: UILabel!
    @IBOutlet weak var teacher: UILabel!
    @IBOutlet weak var markImage: UIImageView!
    @IBOutlet weak var scanView: UIView!
    
    @IBAction func DoneButton(_ sender: Any) {
        let initialVC = UIStoryboard.initialViewController(for: .main)
        self.view.window?.rootViewController = initialVC
        self.view.window?.makeKeyAndVisible()
    }
    
    
    @IBAction func cancelButton(_ sender: Any) {
        let initialVC = UIStoryboard.initialViewController(for: .main)
        self.view.window?.rootViewController = initialVC
        self.view.window?.makeKeyAndVisible()
    }
    
    //scan
    let scanner = QRCode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scanner.prepareScan(view) { (stringValue) -> () in
            print(stringValue)
            
            var value = String(stringValue)!
            if value != ""{
            
                StudentServices.ScanAttendance(withAttendanceKey: stringValue, completion: {(course) in
                
                    self.course.text = course?.courseName
                    self.section.text = course?.section
                    self.markImage.isHidden = false
                    
                    StudentServices.retrieveTeacherName(Withuid: course?.teacherID, completion: {(name) in
                      
                        if name != nil{
                            self.teacher.text = name
                        }
                    })
                
                    
                })
            }
                value = ""
        }
        scanner.scanFrame = self.view.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // start scan
        scanner.startScan()
        
    }
}
