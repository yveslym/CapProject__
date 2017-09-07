//
//  Attendance.swift
//  CapProject
//
//  Created by Yves Songolo on 8/8/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import Foundation
import Firebase
class Attendance: NSObject{
    
    private var date: Date?
    private var present: Bool = false
    private var late: Bool = false
    private var absent : Bool = false
    private var startTime = String()
    private var endTime = String()
    var AttendanceID  = String()
    
    func marckPresent(){return self.present = true}
    
    func markLate(){return self.late        = true}
    
    func markAbsent(){return self.absent    = true}
    
    override init(){
        self.absent  = false
        self.present = false
        self.late    = false
    }
    
    init?(snapshot: DataSnapshot) {
        
        guard let dict = snapshot.value as? [String: Any]
            
            else{return nil}
        
        self.AttendanceID = dict[Constants.AttendanceKey] as! String
         let abs = dict[Constants.absent] as! String
        self.absent = abs.toBool()!
        
        let pres = dict[Constants.present] as! String
        self.present = pres.toBool()!
        
        let late = dict[Constants.late] as! String
        self.late = late.toBool()!
        
        // add the time condition, if student scan in certain time he will be mark present or late
    }
}











