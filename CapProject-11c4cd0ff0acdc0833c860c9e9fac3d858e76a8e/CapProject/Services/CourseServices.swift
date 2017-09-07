//
//  CourseServices.swift
//  CapProject
//
//  Created by Yves Songolo on 8/15/17.
//  Copyright © 2017 Yveslym. All rights reserved.
//

import Foundation
import FirebaseDatabase

class CourseServices{
    
   
    /// function to create new course. the new course created is stored under teacher UID
    /// thus a single teacher can have multiple course stored. "this function is use by teacher"
    /// - Parameters:
    ///   - course: course get all the new course info that is need to be created
    ///   - completion: return a same course with a course key associate with this specific course
    static func create(withCoourse course: Course, completion: @escaping (Course?)->Void){
        
        let ref = Database.database().reference().child(Constants.course).child(NetworkConstant.currentUserUID!).childByAutoId()
        
        course.courseID = ref.key
        
        print(course.courseID!)
        
        
        let atts = [Constants.name: course.courseName, Constants.section : course.section,Constants.courseID : course.courseID, Constants.description : course.Description, Constants.teachers: Teacher.current.uid]
        
        ref.setValue(atts)
        
        return completion(course)

    }
    
    /// function to store new course. the new course is stored under teacher UID into course root
    /// thus a single teacher ID can have multiple course. "this function is use by student user"
    /// - Parameter course: this pass the course info that need to be stored and
    static func StoreCourse( course: Course!){
        
        let ref = Database.database().reference().child("course").child(NetworkConstant.currentUserUID!).child(course.courseID!)
        
        let atts = [Constants.name: course.courseName, Constants.section : course.section,Constants.courseID : course.courseID, Constants.description : course.Description, Constants.teachers: course.teacherID]
        
        ref.setValue(atts)
    }
    
    /// function to fetch course information
    ///
    /// - Parameters:
    ///   - UserKey: pass the user key (either teacher UID or student UID)
    ///   - courseKey: pass the course ID of the single course we need to fetch
    ///   - completion: return the course fetched from firebase
    static func fetchSingleCourse (UserKey: String!, courseKey: String!, completion: @escaping(Course!)-> Void){
        let ref = Database.database().reference().child("course").child(UserKey).child(courseKey)
        
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            
            let course = Course(snapshot: snapshot)
            if course?.courseID != ""{
                return completion(course)
                
            }
            else{
                return completion(nil)
            }
        })
    }
    
    /// function to retrieve all user courses(either teacher or student)
    /// - Parameter completion: return a list of courses
    static func fetchCourses(completion: @escaping ([Course])-> Void){
        
        let ref = Database.database().reference().child("course").child(NetworkConstant.currentUserUID!)
        
        ref.observeSingleEvent(of: .value, with: {(snapshot) in
            
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else {return completion([])}
            
            let courses = snapshot.reversed().flatMap(Course.init)
            
            completion(courses)
            
        })
    }

    static func createAttendance (withCourse course: Course, completion: @escaping (String?)->Void){
        
        let courseID = course.courseID
        
        let ref = Database.database().reference().child(Constants.course).child(Constants.attendance).childByAutoId()
        
        
        let key = ref.key  // get the key
        print("the key of new attendance is\(key)")
        let newAttendance = Attendance()
        newAttendance.AttendanceID = key // pass the key to new attendance
        course.listOfAttendance.append(key)
        course.attendance.append(newAttendance)
        
        ref.setValue([Constants.AttendanceKey:key])
        
        print ("attendance created")
        completion(key)
    }
}
































